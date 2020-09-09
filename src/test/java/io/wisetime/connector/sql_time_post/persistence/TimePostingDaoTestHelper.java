package io.wisetime.connector.sql_time_post.persistence;

import static org.assertj.core.api.Assertions.assertThat;

import com.github.javafaker.Faker;
import com.google.common.base.Preconditions;
import com.google.inject.AbstractModule;
import com.google.inject.Provider;
import com.zaxxer.hikari.HikariDataSource;
import io.wisetime.connector.sql_time_post.fake.FakeTimeGroupGenerator;
import io.wisetime.connector.sql_time_post.model.Worklog;
import io.wisetime.connector.sql_time_post.persistence.PendingTimeTestHelper.PendingTime;
import io.wisetime.generated.connect.User;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import javax.inject.Inject;
import javax.inject.Singleton;
import org.codejargon.fluentjdbc.api.FluentJdbc;
import org.codejargon.fluentjdbc.api.FluentJdbcBuilder;
import org.codejargon.fluentjdbc.api.query.Query;
import org.flywaydb.core.Flyway;
import org.flywaydb.core.api.MigrationVersion;


/**
 * @author dchandler
 */
@Singleton
class TimePostingDaoTestHelper {

  private final FakeTimeGroupGenerator fakeTimeGroupGenerator = new FakeTimeGroupGenerator();

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

  void doesUserExist(int userId) {
    final User user = fakeTimeGroupGenerator.randomUser();
    assertThat(postTimeDao.findUserId(user.getEmail()))
        .as("User not in DB")
        .isEmpty();

    // Add user in DB
    createUserIdentity(userId, user.getEmail(), user.getExternalId());
    assertThat(postTimeDao.findUserId(user.getEmail()))
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

  void createWorklog() {
    int caseId = (int) faker.number().randomNumber();
    createCase(caseId);

    final User user = fakeTimeGroupGenerator.randomUser();
    final int userId = (int) faker.number().randomNumber();
    createUserIdentity(userId, user.getEmail(), user.getExternalId());

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
    fluentJdbc.query().update("INSERT INTO user_identity (user_id, email, username) VALUES (:userId, :email, :username)")
        .namedParam("userId", userId)
        .namedParam("email", email)
        .namedParam("username", username)
        .run();
  }

  private void createActivityCode(int activityCode, String activityName) {
    fluentJdbc.query().update("INSERT INTO activity_codes VALUES (:code, :name)")
        .namedParam("code", activityCode)
        .namedParam("name", activityName)
        .run();
  }

  private void cleanupDbRows() {
    final Query query = fluentJdbc.query();
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
        Flyway flyway = new Flyway();
        flyway.setDataSource(dataSourceProvider.get());
        flyway.setBaselineVersion(MigrationVersion.fromVersion("0"));
        flyway.setBaselineOnMigrate(true);
        flyway.setLocations(flywayLocation);
        return flyway;
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
