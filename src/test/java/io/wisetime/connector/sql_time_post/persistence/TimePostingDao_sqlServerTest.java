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
import com.google.common.base.Preconditions;
import com.google.inject.Guice;
import com.google.inject.Injector;
import io.wisetime.connector.config.RuntimeConfig;
import io.wisetime.connector.sql_time_post.ConnectorLauncher;
import io.wisetime.connector.sql_time_post.fake.FakeTimeGroupGenerator;
import io.wisetime.connector.sql_time_post.model.Worklog;
import io.wisetime.connector.sql_time_post.persistence.PendingTimeTestHelper.PendingTime;
import io.wisetime.connector.sql_time_post.persistence.TimePostingDaoTestHelper.FluentJdbcTestDbModule;
import io.wisetime.generated.connect.User;
import io.wisetime.test_docker.ContainerRuntimeSpec;
import io.wisetime.test_docker.DockerLauncher;
import io.wisetime.test_docker.containers.SqlServer;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import org.codejargon.fluentjdbc.api.FluentJdbc;
import org.codejargon.fluentjdbc.api.query.Query;
import org.flywaydb.core.Flyway;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * @author pascal
 */
class TimePostingDao_sqlServerTest {

  private static JdbcDatabaseContainer sqlServerContainer;

  private final FakeTimeGroupGenerator fakeTimeGroupGenerator = new FakeTimeGroupGenerator();

  private final Faker faker = new Faker();

  private static TimePostingDao postTimeDao;

  private static FluentJdbc fluentJdbc;

  private static TimePostingDaoTestHelper timePostingDaoTestHelper;

  private static PendingTimeTestHelper pendingTimeTestHelper;

  @BeforeAll
  static void setUp() throws InterruptedException {
    sqlServerContainer = getSqlServerContainer();

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
    fluentJdbc = injector.getInstance(FluentJdbc.class);
    timePostingDaoTestHelper = injector.getInstance(TimePostingDaoTestHelper.class);
    pendingTimeTestHelper = injector.getInstance(PendingTimeTestHelper.class);

    // Apply DB schema to test db
    injector.getInstance(Flyway.class).migrate();
  }

  @BeforeEach
  void setupTests() {
    Preconditions.checkState(
        // We don't want to accidentally truncate production tables
        RuntimeConfig.getString(JDBC_URL).orElse("").equals(sqlServerContainer.getJdbcUrl())
    );
    Query query = fluentJdbc.query();
    query.update("DELETE FROM CASES").run();
    query.update("DELETE FROM EMPLOYEE").run();
    query.update("DELETE FROM USERIDENTITY").run();
    query.update("DELETE FROM NAME").run();
    query.update("DELETE FROM TELECOMMUNICATION").run();
    query.update("DELETE FROM wt_post_time").run();
    query.update("DELETE FROM TACTIVITYCODES").run();
  }

  @Test
  void canQueryDb() {
    timePostingDaoTestHelper.assertCanQueryDb();
  }

  @Test
  void doesUserExist() {
    final User user = fakeTimeGroupGenerator.randomUser();
    assertThat(postTimeDao.findUserId(user.getEmail()))
        .as("User not in DB")
        .isEmpty();

    // Add user in DB
    createEmployee(123, user.getEmail(), user.getExternalId());
    assertThat(postTimeDao.findUserId(user.getEmail()))
        .as("User is in DB")
        .contains("123");
  }

  @Test
  void doesMatterExist() {
    final String irn = createCase(123);
    assertThat(postTimeDao.findMatterIdByTagName(irn))
        .contains("123");
  }

  @Test
  void doesActivityCodeExist() {
    final String activityCode = faker.numerify("######");
    assertThat(postTimeDao.doesActivityCodeExist(activityCode))
        .isFalse();
    createActivityCode(activityCode, faker.gameOfThrones().house());
    assertThat(postTimeDao.doesActivityCodeExist(activityCode))
        .isTrue();
  }

  @Test
  void createWorklog() {
    int caseId = (int) faker.number().randomNumber();
    createCase(caseId);

    final User user = fakeTimeGroupGenerator.randomUser();
    final int userId = (int) faker.number().randomNumber();
    createEmployee(userId, user.getEmail(), user.getExternalId());

    final String activityCode = faker.numerify("1######");
    createActivityCode(activityCode, faker.gameOfThrones().house());

    final String narrative = faker.gameOfThrones().quote();
    final String internalNarrative = faker.gameOfThrones().quote();

    final Worklog worklog = new Worklog()
        .setMatterId(caseId + "")
        .setUserId(userId + "")
        .setActivityCode(activityCode)
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

  private String createCase(final int caseId) {
    final String irn = faker.numerify("C######");
    final String title = faker.company().name();

    final String insertCaseSql = "INSERT INTO CASES (CASEID, IRN, TITLE, CASETYPE, PROPERTYTYPE, COUNTRYCODE, STATUSCODE) " +
        "VALUES (:caseid, :irn, :title, :casetype, :propertytype, :countrycode, :statuscode)";
    fluentJdbc.query().update(insertCaseSql)
        .namedParam("caseid", caseId)
        .namedParam("irn", irn)
        .namedParam("title", title)
        .namedParam("casetype", "C")
        .namedParam("propertytype", "P")
        .namedParam("countrycode", faker.address().countryCode())
        .run();

    return irn;
  }

  private void createEmployee(int employeeId, String email, String loginId) {
    long mainEmailId = faker.number().randomNumber();
    fluentJdbc.query().update("INSERT INTO TELECOMMUNICATION (TELECODE, TELECOMNUMBER, TELECOMTYPE) " +
        "VALUES (:telecode, :email, 1903)")
        .namedParam("telecode", mainEmailId)
        .namedParam("email", email)
        .run();
    fluentJdbc.query().update("INSERT INTO NAME (NAMENO, NAME, MAINEMAIL) VALUES (:nameNo, :name, :mainemail)")
        .namedParam("nameNo", employeeId)
        .namedParam("name", faker.gameOfThrones().character())
        .namedParam("mainemail", mainEmailId)
        .run();
    fluentJdbc.query().update("INSERT INTO USERIDENTITY (NAMENO, LOGINID) VALUES (:nameNo, :loginId)")
        .namedParam("nameNo", employeeId)
        .namedParam("loginId", loginId)
        .run();
    fluentJdbc.query().update("INSERT INTO EMPLOYEE (EMPLOYEENO) VALUES (:employeeId)")
        .namedParam("employeeId", employeeId)
        .run();
  }

  private void createActivityCode(String activityCode, String activityName) {
    fluentJdbc.query().update("INSERT INTO TACTIVITYCODES VALUES (:code, :name, 3, 1)")
        .namedParam("code", activityCode)
        .namedParam("name", activityName)
        .run();
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
