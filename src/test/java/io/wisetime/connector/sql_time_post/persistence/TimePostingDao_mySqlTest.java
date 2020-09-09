/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.persistence;

import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SQLPostTimeConnectorConfigKey.DB_PASSWORD;
import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SQLPostTimeConnectorConfigKey.DB_USER;
import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SQLPostTimeConnectorConfigKey.JDBC_URL;
import static io.wisetime.connector.sql_time_post.ConnectorLauncher.SQLPostTimeConnectorConfigKey.TIME_POST_SQL_PATH;

import com.google.common.base.Preconditions;
import com.google.inject.Guice;
import com.google.inject.Injector;
import io.wisetime.connector.config.RuntimeConfig;
import io.wisetime.connector.sql_time_post.ConnectorLauncher;
import io.wisetime.connector.sql_time_post.persistence.TimePostingDaoTestHelper.FluentJdbcTestDbModule;
import io.wisetime.connector.sql_time_post.persistence.TimePostingDaoTestHelper.FlywayTestDbModule;
import io.wisetime.test_docker.ContainerRuntimeSpec;
import io.wisetime.test_docker.DockerLauncher;
import io.wisetime.test_docker.containers.MySqlServer;
import java.util.Objects;
import org.flywaydb.core.Flyway;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/**
 * @author dchandler
 */
class TimePostingDao_mySqlTest {

  private static TimePostingDaoTestHelper timePostingDaoTestHelper;

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
    timePostingDaoTestHelper.doesUserExist(123);
  }

  @Test
  void doesMatterExist() {
    timePostingDaoTestHelper.doesMatterExist(100);
  }

  @Test
  void doesActivityCodeExist() {
    timePostingDaoTestHelper.doesActivityCodeExist();
  }

  @Test
  void createWorklog() {
    timePostingDaoTestHelper.createWorklog();
  }
}
