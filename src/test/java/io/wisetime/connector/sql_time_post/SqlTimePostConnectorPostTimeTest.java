/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.reset;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.github.javafaker.Faker;
import com.google.common.collect.ImmutableList;
import com.google.inject.Guice;
import com.google.inject.Injector;
import io.wisetime.connector.ConnectorModule;
import io.wisetime.connector.api_client.ApiClient;
import io.wisetime.connector.api_client.PostResult;
import io.wisetime.connector.api_client.PostResult.PostResultStatus;
import io.wisetime.connector.config.RuntimeConfig;
import io.wisetime.connector.datastore.ConnectorStore;
import io.wisetime.connector.sql_time_post.ConnectorLauncher.SqlPostTimeConnectorConfigKey;
import io.wisetime.connector.sql_time_post.fake.FakeTimeGroupGenerator;
import io.wisetime.connector.sql_time_post.model.Worklog;
import io.wisetime.connector.sql_time_post.persistence.TimePostingDao;
import io.wisetime.generated.connect.GroupActivityType;
import io.wisetime.generated.connect.Tag;
import io.wisetime.generated.connect.TimeGroup;
import io.wisetime.generated.connect.TimeRow;
import io.wisetime.generated.connect.User;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

/**
 * @author pascal
 */
class SqlTimePostConnectorPostTimeTest {

  private static final String TAG_UPSERT_PATH = "/Inprotech/";

  private static final String DEFAULT_ACTIVITY_CODE = "123456";

  private static ApiClient apiClientMock = mock(ApiClient.class);
  private static TimePostingDao postTimeDaoMock = mock(TimePostingDao.class);

  private static SqlTimePostConnector connector;
  private final FakeTimeGroupGenerator fakeGenerator = new FakeTimeGroupGenerator();

  @BeforeAll
  static void setUp() {
    RuntimeConfig.setProperty(SqlPostTimeConnectorConfigKey.TAG_UPSERT_PATH, TAG_UPSERT_PATH);
    final String fileLocation = SqlTimePostConnectorPostTimeTest.class.getClassLoader()
        .getResource("timegroup-narrative-template.ftl").getPath();
    RuntimeConfig.setProperty(SqlPostTimeConnectorConfigKey.NARRATIVE_PATH, fileLocation);
    final String fileLocationInternal = SqlTimePostConnectorPostTimeTest.class.getClassLoader()
        .getResource("timegroup-narrative-internal-template.ftl").getPath();
    RuntimeConfig.setProperty(SqlPostTimeConnectorConfigKey.NARRATIVE_INTERNAL_PATH, fileLocationInternal);

    Injector injector = Guice.createInjector(
        binder -> binder.bind(TimePostingDao.class).toProvider(() -> postTimeDaoMock));
    connector = injector.getInstance(SqlTimePostConnector.class);

    connector.init(new ConnectorModule(apiClientMock, mock(ConnectorStore.class), 5));
  }

  @BeforeEach
  void setUpTest() {
    reset(postTimeDaoMock);

    // Ensure that code in the transaction lambda gets exercised
    doAnswer(invocation -> {
      invocation.<Runnable>getArgument(0).run();
      return null;
    }).when(postTimeDaoMock).asTransaction(any(Runnable.class));

    connector.init(new ConnectorModule(apiClientMock, mock(ConnectorStore.class), 5));
  }

  @Test
  void postTime_without_tags_should_succeed() {
    final TimeGroup groupWithNoTags = fakeGenerator.randomTimeGroup().tags(ImmutableList.of());

    assertThat(connector.postTime(groupWithNoTags).getStatus())
        .isEqualTo(PostResultStatus.SUCCESS);

    verify(postTimeDaoMock, never()).createWorklog(any(Worklog.class));
  }

