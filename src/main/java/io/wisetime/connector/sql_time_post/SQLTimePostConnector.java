/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post;

import static io.wisetime.connector.utils.ActivityTimeCalculator.startTime;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.annotations.VisibleForTesting;
import com.google.inject.Inject;
import io.wisetime.connector.ConnectorModule;
import io.wisetime.connector.WiseTimeConnector;
import io.wisetime.connector.api_client.PostResult;
import io.wisetime.connector.sql_time_post.model.Worklog;
import io.wisetime.connector.sql_time_post.persistence.TimePostingDao;
import io.wisetime.connector.config.RuntimeConfig;
import io.wisetime.connector.sql_time_post.ConnectorLauncher.SQLPostTimeConnectorConfigKey;
import io.wisetime.connector.template.TemplateFormatter;
import io.wisetime.connector.template.TemplateFormatterConfig;
import io.wisetime.connector.utils.DurationCalculator;
import io.wisetime.connector.utils.DurationSource;
import io.wisetime.generated.connect.Tag;
import io.wisetime.generated.connect.TimeGroup;
import io.wisetime.generated.connect.TimeRow;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.temporal.ChronoField;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import spark.Request;

/**
 * WiseTime Connector implementation for generic time posting
 *
 * @author pascal
 */
public class SQLTimePostConnector implements WiseTimeConnector {

  private static final Logger log = LoggerFactory.getLogger(SQLTimePostConnector.class);
  private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

  private TemplateFormatter narrativeFormatter;
  private TemplateFormatter narrativeInternalFormatter;

  @Inject
  private TimePostingDao postTimeDao;

  @Override
  public void init(ConnectorModule connectorModule) {
    String narrativePath = RuntimeConfig.getString(SQLPostTimeConnectorConfigKey.NARRATIVE_PATH).orElseThrow(() ->
        new IllegalArgumentException("Narrative Template path must be configured"));
    Optional<String> narrativeInternalPath =
        RuntimeConfig.getString(SQLPostTimeConnectorConfigKey.NARRATIVE_INTERNAL_PATH);

    narrativeFormatter = new TemplateFormatter(
        TemplateFormatterConfig.builder()
            .withTemplatePath(narrativePath)
            .withWindowsClr(true)
            .build()
    );
    narrativeInternalPath.ifPresent(s -> narrativeInternalFormatter = new TemplateFormatter(
        TemplateFormatterConfig.builder()
            .withTemplatePath(s)
            .withWindowsClr(true)
            .build()
    ));
  }

  @Override
  public String getConnectorType() {
    return "wisetime-sql-time-post-connector";
  }

  @Override
  public boolean isConnectorHealthy() {
    return postTimeDao.canQueryDb();
  }

  @Override
  public void performTagUpdate() {
    // time posting only
  }

  @Override
  public void performTagUpdateSlowLoop() {
    // time posting only
  }

