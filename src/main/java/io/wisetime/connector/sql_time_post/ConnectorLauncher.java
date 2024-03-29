/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post;

import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import io.wisetime.connector.ConnectorController;
import io.wisetime.connector.config.RuntimeConfig;
import io.wisetime.connector.config.RuntimeConfigKey;
import io.wisetime.connector.sql_time_post.model.TimePostingQueries;
import io.wisetime.connector.sql_time_post.util.TimePostingQueriesProvider;
import java.util.concurrent.TimeUnit;

/**
 * Connector application entry point.
 *
 * @author pascal
 */
public class ConnectorLauncher {

  public static void main(final String... args) throws Exception {
    ConnectorController connectorController = buildConnectorController();
    connectorController.start();
  }

  public static ConnectorController buildConnectorController() {
    return ConnectorController.newBuilder()
        .disableTagScan()
        .withWiseTimeConnector(Guice.createInjector(new DbModule()).getInstance(SqlTimePostConnector.class))
        .build();
  }

  /**
   * Configuration keys for the Connector.
   *
   * @author pascal
   */
  public enum SqlPostTimeConnectorConfigKey implements RuntimeConfigKey {

    JDBC_URL("JDBC_URL"),
    DB_USER("DB_USER"),
    DB_PASSWORD("DB_PASSWORD"),
    TAG_UPSERT_PATH("TAG_UPSERT_PATH"),
    TIMEZONE("TIMEZONE"),
    NARRATIVE_PATH("NARRATIVE_PATH"),
    NARRATIVE_INTERNAL_PATH("NARRATIVE_INTERNAL_PATH"),
    TIME_POST_SQL_PATH("TIME_POST_SQL_PATH"),
    ACTIVITY_TYPE_MANDATORY("ACTIVITY_TYPE_MANDATORY");

    private final String configKey;

    SqlPostTimeConnectorConfigKey(final String configKey) {
      this.configKey = configKey;
    }

    @Override
    public String getConfigKey() {
      return configKey;
    }
  }

  /**
   * Bind the database connection via DI.
   */
  public static class DbModule extends AbstractModule {

    @Override
    protected void configure() {
      final HikariConfig hikariConfig = new HikariConfig();

      hikariConfig.setJdbcUrl(
          RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.JDBC_URL)
              .orElseThrow(() -> new RuntimeException("Missing required JDBC_URL configuration"))
      );

      hikariConfig.setUsername(
          RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.DB_USER)
              .orElseThrow(() -> new RuntimeException("Missing required DB_USER configuration"))
      );

      hikariConfig.setPassword(
          RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.DB_PASSWORD)
              .orElseThrow(() -> new RuntimeException("Missing required DB_PASSWORD configuration"))
      );
      hikariConfig.setConnectionTimeout(TimeUnit.MINUTES.toMillis(1));
      hikariConfig.setMaximumPoolSize(10);

      bind(HikariDataSource.class).toInstance(new HikariDataSource(hikariConfig));

      bind(TimePostingQueries.class).toProvider(TimePostingQueriesProvider.class);
    }

  }
}