  @Test
  void postTime_without_time_rows_should_succeed() {
    final TimeGroup groupWithNoTimeRows = fakeGenerator.randomTimeGroup()
        .timeRows(ImmutableList.of())
        .activityType(new GroupActivityType().code("activityCode"))
        .localDate(LocalDate.now())
        .tzOffsetMins(0);
    groupWithNoTimeRows.getTags()
        .forEach(tag -> tag.setPath(RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.TAG_UPSERT_PATH).get()));
    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of(Faker.instance().numerify("userId_######")));

    when(postTimeDaoMock.doesActivityCodeExist(any()))
        .thenReturn(true);

    String matterId = groupWithNoTimeRows.getTags().get(0).getExternalId();
    when(postTimeDaoMock.findMatterIdByExternalId(any()))
        .thenReturn(Optional.of(matterId));


    assertThat(connector.postTime(groupWithNoTimeRows).getStatus())
        .isEqualTo(PostResultStatus.SUCCESS);

    verify(postTimeDaoMock, times(1)).createWorklog(any(Worklog.class));
  }

  @Test
  void postTime_nonexistent_author_should_fail() {
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup();
    timeGroup.getTags()
        .forEach(tag -> tag.setPath(RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.TAG_UPSERT_PATH).get()));

    when(postTimeDaoMock.findUserId(anyString()))
        .thenReturn(Optional.empty());

    assertThat(connector.postTime(timeGroup).getStatus())
        .isEqualTo(PostResultStatus.PERMANENT_FAILURE);

    verify(postTimeDaoMock, times(1)).findUserId(anyString());
    verify(postTimeDaoMock, never()).createWorklog(any(Worklog.class));
  }

  @Test
  void postTime_email_used_when_no_externalId() {
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup().user(
        fakeGenerator.randomUser().externalId(null).email("email@domain.com")
    );
    timeGroup.getTags()
        .forEach(tag -> tag.setPath(RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.TAG_UPSERT_PATH).get()));

    ArgumentCaptor<String> userIdentityCaptor = ArgumentCaptor.forClass(String.class);
    when(postTimeDaoMock.findUserId(userIdentityCaptor.capture()))
        .thenReturn(Optional.empty());

    connector.postTime(timeGroup);

    assertThat(userIdentityCaptor.getValue())
        .isEqualTo("email@domain.com");
  }

  @Test
  void postTime_different_timerow_modifiers_should_fail() {
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup().timeRows(ImmutableList.of(
        fakeGenerator.randomTimeRow().activityTypeCode("1"),
        fakeGenerator.randomTimeRow().activityTypeCode("2")));
    timeGroup.getTags()
        .forEach(tag -> tag.setPath(RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.TAG_UPSERT_PATH).get()));

    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of("123"));

    PostResult result = connector.postTime(timeGroup);
    assertThat(result.getStatus()).isEqualTo(PostResultStatus.PERMANENT_FAILURE);
    assertThat(result.getMessage()).contains("Time group has multiple activity types assigned,"
        + " only one activity type per time group is supported.");

    verify(postTimeDaoMock, never()).createWorklog(any(Worklog.class));
  }

  @Test
  void postTime_nonexistent_and_mandatory_activity_code_should_fail() {
    RuntimeConfig.setProperty(SqlPostTimeConnectorConfigKey.ACTIVITY_TYPE_MANDATORY, "true");
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup("");
    timeGroup.getTags()
        .forEach(tag -> tag.setPath(RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.TAG_UPSERT_PATH).get()));

    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of("123"));

    PostResult result = connector.postTime(timeGroup);
    assertThat(result.getStatus()).isEqualTo(PostResultStatus.PERMANENT_FAILURE);
    assertThat(result.getMessage()).contains("Time group has no activity type assigned, "
        + "but activity types are mandatory.");

    verify(postTimeDaoMock, never()).doesActivityCodeExist(any());
    verify(postTimeDaoMock, never()).createWorklog(any(Worklog.class));
    RuntimeConfig.clearProperty(SqlPostTimeConnectorConfigKey.ACTIVITY_TYPE_MANDATORY);
  }

  @Test
  void postTime_invalid_activity_code_should_fail() {
    RuntimeConfig.setProperty(SqlPostTimeConnectorConfigKey.ACTIVITY_TYPE_MANDATORY, "true");
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup(DEFAULT_ACTIVITY_CODE);
    timeGroup.getTags()
        .forEach(tag -> tag.setPath(RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.TAG_UPSERT_PATH).get()));

    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of("123"));

    when(postTimeDaoMock.doesActivityCodeExist(DEFAULT_ACTIVITY_CODE))
        .thenReturn(false);

    PostResult result = connector.postTime(timeGroup);
    assertThat(result.getStatus()).isEqualTo(PostResultStatus.PERMANENT_FAILURE);
    assertThat(result.getMessage()).contains("The activity type of the Time Group could not be verified "
        + "in the external system.");

    verify(postTimeDaoMock, times(1)).doesActivityCodeExist(DEFAULT_ACTIVITY_CODE);
    verify(postTimeDaoMock, never()).createWorklog(any(Worklog.class));
    RuntimeConfig.clearProperty(SqlPostTimeConnectorConfigKey.ACTIVITY_TYPE_MANDATORY);
  }

  @Test
  void postTime_invalid_activity_code_should_fail_even_if_non_mandatory() {
    RuntimeConfig.setProperty(SqlPostTimeConnectorConfigKey.ACTIVITY_TYPE_MANDATORY, "false");
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup(DEFAULT_ACTIVITY_CODE);
    timeGroup.getTags()
        .forEach(tag -> tag.setPath(RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.TAG_UPSERT_PATH).get()));

    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of("123"));

    when(postTimeDaoMock.doesActivityCodeExist(DEFAULT_ACTIVITY_CODE))
        .thenReturn(false);

    PostResult result = connector.postTime(timeGroup);
    assertThat(result.getStatus()).isEqualTo(PostResultStatus.PERMANENT_FAILURE);
    assertThat(result.getMessage()).contains("The activity type of the Time Group could not be verified "
        + "in the external system.");

    verify(postTimeDaoMock, times(1)).doesActivityCodeExist(DEFAULT_ACTIVITY_CODE);
    verify(postTimeDaoMock, never()).createWorklog(any(Worklog.class));
    RuntimeConfig.clearProperty(SqlPostTimeConnectorConfigKey.ACTIVITY_TYPE_MANDATORY);
  }

  @Test
  void postTime_db_transaction_error() {
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup(DEFAULT_ACTIVITY_CODE)
        .tags(ImmutableList.of(fakeGenerator.randomTag(TAG_UPSERT_PATH, "tag")));

    RuntimeException createWorklogException = new RuntimeException("Test exception");
    doThrow(createWorklogException)
        .when(postTimeDaoMock)
        .createWorklog(any(Worklog.class));

    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of("123"));

    when(postTimeDaoMock.doesActivityCodeExist(any()))
        .thenReturn(true);

    when(postTimeDaoMock.findMatterIdByTagName(anyString()))
        .thenReturn(Optional.of("123"));

    final PostResult result = connector.postTime(timeGroup);

    assertThat(result.getStatus())
        .isEqualTo(PostResultStatus.TRANSIENT_FAILURE);
    assertThat(result.getError().isPresent())
        .isTrue();
    assertThat(result.getError().get())
        .isEqualTo(createWorklogException);
  }

  @Test
  void postTime_with_valid_group_should_succeed() {
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup(DEFAULT_ACTIVITY_CODE);

    assertThat(connector.postTime(timeGroup).getStatus())
        .isEqualTo(PostResultStatus.SUCCESS);
  }

  @Test
  void postTime_no_activity_type_not_mandatory_should_succeed() {
    RuntimeConfig.setProperty(SqlPostTimeConnectorConfigKey.ACTIVITY_TYPE_MANDATORY, "false");
    final Tag existentCaseTag = fakeGenerator.randomTag(TAG_UPSERT_PATH, Faker.instance().numerify("tag_######"));

    // no activity type
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup(null)
        .tags(Collections.singletonList(existentCaseTag));

    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of(Faker.instance().numerify("userId_######")));

    when(postTimeDaoMock.doesActivityCodeExist(any()))
        .thenReturn(false);

    String matterId = timeGroup.getTags().get(0).getExternalId();
    when(postTimeDaoMock.findMatterIdByExternalId(any()))
        .thenReturn(Optional.of(matterId));

    assertThat(connector.postTime(timeGroup).getStatus())
        .isEqualTo(PostResultStatus.SUCCESS);

    verify(postTimeDaoMock, times(1)).findMatterIdByExternalId(eq(matterId));
    verify(postTimeDaoMock, never()).findMatterIdByTagName(any());

    ArgumentCaptor<Worklog> worklogCaptor = ArgumentCaptor.forClass(Worklog.class);
    verify(postTimeDaoMock, times(1)).createWorklog(worklogCaptor.capture());

    List<Worklog> createdWorklogs = worklogCaptor.getAllValues();

    assertThat(createdWorklogs)
        .hasSize(1);
    assertThat(createdWorklogs.get(0).getMatterId())
        .isEqualTo(matterId);
    RuntimeConfig.clearProperty(SqlPostTimeConnectorConfigKey.ACTIVITY_TYPE_MANDATORY);
  }

  @Test
  void postTime_create_worklog_for_each_valid_tag() {
    final Tag existentCaseTag = fakeGenerator.randomTag(TAG_UPSERT_PATH, "tag1");

    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup(DEFAULT_ACTIVITY_CODE)
        .tags(Collections.singletonList(existentCaseTag));

    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of("123"));

    when(postTimeDaoMock.doesActivityCodeExist(any()))
        .thenReturn(true);

    when(postTimeDaoMock.findMatterIdByExternalId(any()))
        .thenReturn(Optional.of("123"));

    assertThat(connector.postTime(timeGroup).getStatus())
        .isEqualTo(PostResultStatus.SUCCESS);

    verify(postTimeDaoMock, times(1)).findMatterIdByExternalId(anyString());
    verify(postTimeDaoMock, never()).findMatterIdByTagName(any());

    ArgumentCaptor<Worklog> worklogCaptor = ArgumentCaptor.forClass(Worklog.class);
    verify(postTimeDaoMock, times(1)).createWorklog(worklogCaptor.capture());

    List<Worklog> createdWorklogs = worklogCaptor.getAllValues();

    assertThat(createdWorklogs)
        .hasSize(1);
    assertThat(createdWorklogs.get(0).getMatterId())
        .isEqualTo("123");
  }

  @Test
  void postTime_create_worklog_for_each_valid_tag_search_by_tag_name() {
    final Tag existentCaseTag = fakeGenerator.randomTag(TAG_UPSERT_PATH, "tag1");

    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup(DEFAULT_ACTIVITY_CODE)
        .tags(Collections.singletonList(existentCaseTag));

    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of("123"));

    when(postTimeDaoMock.doesActivityCodeExist(any()))
        .thenReturn(true);

    when(postTimeDaoMock.findMatterIdByExternalId(any()))
        .thenReturn(Optional.empty());

    when(postTimeDaoMock.findMatterIdByTagName(existentCaseTag.getName()))
        .thenReturn(Optional.of("123"));

    assertThat(connector.postTime(timeGroup).getStatus())
        .isEqualTo(PostResultStatus.SUCCESS);

    verify(postTimeDaoMock, times(1)).findMatterIdByTagName(anyString());

    ArgumentCaptor<Worklog> worklogCaptor = ArgumentCaptor.forClass(Worklog.class);
    verify(postTimeDaoMock, times(1)).createWorklog(worklogCaptor.capture());

    List<Worklog> createdWorklogs = worklogCaptor.getAllValues();

    assertThat(createdWorklogs)
        .hasSize(1);
    assertThat(createdWorklogs.get(0).getMatterId())
        .isEqualTo("123");
  }

  @Test
  void postTime_narrative_duration_experience_rating() {
    final User user = fakeGenerator.randomUser().experienceWeightingPercent(50);

    final TimeRow earliestTimeRow = fakeGenerator.randomTimeRow()
        .activityTypeCode(DEFAULT_ACTIVITY_CODE)
        .activityHour(2018110106)
        .firstObservedInHour(45)
        .timezoneOffsetMin(0)
        .durationSecs(600);
    final TimeRow latestTimeRow = fakeGenerator.randomTimeRow()
        .activityTypeCode(DEFAULT_ACTIVITY_CODE)
        .activityHour(2018110110)
        .firstObservedInHour(2)
        .timezoneOffsetMin(0)
        .durationSecs(2400);

    List<Tag> tags = ImmutableList.of(fakeGenerator.randomTag(TAG_UPSERT_PATH, "tag"));

    setPrerequisitesForSuccessfulPostTime(user, tags);

    when(postTimeDaoMock.doesActivityCodeExist(any()))
        .thenReturn(true);

    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup()
        .durationSplitStrategy(TimeGroup.DurationSplitStrategyEnum.DIVIDE_BETWEEN_TAGS)
        .narrativeType(TimeGroup.NarrativeTypeEnum.AND_TIME_ROW_ACTIVITY_DESCRIPTIONS)
        .timeRows(ImmutableList.of(earliestTimeRow, latestTimeRow))
        .tags(tags)
        .user(user)
        .totalDurationSecs(3000);

    assertThat(connector.postTime(timeGroup).getStatus())
        .isEqualTo(PostResultStatus.SUCCESS);

    ArgumentCaptor<Worklog> worklogCaptor = ArgumentCaptor.forClass(Worklog.class);
    verify(postTimeDaoMock, times(1)).createWorklog(worklogCaptor.capture());
    Worklog worklog = worklogCaptor.getValue();

    assertThat(worklog.getNarrative())
        .as("time rows should be grouped by segment hour in ascending order")
        .startsWith(timeGroup.getDescription())
        .contains("06:00 - 06:59")
        .contains("- 10m - " + earliestTimeRow.getActivity() + " - " + earliestTimeRow.getDescription())
        .contains("10:00 - 10:59")
        .contains("- 40m - " + latestTimeRow.getActivity() + " - " + latestTimeRow.getDescription());
    assertThat(worklog.getNarrativeInternal())
        .contains("Total Worked Time: 50m")
        .contains("Total Chargeable Time: 25m")
        .endsWith("The chargeable time has been weighed based on an experience factor of 50%.");
  }

  @Test
  void postTime_narrative_narrative_only() {
    final User user = fakeGenerator.randomUser().experienceWeightingPercent(50);

    final TimeRow earliestTimeRow = fakeGenerator.randomTimeRow()
        .activityTypeCode(DEFAULT_ACTIVITY_CODE).activityHour(2018110106).firstObservedInHour(57).durationSecs(66);
    final TimeRow latestTimeRow = fakeGenerator.randomTimeRow()
        .activityTypeCode(DEFAULT_ACTIVITY_CODE).activityHour(2018110110).firstObservedInHour(2).durationSecs(2400);

    List<Tag> tags = ImmutableList.of(fakeGenerator.randomTag(TAG_UPSERT_PATH, "tag1"),
        fakeGenerator.randomTag(TAG_UPSERT_PATH, "tag2")
    );

    when(postTimeDaoMock.doesActivityCodeExist(any()))
        .thenReturn(true);

    setPrerequisitesForSuccessfulPostTime(user, tags);

    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup()
        .durationSplitStrategy(TimeGroup.DurationSplitStrategyEnum.WHOLE_DURATION_TO_EACH_TAG)
        .narrativeType(TimeGroup.NarrativeTypeEnum.ONLY)
        .timeRows(ImmutableList.of(earliestTimeRow, latestTimeRow))
        .tags(tags)
        .user(user)
        .totalDurationSecs(3000);

    assertThat(connector.postTime(timeGroup).getStatus())
        .isEqualTo(PostResultStatus.SUCCESS);

    ArgumentCaptor<Worklog> worklogCaptor = ArgumentCaptor.forClass(Worklog.class);
    verify(postTimeDaoMock, times(2)).createWorklog(worklogCaptor.capture());
    List<Worklog> worklogs = worklogCaptor.getAllValues();

    assertThat(worklogs.get(0).getNarrative())
        .as("time rows should be grouped by segment hour in ascending order")
        .startsWith(timeGroup.getDescription());
    assertThat(worklogs.get(0).getNarrativeInternal())
        .doesNotContain(earliestTimeRow.getActivity(), earliestTimeRow.getDescription())
        .doesNotContain(latestTimeRow.getActivity(), latestTimeRow.getDescription())
        .contains("Total Worked Time: 41m 6s")
        .endsWith("Total Chargeable Time: 50m");

    assertThat(worklogs.get(0).getNarrative())
        .isEqualTo(worklogs.get(1).getNarrative());
  }

  @Test
  void postTime_narrative_narrative_only_no_summary() {
    final User user = fakeGenerator.randomUser().experienceWeightingPercent(50);

    final TimeRow earliestTimeRow = fakeGenerator.randomTimeRow()
        .activityTypeCode(DEFAULT_ACTIVITY_CODE).activityHour(2018110106).firstObservedInHour(57).durationSecs(66);
    final TimeRow latestTimeRow = fakeGenerator.randomTimeRow()
        .activityTypeCode(DEFAULT_ACTIVITY_CODE).activityHour(2018110110).firstObservedInHour(2).durationSecs(2400);

    List<Tag> tags = ImmutableList.of(fakeGenerator.randomTag(TAG_UPSERT_PATH, "tag1"),
        fakeGenerator.randomTag(TAG_UPSERT_PATH, "tag2")
    );

    when(postTimeDaoMock.doesActivityCodeExist(any()))
        .thenReturn(true);

    setPrerequisitesForSuccessfulPostTime(user, tags);

    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup()
        .durationSplitStrategy(TimeGroup.DurationSplitStrategyEnum.WHOLE_DURATION_TO_EACH_TAG)
        .narrativeType(TimeGroup.NarrativeTypeEnum.ONLY)
        .timeRows(ImmutableList.of(earliestTimeRow, latestTimeRow))
        .tags(tags)
        .user(user)
        .totalDurationSecs(3000);

    assertThat(connector.postTime(timeGroup).getStatus())
        .isEqualTo(PostResultStatus.SUCCESS);

    ArgumentCaptor<Worklog> worklogCaptor = ArgumentCaptor.forClass(Worklog.class);
    verify(postTimeDaoMock, times(2)).createWorklog(worklogCaptor.capture());
    List<Worklog> worklogs = worklogCaptor.getAllValues();

    assertThat(worklogs.get(0).getNarrative())
        .as("time rows should be grouped by segment hour in ascending order")
        .startsWith(timeGroup.getDescription())
        .doesNotContain(earliestTimeRow.getActivity(), earliestTimeRow.getDescription())
        .doesNotContain(latestTimeRow.getActivity(), latestTimeRow.getDescription())
        .doesNotContain("Total Worked Time");

    assertThat(worklogs.get(0).getNarrative())
        .isEqualTo(worklogs.get(1).getNarrative());
  }

  @Test
  void postTime_worklog_has_valid_start_time() {
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup()
        .timeRows(ImmutableList.of(
            fakeGenerator.randomTimeRow()
                .activityTypeCode(DEFAULT_ACTIVITY_CODE).activityHour(2018110115).firstObservedInHour(0),
            fakeGenerator.randomTimeRow()
                .activityTypeCode(DEFAULT_ACTIVITY_CODE).activityHour(2018110114).firstObservedInHour(0)))
        .tags(ImmutableList.of(fakeGenerator.randomTag(TAG_UPSERT_PATH, "tag")));

    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of("123"));

    when(postTimeDaoMock.doesActivityCodeExist(any()))
        .thenReturn(true);

    when(postTimeDaoMock.findMatterIdByTagName(any()))
        .thenReturn(Optional.of("123"));

    assertThat(connector.postTime(timeGroup).getStatus())
        .isEqualTo(PostResultStatus.SUCCESS);

    ArgumentCaptor<Worklog> worklogCaptor = ArgumentCaptor.forClass(Worklog.class);
    verify(postTimeDaoMock, times(1)).createWorklog(worklogCaptor.capture());

    final OffsetDateTime expectedActivityStartTime = OffsetDateTime.of(2018, 11, 1, 14, 0, 0, 0, ZoneOffset.ofHours(0));
    assertThat(worklogCaptor.getValue().getStartTime())
        .isEqualTo(expectedActivityStartTime);
  }

  /**
   * Total duration could be modified by the user.
   */
  @Test
  void postTime_worklog_has_valid_duration() {
    // time groups can now only have at most one tag
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup()
        .user(fakeGenerator.randomUser().experienceWeightingPercent(40))
        .timeRows(ImmutableList.of(
            fakeGenerator.randomTimeRow().activityTypeCode(DEFAULT_ACTIVITY_CODE).durationSecs(60),
            fakeGenerator.randomTimeRow().activityTypeCode(DEFAULT_ACTIVITY_CODE).durationSecs(8 * 60)))
        .totalDurationSecs(20 * 60)
        .durationSplitStrategy(TimeGroup.DurationSplitStrategyEnum.DIVIDE_BETWEEN_TAGS)
        .tags(ImmutableList.of(fakeGenerator.randomTag(TAG_UPSERT_PATH, "tag1")));

    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of("123"));

    when(postTimeDaoMock.doesActivityCodeExist(any()))
        .thenReturn(true);

    when(postTimeDaoMock.findMatterIdByTagName("tag1"))
        .thenReturn(Optional.of("123"));

    assertThat(connector.postTime(timeGroup).getStatus())
        .isEqualTo(PostResultStatus.SUCCESS);

    ArgumentCaptor<Worklog> worklogCaptor = ArgumentCaptor.forClass(Worklog.class);
    verify(postTimeDaoMock, times(1)).createWorklog(worklogCaptor.capture());

    List<Worklog> allValues = worklogCaptor.getAllValues();
    assertThat(allValues.get(0).getDurationSeconds())
        .isEqualTo(540);
  }

  /**
   * Total duration could be modified by the user.
   */
  @Test
  void postTime_worklog_has_valid_chargeable_time() {
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup(DEFAULT_ACTIVITY_CODE)
        .totalDurationSecs(1000)
        .user(fakeGenerator.randomUser().experienceWeightingPercent(40))
        // getPerTagDuration ?? strategy
        .tags(ImmutableList.of(fakeGenerator.randomTag(TAG_UPSERT_PATH, "tag")));

    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of("123"));

    when(postTimeDaoMock.doesActivityCodeExist(any()))
        .thenReturn(true);

    when(postTimeDaoMock.findMatterIdByTagName(any()))
        .thenReturn(Optional.of("123"));

    assertThat(connector.postTime(timeGroup).getStatus())
        .isEqualTo(PostResultStatus.SUCCESS);

    ArgumentCaptor<Worklog> worklogCaptor = ArgumentCaptor.forClass(Worklog.class);
    verify(postTimeDaoMock, times(1)).createWorklog(worklogCaptor.capture());

    final int expectedChargeableTimeSeconds = 400;
    assertThat(worklogCaptor.getValue().getChargeableTimeSeconds())
        .isEqualTo(expectedChargeableTimeSeconds);
  }

  @Test
  void postTime_post_time_not_successful() {
    when(postTimeDaoMock.findUserId(any()))
        .thenReturn(Optional.of("123"));
    when(postTimeDaoMock.doesActivityCodeExist(any()))
        .thenReturn(true);

    when(postTimeDaoMock.findMatterIdByTagName(any()))
        .thenReturn(Optional.of("123"));
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup(DEFAULT_ACTIVITY_CODE)
        .totalDurationSecs(1000)
        .user(fakeGenerator.randomUser().experienceWeightingPercent(40))
        .tags(ImmutableList.of(fakeGenerator.randomTag(TAG_UPSERT_PATH, "tag")));
    doThrow(new IllegalStateException("Detailed error message why posting time failed"))
        .when(postTimeDaoMock).createWorklog(any());

    final PostResult result = connector.postTime(timeGroup);

    assertThat(result.getStatus())
        .as("should return permanent failure if the posted time was rejected")
        .isEqualTo(PostResultStatus.PERMANENT_FAILURE);
    assertThat(result.getMessage())
        .as("reason for failure should be the msg of the IllegalStateException")
        .contains("Detailed error message why posting time failed");
  }

  @Test
  void postTime_post_time_not_successful_tag_not_found_in_db() {
    Tag tag = fakeGenerator.randomTag(TAG_UPSERT_PATH, "non_existing_tag");
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup(DEFAULT_ACTIVITY_CODE)
        .totalDurationSecs(1000)
        .user(fakeGenerator.randomUser().experienceWeightingPercent(40))
        .tags(ImmutableList.of(tag));
    when(postTimeDaoMock.findMatterIdByTagName(tag.getName()))
        .thenReturn(Optional.empty());
    final PostResult result = connector.postTime(timeGroup);

    assertThat(result.getStatus())
        .as("should return permanent failure if the posted time was rejected")
        .isEqualTo(PostResultStatus.PERMANENT_FAILURE);
  }

  @Test
  void postTime_post_time_successful_tag_not_managed() {
    Tag tag = fakeGenerator.randomTag("/Wrong/", "non_existing_tag");
    final TimeGroup timeGroup = fakeGenerator.randomTimeGroup(DEFAULT_ACTIVITY_CODE)
        .totalDurationSecs(1000)
        .user(fakeGenerator.randomUser().experienceWeightingPercent(40))
        .tags(ImmutableList.of(tag));
    final PostResult result = connector.postTime(timeGroup);

    assertThat(result.getStatus())
        .as("should return success for tag not managed by this connector")
        .isEqualTo(PostResultStatus.SUCCESS);
  }


  private void setPrerequisitesForSuccessfulPostTime(User user, List<Tag> tags) {
    when(postTimeDaoMock.findUserId(user.getExternalId()))
        .thenReturn(Optional.of("123"));

    tags.forEach(tag -> when(postTimeDaoMock.findMatterIdByTagName(tag.getName()))
        .thenReturn(Optional.of("123")));
  }
}