  @Override
  public PostResult postTime(Request request, TimeGroup timeGroup) {
    log.info("Posted time received: {}", timeGroup.getGroupId());

    List<Tag> relevantTags = timeGroup.getTags().stream()
        .filter(tag -> {
          if (!createdByConnector(tag)) {
            log.warn("The connector is not configured to handle this tag: {}. No time will be posted for this tag.",
                tag.getName());
            return false;
          }
          return true;
        })
        .collect(Collectors.toList());
    timeGroup.setTags(relevantTags);

    if (timeGroup.getTags().isEmpty()) {
      return PostResult.SUCCESS().withMessage("Time group has no tags. There is nothing to post.");
    }

    final Optional<LocalDateTime> activityStartTime = startTime(timeGroup);
    if (!activityStartTime.isPresent()) {
      return PostResult.PERMANENT_FAILURE().withMessage("Cannot post time group with no time rows");
    }

    final String emailOrExternalId = StringUtils.isNotBlank(timeGroup.getUser().getExternalId())
        ? timeGroup.getUser().getExternalId()
        : timeGroup.getUser().getEmail();

    Optional<String> userId = postTimeDao.findUserId(emailOrExternalId);
    if (!userId.isPresent()) {
      return PostResult.PERMANENT_FAILURE().withMessage("User does not exist in the connected system.");
    }

    final Optional<String> activityCode = getTimeGroupActivityCode(timeGroup);
    if (!activityCode.isPresent()) {
      return PostResult.PERMANENT_FAILURE().withMessage("Time group has an invalid activity code");
    }

    final String narrative = narrativeFormatter.format(convertToZone(timeGroup, getTimeZoneId()));
    String narrativeInternal = null;
    if (narrativeInternalFormatter != null) {
      narrativeInternal = narrativeInternalFormatter.format(convertToZone(timeGroup, getTimeZoneId()));
    }
    final int workedTimeSeconds = Math.round(DurationCalculator.of(timeGroup)
        .disregardExperienceWeighting()
        .useDurationFrom(DurationSource.SUM_TIME_ROWS)
        .calculate());
    final int chargeableTimeSeconds = Math.round(DurationCalculator.of(timeGroup)
        .useExperienceWeighting()
        .calculate());

    String finalNarrativeInternal = narrativeInternal;
    final Function<String, String> createWorklog = caseOrClientNumber -> {
      final Worklog worklog = new Worklog()
          .setCaseId(caseOrClientNumber)
          .setUserId(userId.get())
          .setActivityCode(activityCode.get())
          .setNarrative(narrative)
          .setNarrativeInternal(finalNarrativeInternal)
          .setStartTime(OffsetDateTime.of(activityStartTime.get(), ZoneOffset.UTC))
          .setDurationSeconds(workedTimeSeconds)
          .setChargeableTimeSeconds(chargeableTimeSeconds);

      postTimeDao.createWorklog(worklog);
      return caseOrClientNumber;
    };

    try {
      postTimeDao.asTransaction(() ->
          timeGroup.getTags()
              .stream()
              .map(findCaseNumber)
              .filter(Optional::isPresent)
              .map(Optional::get)
              .map(createWorklog)
              .forEach(caseNumber ->
                  log.info("Posted time {} to case {}",
                      timeGroup.getGroupId(), caseNumber)
              )
      );
    } catch (CaseNotFoundException e) {
      log.warn("Can't post time to the database: " + e.getMessage());
      return PostResult.PERMANENT_FAILURE()
          .withError(e)
          .withMessage(e.getMessage());
    } catch (IllegalStateException ex) {
      // Thrown if the posted time was rejected
      return PostResult.PERMANENT_FAILURE()
          .withError(ex)
          .withMessage(ex.getMessage());
    } catch (RuntimeException e) {
      return PostResult.TRANSIENT_FAILURE()
          .withError(e)
          .withMessage("There was an error posting time to the database");
    }
    return PostResult.SUCCESS();
  }

  private final Function<Tag, Optional<String>> findCaseNumber = tag -> {
    if (!createdByConnector(tag)) {
      log.warn("The connector is not configured to handle this tag: {}. No time will be posted for this tag.",
          tag.getName());
      return Optional.empty();
    }
    final Optional<String> tagId = postTimeDao.findCaseIdByTagName(tag.getName());
    if (tagId.isPresent()) {
      return tagId;
    }
    throw new CaseNotFoundException("Can't find case for tag " + tag.getName());
  };

  @VisibleForTesting
  Set<String> getTimeGroupActivityCodes(final TimeGroup timeGroup) {
    return timeGroup.getTimeRows().stream()
        .map(TimeRow::getActivityTypeCode)
        .collect(Collectors.toSet());
  }

  private String tagUpsertPath() {
    return RuntimeConfig
        .getString(SQLPostTimeConnectorConfigKey.TAG_UPSERT_PATH)
        .orElse("/Inprotech/");
  }

