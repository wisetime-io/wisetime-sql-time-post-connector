/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.persistence;

import com.google.inject.Inject;

import com.zaxxer.hikari.HikariDataSource;

import io.wisetime.connector.sql_time_post.model.TimePostingQueries;
import java.util.Optional;
import org.codejargon.fluentjdbc.api.FluentJdbc;
import org.codejargon.fluentjdbc.api.FluentJdbcBuilder;
import org.codejargon.fluentjdbc.api.mapper.Mappers;
import org.codejargon.fluentjdbc.api.query.Query;

import io.wisetime.connector.sql_time_post.model.Worklog;

/**
 * DAO for posting time to the connected database. Queries are loaded from yaml file.
 *
 * @author pascal
 */
public class TimePostingDao {

  private final FluentJdbc fluentJdbc;
  private final HikariDataSource dataSource;
  private final TimePostingQueries queries;

  @Inject
  public TimePostingDao(HikariDataSource dataSource, TimePostingQueries queries) {
    this.dataSource = dataSource;
    this.fluentJdbc = new FluentJdbcBuilder().connectionProvider(dataSource).build();
    this.queries = queries;
  }

  public void asTransaction(final Runnable runnable) {
    query().transaction().inNoResult(runnable);
  }

  public Optional<String> findUserId(String emailOrExternalId) {
    return query().select(queries.getFindUserIdSql())
        .namedParam("emailOrExternalId", emailOrExternalId)
        .firstResult(Mappers.singleString());
  }

  public Optional<String> findMatterIdByTagName(String tagName) {
    return query().select(queries.getFindMatterIdByTagNameSql())
        .namedParam("tagName", tagName)
        .firstResult(Mappers.singleString());
  }

  public boolean doesActivityCodeExist(String activityCode) {
    return query().select(queries.getDoesActivityCodeExistSql())
        .namedParam("activityCode", activityCode)
        .maxRows(1L)
        .firstResult(rs -> rs)
        .isPresent();
  }

  public void createWorklog(Worklog worklog) {
    query().update(queries.getCreateWorklogSql())
        .namedParam("matterId", worklog.getMatterId())
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
      query().select(queries.getCanQueryDbSql()).firstResult(Mappers.singleString());
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
