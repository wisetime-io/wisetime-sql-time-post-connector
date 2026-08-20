/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.persistence;

import static org.assertj.core.api.Assertions.assertThat;

import com.github.javafaker.Faker;
import com.google.common.base.Preconditions;
import com.google.inject.AbstractModule;
import com.google.inject.Provider;
import com.zaxxer.hikari.HikariDataSource;
import io.wisetime.connector.sql_time_post.model.Worklog;
import io.wisetime.connector.sql_time_post.persistence.PendingTimeTestHelper.PendingTime;
import io.wisetime.generated.connect.User;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.Optional;
import javax.inject.Inject;
import javax.inject.Singleton;
import org.codejargon.fluentjdbc.api.FluentJdbc;
import org.codejargon.fluentjdbc.api.FluentJdbcBuilder;
import org.codejargon.fluentjdbc.api.mapper.Mappers;
import org.codejargon.fluentjdbc.api.query.Query;
import org.flywaydb.core.Flyway;
import org.flywaydb.core.api.MigrationVersion;
import org.flywaydb.core.api.configuration.Configuration;
import org.flywaydb.core.api.configuration.FluentConfiguration;

/**
 * @author dchandler
 */
@Singleton
class TimePostingDaoTestHelper {

  private final Faker faker = new Faker();

  @Inject
  private PendingTimeTestHelper pendingTimeTestHelper;

  @Inject
  private FluentJdbc fluentJdbc;

  @Inject
  private TimePostingDao postTimeDao;

  void assertCanQueryDb() {
    assertThat(postTimeDao.canQueryDb())
        .as("should return true if connected to a database")
        .isTrue();
  }

  void doesUserExist(int userId, User user) {
    assertThat(postTimeDao.findUserId(user.getEmail()))
        .as("User not in DB")
        .isEmpty();

    // Add user in DB
    createUserIdentity(userId, user.getExternalId());
    assertThat(postTimeDao.findUserId(user.getExternalId()))
        .as("User is in DB")
        .contains(userId + "");

    cleanupDbRows();
  }

  void doesMatterExist(int caseId) {
    final String irn = createCase(caseId);
    assertThat(postTimeDao.findMatterIdByTagName(irn))
        .contains(caseId + "");

    cleanupDbRows();
  }

  void doesActivityCodeExist() {
    final int activityCode = faker.number().numberBetween(1000, 5000);
    assertThat(postTimeDao.doesActivityCodeExist(activityCode + ""))
        .isFalse();
    createActivityCode(activityCode, faker.gameOfThrones().house());
    assertThat(postTimeDao.doesActivityCodeExist(activityCode + ""))
        .isTrue();

    cleanupDbRows();
  }

  void createWorklog(int userId, User user) {
    int caseId = (int) faker.number().randomNumber();
    createCase(caseId);

    final int activityCode = faker.number().numberBetween(1000, 5000);
    createActivityCode(activityCode, faker.gameOfThrones().house());

    final String narrative = faker.gameOfThrones().quote();
    final String internalNarrative = faker.gameOfThrones().quote();

    final Worklog worklog = new Worklog()
        .setMatterId(caseId + "")
        .setUserId(userId + "")
        .setActivityCode(activityCode + "")
        .setNarrative(narrative)
        .setNarrativeInternal(internalNarrative)
        .setStartTime(OffsetDateTime.of(LocalDateTime.now(),
            ZoneOffset.UTC))
        .setDurationSeconds(2 * 60 * 60)
        .setChargeableTimeSeconds(2 * 60 * 60);

    postTimeDao.createWorklog(worklog);

    final PendingTime pendingTime = pendingTimeTestHelper.getPendingTime()
        .orElseThrow(() -> new RuntimeException("Pending time should exist"));

    pendingTimeTestHelper.assertPendingTime(pendingTime, worklog, user);
  }

  void createUserIdentity(int userId, String loginId) {
    fluentJdbc.query().update("INSERT INTO USERIDENTITY (nameno, loginid) VALUES (:userId, :loginId)")
        .namedParam("userId", userId)
        .namedParam("loginId", loginId)
        .run();
  }