  private Optional<String> getTimeGroupActivityCode(final TimeGroup timeGroup) {
    final Set<String> activityCodes = getTimeGroupActivityCodes(timeGroup);
    if (activityCodes.size() > 1) {
      log.error("All time logs within time group should have same activity type, but got: {}", activityCodes);
      return Optional.empty();
    }
    if (activityCodes.isEmpty()) {
      log.warn("Activity type is not set for time group {}", timeGroup.getGroupId());
      return Optional.empty();
    }

    final String activityType = activityCodes.iterator().next();

    if (postTimeDao.doesActivityCodeExist(activityType)) {
      return Optional.of(activityType);
    }

    return Optional.empty();
  }

  @Override
  public void shutdown() {
    postTimeDao.shutdown();
  }

  private boolean createdByConnector(Tag tag) {
    return tag.getPath().equals(tagUpsertPath()) ||
        tag.getPath().equals(StringUtils.strip(tagUpsertPath(), "/"));
  }

  private ZoneId getTimeZoneId() {
    return ZoneId.of(RuntimeConfig.getString(SQLPostTimeConnectorConfigKey.TIMEZONE).orElse("UTC"));
  }

  @VisibleForTesting
  TimeGroup convertToZone(TimeGroup timeGroupUtc, ZoneId zoneId) {
    try {
      final String timeGroupUtcJson = OBJECT_MAPPER.writeValueAsString(timeGroupUtc);
      final TimeGroup timeGroupCopy = OBJECT_MAPPER.readValue(timeGroupUtcJson, TimeGroup.class);
      timeGroupCopy.getTimeRows()
          .forEach(tr -> convertToZone(tr, zoneId));
      return timeGroupCopy;
    } catch (IOException ex) {
      throw new RuntimeException("Failed to convert TimeGroup to zone " + zoneId, ex);
    }
  }

  private void convertToZone(TimeRow timeRowUtc, ZoneId zoneId) {
    final Pair<Integer, Integer> activityTimePair = convertToZone(
        timeRowUtc.getActivityHour(), timeRowUtc.getFirstObservedInHour(), zoneId
    );

    timeRowUtc
        .activityHour(activityTimePair.getLeft())
        .firstObservedInHour(activityTimePair.getRight())
        .setSubmittedDate(convertToZone(timeRowUtc.getSubmittedDate(), zoneId));
  }

  /**
   * Returns a Pair of "activity hour" (left value) and "first observed in hour" (right value) converted
   * in the specified zone ID.
   */
  private Pair<Integer, Integer> convertToZone(int activityHourUtc, int firstObservedInHourUtc, ZoneId toZoneId) {
    final DateTimeFormatter activityTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmm");
    final String activityTimeUTC = activityHourUtc + StringUtils.leftPad(String.valueOf(firstObservedInHourUtc), 2, "0");
    final String activityTimeConverted = ZonedDateTime
        .of(LocalDateTime.parse(activityTimeUTC, activityTimeFormatter), ZoneOffset.UTC)
        .withZoneSameInstant(toZoneId)
        .format(activityTimeFormatter);

    return Pair.of(
        Integer.parseInt(activityTimeConverted.substring(0, 10)), // activityHour in 'yyyyMMddHH' format
        Integer.parseInt(activityTimeConverted.substring(10))     // firstObservedInHour in 'mm' format
    );
  }

  private Long convertToZone(long submittedDateUtc, ZoneId toZoneId) {
    DateTimeFormatter submittedDateFormatter = new DateTimeFormatterBuilder()
        .appendPattern("yyyyMMddHHmmss")
        .appendValue(ChronoField.MILLI_OF_SECOND, 3)
        .toFormatter();
    final String submittedDateConverted = ZonedDateTime
        .of(LocalDateTime.parse(String.valueOf(submittedDateUtc), submittedDateFormatter), ZoneOffset.UTC)
        .withZoneSameInstant(toZoneId)
        .format(submittedDateFormatter);

    return Long.parseLong(submittedDateConverted);
  }

  private static class CaseNotFoundException extends RuntimeException {
    CaseNotFoundException(String message) {
      super(message);
    }
  }
}
