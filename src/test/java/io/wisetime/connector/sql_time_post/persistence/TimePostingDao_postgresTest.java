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
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Provider;
import com.zaxxer.hikari.HikariDataSource;
import io.wisetime.connector.config.RuntimeConfig;
import io.wisetime.connector.sql_time_post.ConnectorLauncher;
import io.wisetime.connector.sql_time_post.fake.FakeTimeGroupGenerator;
import io.wisetime.connector.sql_time_post.model.Worklog;
import io.wisetime.connector.sql_time_post.persistence.PendingTimeHelper.PendingTime;
import io.wisetime.generated.connect.User;
import io.wisetime.test_docker.ContainerRuntimeSpec;
import io.wisetime.test_docker.DockerLauncher;
import io.wisetime.test_docker.containers.Postgres;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.Objects;
import javax.inject.Inject;
import org.codejargon.fluentjdbc.api.FluentJdbc;
import org.codejargon.fluentjdbc.api.FluentJdbcBuilder;
import org.codejargon.fluentjdbc.api.query.Query;
import org.flywaydb.core.Flyway;
import org.flywaydb.core.api.MigrationVersion;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/**
 * @author dchandler
 */
class TimePostingDao_postgresTest {

  private final FakeTimeGroupGenerator fakeTimeGroupGenerator = new FakeTimeGroupGenerator();

  private final Faker faker = new Faker();

  private static TimePostingDao postTimeDao;

  private static FluentJdbc fluentJdbc;

  private static PendingTimeHelper pendingTimeHelper;

  @BeforeAll
  static void setUp() {
    final String fileLocation = Objects.requireNonNull(TimePostingDao_postgresTest.class
        .getClassLoader()
        .getResource("time_post/postgres_time_post_sql.yaml"))
        .getPath();

    RuntimeConfig.setProperty(TIME_POST_SQL_PATH, fileLocation);

    final Postgres postgres = new Postgres();
    final ContainerRuntimeSpec container = DockerLauncher.instance().createContainer(postgres);

    final String jdbcUrl = String.format("jdbc:postgresql://%s:%d/dockerdb",
        container.getContainerIpAddress(),
        container.getRequiredMappedPort(5432));

    RuntimeConfig.setProperty(JDBC_URL, jdbcUrl);
    RuntimeConfig.setProperty(DB_USER, "docker");
    RuntimeConfig.setProperty(DB_PASSWORD, "docker");

    final Injector injector = Guice.createInjector(new ConnectorLauncher.DbModule(), new FlywayTestDbModule());

    postTimeDao = injector.getInstance(TimePostingDao.class);
    fluentJdbc = new FluentJdbcBuilder().connectionProvider(
        injector.getInstance(HikariDataSource.class)).build();

    pendingTimeHelper = new PendingTimeHelper(fluentJdbc);

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
    assertThat(postTimeDao.canQueryDb())
        .as("should return true if connected to a database")
        .isTrue();
  }

  @Test
  void doesUserExist() {
    final User user = fakeTimeGroupGenerator.randomUser();
    assertThat(postTimeDao.findUserId(user.getEmail()))
        .as("User not in DB")
        .isEmpty();

    // Add user in DB
    createUserIdentity(123, user.getEmail(), user.getExternalId());
    assertThat(postTimeDao.findUserId(user.getEmail()))
        .as("User is in DB")
        .contains("123");

    cleanupDbRows();
  }

  @Test
  void doesMatterExist() {
    final String irn = createCase(123);
    assertThat(postTimeDao.findMatterIdByTagName(irn))
        .contains("123");

    cleanupDbRows();
  }

  @Test
  void doesActivityCodeExist() {
    final String activityCode = faker.numerify("######");
    assertThat(postTimeDao.doesActivityCodeExist(activityCode))
        .isFalse();
    createActivityCode(activityCode, faker.gameOfThrones().house());
    assertThat(postTimeDao.doesActivityCodeExist(activityCode))
        .isTrue();

    cleanupDbRows();
  }

  @Test
  void createWorklog() {
    int caseId = (int) faker.number().randomNumber();
    createCase(caseId);

    final User user = fakeTimeGroupGenerator.randomUser();
    final int userId = (int) faker.number().randomNumber();
    createUserIdentity(userId, user.getEmail(), user.getExternalId());

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

    final PendingTime pendingTime = pendingTimeHelper.getPendingTime()
        .orElseThrow(() -> new RuntimeException("Pending time should exist"));

    pendingTimeHelper.assertPendingTime(pendingTime, worklog, user);

    cleanupDbRows();
  }

  private String createCase(final int caseId) {
    final String irn = faker.numerify("C######");
    final String title = faker.company().name();

    final String insertCaseSql =
        "INSERT INTO cases(case_id, irn, title, case_type, property_type, country_code) "
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

  private void createUserIdentity(int userId, String email, String username) {
    fluentJdbc.query().update(
        "INSERT INTO user_identity (user_id, email, username) VALUES (:userId, :email, :username)")
        .namedParam("userId", userId)
        .namedParam("email", email)
        .namedParam("username", username)
        .run();
  }

  private void createActivityCode(String activityCode, String activityName) {
    fluentJdbc.query().update(
        "INSERT INTO activity_codes (activity_code, activity_name) VALUES (CAST(:code as INT), :name)")
        .namedParam("code", activityCode)
        .namedParam("name", activityName)
        .run();
  }

  private void cleanupDbRows() {
    Query query = fluentJdbc.query();
    query.update("DELETE FROM cases")
        .run();
    query.update("DELETE FROM user_identity")
        .run();
    query.update("DELETE FROM activity_codes")
        .run();
    query.update("DELETE FROM wt_post_time")
        .run();
  }

  /**
   * Initializes database schema for unit tests
   */
  public static class FlywayTestDbModule extends AbstractModule {

    @Override
    protected void configure() {
      bind(Flyway.class).toProvider(FlywayProviderTestImpl.class);
    }

    private static class FlywayProviderTestImpl implements Provider<Flyway> {

      @Inject
      private Provider<HikariDataSource> dataSourceProvider;

      @Override
      public Flyway get() {
        Flyway flyway = new Flyway();
        flyway.setDataSource(dataSourceProvider.get());
        flyway.setBaselineVersion(MigrationVersion.fromVersion("0"));
        flyway.setBaselineOnMigrate(true);
        flyway.setLocations("db_schema/postgres/");
        return flyway;
      }
    }
  }
}
