/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.persistence;

import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SqlPostTimeConnectorConfigKey.DB_PASSWORD;
import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SqlPostTimeConnectorConfigKey.DB_USER;
import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SqlPostTimeConnectorConfigKey.JDBC_URL;
import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SqlPostTimeConnectorConfigKey.TIME_POST_SQL_PATH;

import com.github.javafaker.Faker;
import com.google.common.base.Preconditions;
import com.google.inject.Guice;
import com.google.inject.Injector;
import io.wisetime.connector.config.RuntimeConfig;
import io.wisetime.connector.sql_time_post.ConnectorLauncher;
import io.wisetime.connector.sql_time_post.MySqlServer;
import io.wisetime.connector.sql_time_post.fake.FakeTimeGroupGenerator;
import io.wisetime.connector.sql_time_post.persistence.TimePostingDaoTestHelper.FluentJdbcTestDbModule;
import io.wisetime.connector.sql_time_post.persistence.TimePostingDaoTestHelper.FlywayTestDbModule;
import io.wisetime.generated.connect.User;
import io.wisetime.test_docker.ContainerRuntimeSpec;
import io.wisetime.test_docker.DockerLauncher;
import java.util.Objects;
import org.flywaydb.core.Flyway;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/**
 * @author dchandler
 */
class TimePostingDao_mySqlTest {

  private static final String USER_EMAIL_DOMAIN = "@mysql.test.com";

  private static TimePostingDaoTestHelper timePostingDaoTestHelper;

  private final FakeTimeGroupGenerator fakeTimeGroupGenerator = new FakeTimeGroupGenerator();

  private final Faker faker = new Faker();

  @BeforeAll
  static void setUp() {
    final MySqlServer mySqlServer = new MySqlServer();
    final ContainerRuntimeSpec container = DockerLauncher.instance().createContainer(mySqlServer);
    final String jdbcUrl = mySqlServer.getJdbcUrl(container);

    final String fileLocation = Objects.requireNonNull(TimePostingDao_mySqlTest.class
        .getClassLoader()
        .getResource("db_schema/mysql/time_post_sql.yaml"))
        .getPath();
    RuntimeConfig.setProperty(TIME_POST_SQL_PATH, fileLocation);
    RuntimeConfig.setProperty(JDBC_URL, jdbcUrl);
    RuntimeConfig.setProperty(DB_USER, mySqlServer.getUsername());
    RuntimeConfig.setProperty(DB_PASSWORD, mySqlServer.getPassword());

    final Injector injector = Guice.createInjector(
        new ConnectorLauncher.DbModule(),
        new FlywayTestDbModule("db_schema/mysql/"),
        new FluentJdbcTestDbModule());

    timePostingDaoTestHelper = injector.getInstance(TimePostingDaoTestHelper.class);

    Preconditions.checkState(
        // we don't want to accidentally truncate production tables
        RuntimeConfig.getString(JDBC_URL)
            .orElse("")
            .equals(jdbcUrl));

    // apply DB schema to test db
    injector.getInstance(Flyway.class).migrate();
  }

  @Test
  void canQueryDb() {
    timePostingDaoTestHelper.assertCanQueryDb();
  }

  @Test
  void doesUserExist() {
    final int userId = faker.number().numberBetween(1000, 5000);
    final User user = fakeTimeGroupGenerator.randomUser();
    user.setEmail(user.getExternalId() + USER_EMAIL_DOMAIN);
    timePostingDaoTestHelper.doesUserExist(userId, user);
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
    user.setEmail(user.getExternalId() + USER_EMAIL_DOMAIN);

    final int userId = faker.number().numberBetween(1000, 5000);
    timePostingDaoTestHelper.createUserIdentity(userId, user.getExternalId());
    timePostingDaoTestHelper.createWorklog(userId, user);
  }
}
