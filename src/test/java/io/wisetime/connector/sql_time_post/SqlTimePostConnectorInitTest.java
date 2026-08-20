/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All rights reserved.
 */

package io.wisetime.connector.sql_time_post;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.reset;

import com.google.inject.Guice;
import com.google.inject.Injector;
import io.wisetime.connector.ConnectorModule;
import io.wisetime.connector.api_client.ApiClient;
import io.wisetime.connector.config.RuntimeConfig;
import io.wisetime.connector.datastore.ConnectorStore;
import io.wisetime.connector.sql_time_post.ConnectorLauncher.SqlPostTimeConnectorConfigKey;
import io.wisetime.connector.sql_time_post.persistence.TimePostingDao;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * @author pascal
 */
@SuppressWarnings("ConstantName")
class SqlTimePostConnectorInitTest {

  private static final TimePostingDao postTimeDaoMock = mock(TimePostingDao.class);
  private static final ApiClient apiClientMock = mock(ApiClient.class);
  private static final ConnectorStore connectorStoreMock = mock(ConnectorStore.class);

  private static SqlTimePostConnector connector;

  @BeforeAll
  static void setUp() {
    Injector injector = Guice.createInjector(binder -> {
      binder.bind(TimePostingDao.class).toProvider(() -> postTimeDaoMock);
    });
    connector = injector.getInstance(SqlTimePostConnector.class);
  }

  @BeforeEach
  void setUpTest() {
    reset(apiClientMock);
    reset(connectorStoreMock);
  }

  @Test
  void init_should_initialized_when_required_params_exist() {
    final String fileLocation = getClass().getClassLoader()
        .getResource("timegroup-narrative-template.ftl").getPath();
    RuntimeConfig.setProperty(SqlPostTimeConnectorConfigKey.NARRATIVE_PATH, fileLocation);
    final String sqlFileLocation = getClass().getClassLoader()
        .getResource("db_schema/sqlserver/time_post_sql.yaml").getPath();
    RuntimeConfig.setProperty(SqlPostTimeConnectorConfigKey.TIME_POST_SQL_PATH, sqlFileLocation);
    RuntimeConfig.setProperty(SqlPostTimeConnectorConfigKey.TAG_UPSERT_PATH, "/SomePath/");
    connector.init(new ConnectorModule(apiClientMock, connectorStoreMock, 5));
  }

  @Test
  void getConnectorType_should_not_be_changed() {
    assertThat(connector.getConnectorType())
        .as("Connector returns the expected connector type")
        .isEqualTo("wisetime-sql-time-post-connector");
  }
}
