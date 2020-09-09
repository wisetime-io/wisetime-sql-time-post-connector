/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.persistence;

import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SQLPostTimeConnectorConfigKey.DB_PASSWORD;
import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SQLPostTimeConnectorConfigKey.DB_USER;
import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SQLPostTimeConnectorConfigKey.JDBC_URL;
import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SQLPostTimeConnectorConfigKey.TIME_POST_SQL_PATH;
import static org.assertj.core.api.Assertions.assertThat;

import com.github.javafaker.Faker;
import com.google.inject.Guice;
import com.google.inject.Injector;
import io.wisetime.connector.config.RuntimeConfig;
import io.wisetime.connector.sql_time_post.ConnectorLauncher;
import io.wisetime.connector.sql_time_post.fake.FakeTimeGroupGenerator;
import io.wisetime.connector.sql_time_post.persistence.TimePostingDaoTestHelper.FluentJdbcTestDbModule;
import io.wisetime.generated.connect.User;
import io.wisetime.test_docker.ContainerRuntimeSpec;
import io.wisetime.test_docker.DockerLauncher;
import io.wisetime.test_docker.containers.SqlServer;
import org.flywaydb.core.Flyway;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/**
 * @author pascal
 * @author dchandler
 */
class TimePostingDao_sqlServerTest {

  private static TimePostingDao postTimeDao;

  private static TimePostingDaoTestHelper timePostingDaoTestHelper;

  private final FakeTimeGroupGenerator fakeTimeGroupGenerator = new FakeTimeGroupGenerator();

  private final Faker faker = new Faker();

  @BeforeAll
  static void setUp() throws InterruptedException {
    final JdbcDatabaseContainer sqlServerContainer = getSqlServerContainer();

    final String fileLocation = TimePostingDao_sqlServerTest.class
        .getClassLoader()
        .getResource("db_schema/sqlserver/time_post_sql.yaml")
        .getPath();

    RuntimeConfig.setProperty(TIME_POST_SQL_PATH, fileLocation);
    RuntimeConfig.setProperty(JDBC_URL, sqlServerContainer.getJdbcUrl());
    RuntimeConfig.setProperty(DB_USER, sqlServerContainer.getUsername());
    RuntimeConfig.setProperty(DB_PASSWORD, sqlServerContainer.getPassword());

    // SQL Server often needs more time to start
    Thread.sleep(30000);
    final Injector injector = Guice.createInjector(
        new ConnectorLauncher.DbModule(),
        new TimePostingDaoTestHelper.FlywayTestDbModule("db_schema/sqlserver/"),
        new FluentJdbcTestDbModule());

    postTimeDao = injector.getInstance(TimePostingDao.class);
    timePostingDaoTestHelper = injector.getInstance(TimePostingDaoTestHelper.class);

    // Apply DB schema to test db
    injector.getInstance(Flyway.class).migrate();
  }

  @Test
  void canQueryDb() {
    timePostingDaoTestHelper.assertCanQueryDb();
  }

  @Test
  void doesUserExist() {
    final User user = fakeTimeGroupGenerator.randomUser();
    final int userId = faker.number().numberBetween(1000, 5000);
    assertThat(postTimeDao.findUserId(user.getEmail()))
        .as("User not in DB")
        .isEmpty();

    // add user in DB
    timePostingDaoTestHelper.createEmployee(userId, user.getEmail(), user.getExternalId());
    assertThat(postTimeDao.findUserId(user.getEmail()))
        .as("User is in DB")
        .contains(userId + "");
  }

  @Test
  void doesMatterExist() {
    final int caseId = faker.number().numberBetween(1000, 5000);
    timePostingDaoTestHelper.doesMatterExist(caseId);
  }

  @Test
  void doesActivityCodeExist() {
    timePostingDaoTestHelper.doesActivityCodeExist();
  }

  @Test
  void createWorklog() {
    final User user = fakeTimeGroupGenerator.randomUser();
    final int userId = faker.number().numberBetween(1000, 5000);
    timePostingDaoTestHelper.createEmployee(userId, user.getEmail(), user.getExternalId());
    timePostingDaoTestHelper.createWorklog(userId, user);
  }

  private static JdbcDatabaseContainer getSqlServerContainer() {
    ContainerRuntimeSpec container = DockerLauncher.instance().createContainer(new SqlServer());
    return new JdbcDatabaseContainer(container);
  }

  private static class JdbcDatabaseContainer {
    private final String jdbcUrl;

    JdbcDatabaseContainer(ContainerRuntimeSpec containerSpec) {
      jdbcUrl = String.format("jdbc:sqlserver://%s:%d",
          containerSpec.getContainerIpAddress(),
          containerSpec.getRequiredMappedPort(1433));
    }

    String getJdbcUrl() {
      return jdbcUrl;
    }

    String getUsername() {
      return "SA";
    }

    String getPassword() {
      return "A_Str0ng_Required_Password";
    }
  }
}
