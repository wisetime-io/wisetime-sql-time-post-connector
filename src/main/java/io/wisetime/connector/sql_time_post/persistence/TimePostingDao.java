/*
 * Copyright (c) 2019 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.persistence;

import com.google.inject.Inject;

import com.zaxxer.hikari.HikariDataSource;

import io.wisetime.connector.sql_time_post.ConnectorLauncher;
import io.wisetime.connector.sql_time_post.model.PostQueries;
import io.wisetime.connector.config.RuntimeConfig;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import org.codejargon.fluentjdbc.api.FluentJdbc;
import org.codejargon.fluentjdbc.api.FluentJdbcBuilder;
import org.codejargon.fluentjdbc.api.mapper.Mappers;
import org.codejargon.fluentjdbc.api.query.Query;

import io.wisetime.connector.sql_time_post.model.Worklog;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.Constructor;

/**
 * DAO for posting time to the connected database. Queries are loaded from yaml file.
 *
 * @author pascal
 */
public class TimePostingDao {

  private final FluentJdbc fluentJdbc;
  private final HikariDataSource dataSource;
  private final PostQueries queries;

  @Inject
  public TimePostingDao(HikariDataSource dataSource) {
    this.dataSource = dataSource;
    this.fluentJdbc = new FluentJdbcBuilder().connectionProvider(dataSource).build();

    String sqlPath = RuntimeConfig.getString(ConnectorLauncher.SQLPostTimeConnectorConfigKey.TIME_POST_SQL_PATH)
        .orElseThrow(() -> new IllegalStateException("TIME_POST_SQL_PATH must be set"));

    try {
      final Stream<String> lines = Files.lines(Paths.get(sqlPath));
      final String contents = lines.collect(Collectors.joining("\n"));
      lines.close();

      final Yaml yaml = new Yaml(new Constructor(PostQueries.class));
      queries = yaml.load(contents);
    } catch (IOException e) {
      throw  new IllegalStateException("Error loading time post queries");
    }
  }

  public void asTransaction(final Runnable runnable) {
    query().transaction().inNoResult(runnable);
  }

  public Optional<String> findUserId(String emailOrExternalId) {
    return query().select(queries.getFindUserId())
        .namedParam("emailOrExternalId", emailOrExternalId)
        .firstResult(Mappers.singleString());
  }

  public Optional<String> findCaseIdByTagName(String tagName) {
    return query().select(queries.getFindCaseIdByTagName())
        .namedParam("irn", tagName)
        .firstResult(Mappers.singleString());
  }

  public boolean doesActivityCodeExist(String activityCode) {
    return query().select(queries.getDoesActivityCodeExist())
        .namedParam("activityCode", activityCode)
        .maxRows(1L)
        .firstResult(rs -> rs)
        .isPresent();
  }

  public void createWorklog(Worklog worklog) {
    query().update(queries.getCreateWorklog())
        .namedParam("caseId", worklog.getCaseId())
        .namedParam("userId", worklog.getUserId())
        .namedParam("activityCode", worklog.getActivityCode())
        .namedParam("narrative", worklog.getNarrative())
        .namedParam("narrativeInternal", worklog.getNarrativeInternal())
        .namedParam("startTime", worklog.getStartTime())
        .namedParam("durationSecs", worklog.getDurationSeconds())
        .namedParam("chargeableTimeSecs", worklog.getChargeableTimeSeconds())
        .run();
  }

  public boolean canQueryDb() {
    try {
      query().select(queries.getCanQueryDb()).firstResult(Mappers.singleString());
      return true;
    } catch (Exception ex) {
      return false;
    }
  }

  private Query query() {
    return fluentJdbc.query();
  }

  public void shutdown() {
    dataSource.close();
  }
}
