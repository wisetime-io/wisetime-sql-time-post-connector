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
import io.wisetime.test_docker.ContainerRuntimeSpec;
import io.wisetime.test_docker.DockerLauncher;
import io.wisetime.test_docker.containers.Postgres;
import java.util.Objects;
import org.flywaydb.core.Flyway;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/**
 * @author dchandler
 */
class TimePostingDao_postgresTest {

  private static TimePostingDaoTestHelper timePostingDaoTestHelper;

  @BeforeAll
  static void setUp() {
    final ContainerRuntimeSpec container = DockerLauncher.instance().createContainer(new Postgres());

    final String jdbcUrl = String.format("jdbc:postgresql://%s:%d/dockerdb",
        container.getContainerIpAddress(),
        container.getRequiredMappedPort(5432));

    final String fileLocation = Objects.requireNonNull(TimePostingDao_postgresTest.class
        .getClassLoader()
        .getResource("db_schema/postgres/time_post_sql.yaml"))
        .getPath();

    RuntimeConfig.setProperty(TIME_POST_SQL_PATH, fileLocation);
    RuntimeConfig.setProperty(JDBC_URL, jdbcUrl);
    RuntimeConfig.setProperty(DB_USER, "docker");
    RuntimeConfig.setProperty(DB_PASSWORD, "docker");

    final Injector injector = Guice.createInjector(
        new ConnectorLauncher.DbModule(),
        new TimePostingDaoTestHelper.FlywayTestDbModule("db_schema/postgres/"),
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
    timePostingDaoTestHelper.doesUserExist(675);
  }

  @Test
  void doesMatterExist() {
    timePostingDaoTestHelper.doesMatterExist(600);
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