  void createEmployee(int employeeId, String email, String loginId) {
    long mainEmailId = faker.number().randomNumber();
    fluentJdbc.query().update("INSERT INTO TELECOMMUNICATION (TELECODE, TELECOMNUMBER, TELECOMTYPE) "
        + "VALUES (:telecode, :email, 1903)")
        .namedParam("telecode", mainEmailId)
        .namedParam("email", email)
        .run();
    fluentJdbc.query().update("INSERT INTO NAME (NAMENO, NAME, MAINEMAIL) VALUES (:nameNo, :name, :mainemail)")
        .namedParam("nameNo", employeeId)
        .namedParam("name", faker.gameOfThrones().character())
        .namedParam("mainemail", mainEmailId)
        .run();

    createUserIdentity(employeeId, loginId);

    fluentJdbc.query().update("INSERT INTO EMPLOYEE (EMPLOYEENO) VALUES (:employeeId)")
        .namedParam("employeeId", employeeId)
        .run();
  }

  private String createCase(final int caseId) {
    final String irn = faker.numerify("C######");
    final String title = faker.company().name();

    final String insertCaseSql =
        "INSERT INTO CASES(caseid, irn, title, casetype, propertytype, countrycode) "
            + "VALUES (:caseId, :irn, :title, :caseType, :propertyType, :countryCode)";

    fluentJdbc.query().update(insertCaseSql)
        .namedParam("caseId", caseId)
        .namedParam("irn", irn)
        .namedParam("title", title)
        .namedParam("caseType", "C")
        .namedParam("propertyType", "P")
        .namedParam("countryCode", faker.address().countryCode())
        .run();

    return irn;
  }

  private void createActivityCode(int activityCode, String activityName) {
    fluentJdbc.query().update(
        "INSERT INTO TACTIVITYCODES (activitycode, activityname, activitytype, activityla) VALUES (:code, :name, 3, 1)")
        .namedParam("code", activityCode)
        .namedParam("name", activityName)
        .run();
  }

  private void cleanupDbRows() {
    final Query query = fluentJdbc.query();
    tableExists("CASES")
        .ifPresent(value -> query.update("DELETE FROM CASES").run());
    tableExists("EMPLOYEE")
        .ifPresent(value -> query.update("DELETE FROM EMPLOYEE").run());
    tableExists("USERIDENTITY")
        .ifPresent(value -> query.update("DELETE FROM USERIDENTITY").run());
    tableExists("NAME")
        .ifPresent(value -> query.update("DELETE FROM NAME").run());
    tableExists("TELECOMMUNICATION")
        .ifPresent(value -> query.update("DELETE FROM TELECOMMUNICATION").run());
    tableExists("wt_post_time")
        .ifPresent(value -> query.update("DELETE FROM wt_post_time").run());
    tableExists("TACTIVITYCODES")
        .ifPresent(value -> query.update("DELETE FROM TACTIVITYCODES").run());
  }

  private Optional<Boolean> tableExists(String tableName) {
    return fluentJdbc.query()
        .select("select 1 from information_schema.TABLES where TABLE_NAME = :tableName")
        .namedParam("tableName", tableName)
        .firstResult(Mappers.singleBoolean());
  }

  /**
   * Initializes database schema for unit tests
   */
  static class FlywayTestDbModule extends AbstractModule {

    private static String flywayLocation;

    FlywayTestDbModule(String flywayLocation) {
      Preconditions.checkArgument(flywayLocation != null, "flyway location required");
      FlywayTestDbModule.flywayLocation = flywayLocation;
    }

    @Override
    protected void configure() {
      bind(Flyway.class).toProvider(FlywayProviderTestImpl.class);
    }

    private static class FlywayProviderTestImpl implements Provider<Flyway> {

      @Inject
      private Provider<HikariDataSource> dataSourceProvider;

      @Override
      public Flyway get() {
        final Configuration dbConfig = new FluentConfiguration()
            .dataSource(dataSourceProvider.get())
            .baselineVersion(MigrationVersion.fromVersion("0"))
            .baselineOnMigrate(true)
            .locations(flywayLocation);
        return new Flyway(dbConfig);
      }
    }
  }

  static class FluentJdbcTestDbModule extends AbstractModule {

    @Override
    protected void configure() {
      bind(FluentJdbc.class).toProvider(FluentJdbcProviderTestImpl.class);
    }

    private static class FluentJdbcProviderTestImpl implements Provider<FluentJdbc> {

      @Inject
      private Provider<HikariDataSource> dataSourceProvider;

      @Override
      public FluentJdbc get() {
        return new FluentJdbcBuilder().connectionProvider(dataSourceProvider.get()).build();
      }
    }
  }
}
