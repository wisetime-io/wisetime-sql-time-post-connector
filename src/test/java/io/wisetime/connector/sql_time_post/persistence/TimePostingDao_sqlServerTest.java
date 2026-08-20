/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.persistence;

import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SqlPostTimeConnectorConfigKey.DB_PASSWORD;
import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SqlPostTimeConnectorConfigKey.DB_USER;
import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SqlPostTimeConnectorConfigKey.JDBC_URL;
import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SqlPostTimeConnectorConfigKey.TIME_POST_SQL_PATH;
import static org.assertj.core.api.Assertions.assertThat;

import com.github.javafaker.Faker;
import com.google.inject.Guice;
import com.google.inject.Injector;
import io.wisetime.connector.config.RuntimeConfig;
import io.wisetime.connector.sql_time_post.ConnectorLauncher;
import io.wisetime.connector.sql_time_post.PlainSqlServer;
import io.wisetime.connector.sql_time_post.fake.FakeTimeGroupGenerator;
import io.wisetime.connector.sql_time_post.persistence.TimePostingDaoTestHelper.FluentJdbcTestDbModule;
import io.wisetime.generated.connect.User;
import io.wisetime.test_docker.ContainerRuntimeSpec;
import io.wisetime.test_docker.DockerLauncher;
import lombok.Data;
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
  void handleInvalidActivityCode() {
    final String invalidActivityCode = "123abc";
    assertThat(postTimeDao.doesActivityCodeExist(invalidActivityCode))
        .as("In some cases where the configured query may expect the code in a different format it should not"
            + " throw an exception and show the exception message to the user. In this particular test the configured"
            + " query expects the code to be a numeric value.")
        .isFalse();
  }

  @Test
  void createWorklog() {
    final User user = fakeTimeGroupGenerator.randomUser();
    final int userId = faker.number().numberBetween(1000, 5000);
    timePostingDaoTestHelper.createEmployee(userId, user.getEmail(), user.getExternalId());
    timePostingDaoTestHelper.createWorklog(userId, user);
  }

  private static JdbcDatabaseContainer getSqlServerContainer() {
    PlainSqlServer containerDefinition = new PlainSqlServer();
    ContainerRuntimeSpec container = DockerLauncher.instance().createContainer(containerDefinition);
    return new JdbcDatabaseContainer(container, containerDefinition.getUsername(), containerDefinition.getPassword());
  }

  @Data
  private static class JdbcDatabaseContainer {

    private final String jdbcUrl;
    private final String username;
    private final String password;

    JdbcDatabaseContainer(ContainerRuntimeSpec containerSpec, String username, String password) {
      jdbcUrl = String.format("jdbc:sqlserver://%s:%d",
          containerSpec.getContainerIpAddress(),
          containerSpec.getRequiredMappedPort(1433));
      this.username = username;
      this.password = password;
    }
  }
}
