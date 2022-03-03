/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post;

import com.google.common.annotations.VisibleForTesting;
import com.google.inject.Inject;
import io.wisetime.connector.ConnectorModule;
import io.wisetime.connector.WiseTimeConnector;
import io.wisetime.connector.api_client.PostResult;
import io.wisetime.connector.config.RuntimeConfig;
import io.wisetime.connector.sql_time_post.ConnectorLauncher.SqlPostTimeConnectorConfigKey;
import io.wisetime.connector.sql_time_post.model.Worklog;
import io.wisetime.connector.sql_time_post.persistence.TimePostingDao;
import io.wisetime.connector.template.TemplateFormatter;
import io.wisetime.connector.template.TemplateFormatterConfig;
import io.wisetime.connector.template.TemplateFormatterConfig.DisplayZone;
import io.wisetime.connector.utils.ActivityTimeCalculator;
import io.wisetime.connector.utils.DurationCalculator;
import io.wisetime.connector.utils.DurationSource;
import io.wisetime.generated.connect.Tag;
import io.wisetime.generated.connect.TimeGroup;
import io.wisetime.generated.connect.TimeRow;
import java.time.Instant;
import java.time.ZoneId;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;
import org.apache.commons.lang3.StringUtils;
import org.codejargon.fluentjdbc.api.FluentJdbcSqlException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * WiseTime Connector implementation for generic time posting
 *
 * @author pascal
 */
public class SqlTimePostConnector implements WiseTimeConnector {

  private static final Logger log = LoggerFactory.getLogger(SqlTimePostConnector.class);

  private TemplateFormatter narrativeFormatter;
  private Optional<TemplateFormatter> narrativeInternalFormatter;

  @Inject
  private TimePostingDao postTimeDao;

  @Override
  public void init(ConnectorModule connectorModule) {
    // check if tag upsert path is configured. Default value doesn't make sense for this connector.
    tagUpsertPath();
    String narrativePath = RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.NARRATIVE_PATH).orElseThrow(() ->
        new IllegalArgumentException("Narrative Template path must be configured"));
    Optional<String> narrativeInternalPath =
        RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.NARRATIVE_INTERNAL_PATH);

    narrativeFormatter = new TemplateFormatter(
        TemplateFormatterConfig.builder()
            .withTemplatePath(narrativePath)
            .withWindowsClr(true)
            .withDisplayZone(DisplayZone.USER_LOCAL)
            .build()
    );
    narrativeInternalFormatter = narrativeInternalPath.map(s -> new TemplateFormatter(
        TemplateFormatterConfig.builder()
            .withTemplatePath(s)
            .withWindowsClr(true)
            .withDisplayZone(DisplayZone.USER_LOCAL)
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
    log.info("TAG_SCAN should be set to DISABLED");
  }

  @Override
  public void performTagUpdateSlowLoop() {
    // time posting only
    log.info("TAG_SCAN should be set to DISABLED");
  }

  @Override
  public void performActivityTypeUpdate() {
    // Activity type update is not performed in this connector
  }

  @Override
  public PostResult postTime(TimeGroup timeGroup) {
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

    final Optional<Instant> activityStartTime = ActivityTimeCalculator.startInstant(timeGroup);
    if (activityStartTime.isEmpty()) {
      return PostResult.PERMANENT_FAILURE().withMessage("Cannot post time group with no time rows");
    }

    final String emailOrExternalId = StringUtils.isNotBlank(timeGroup.getUser().getExternalId())
        ? timeGroup.getUser().getExternalId()
        : timeGroup.getUser().getEmail();

    Optional<String> userId = postTimeDao.findUserId(emailOrExternalId);
    if (userId.isEmpty()) {
      return PostResult.PERMANENT_FAILURE().withMessage("User does not exist in the connected system.");
    }

    final Set<String> activityCodes = getTimeGroupActivityCodes(timeGroup);
    if (activityCodes.size() > 1) {
      // This should never happen as we only allow one activity type per time group in the frontend
      // Therefore the additional error log to better identify the issue
      // additionally providing better feedback as this situation may be fixable by the user
      log.error("All time logs within time group should have same activity type, but got: {}", activityCodes);
      return PostResult.PERMANENT_FAILURE().withMessage("Time group has multiple activity types assigned, "
          + "only one activity type per time group is supported.");
    }
    if (isActivityTypeMandatory() && activityCodes.isEmpty()) {
      return PostResult.PERMANENT_FAILURE().withMessage("Time group has no activity type assigned, "
          + "but activity types are mandatory.");
    }
    Optional<String> activityCode = activityCodes.stream().findFirst();
    if (activityCode.isPresent() && !verifyActivityCode(activityCode.get())) {
      return PostResult.PERMANENT_FAILURE().withMessage("The activity type of the Time Group could not be"
          + " verified in the external system.");
    }

    final String narrative = narrativeFormatter.format(timeGroup);
    Optional<String> narrativeInternal = narrativeInternalFormatter.map(f -> f.format(timeGroup));

    final int workedTimeSeconds = Math.round(DurationCalculator.of(timeGroup)
        .disregardExperienceWeighting()
        .useDurationFrom(DurationSource.SUM_TIME_ROWS)
        .roundToNearestSeconds(1) // no rounding
        .calculate());
    final int chargeableTimeSeconds = Math.round(DurationCalculator.of(timeGroup)
        .useExperienceWeighting()
        .roundToNearestSeconds(1) // no rounding
        .calculate());

    final Function<String, String> createWorklog = matterId -> {
      final Worklog worklog = new Worklog()
          .setMatterId(matterId)
          .setUserId(userId.get())
          .setNarrative(narrative)
          .setStartTime(activityStartTime.get().atZone(getTimeZoneId()).toOffsetDateTime())
          .setDurationSeconds(workedTimeSeconds)
          .setChargeableTimeSeconds(chargeableTimeSeconds);
      activityCode.ifPresent(worklog::setActivityCode);

      narrativeInternal.ifPresent(worklog::setNarrativeInternal);

      postTimeDao.createWorklog(worklog);
      return matterId;
    };

    return doPostTime(timeGroup, createWorklog);
  }

  private PostResult doPostTime(TimeGroup timeGroup, Function<String, String> createWorklog) {
    try {
      postTimeDao.asTransaction(() ->
          timeGroup.getTags()
              .stream()
              .map(findMatterId)
              .filter(Optional::isPresent)
              .map(Optional::get)
              .map(createWorklog)
              .forEach(matterId ->
                  log.info("Posted time {} to matter {}",
                      timeGroup.getGroupId(), matterId)
              )
      );
    } catch (MatterNotFoundException e) {
      log.warn("Can't post time to the database: " + e.getMessage());
      return PostResult.PERMANENT_FAILURE()
          .withError(e)
          .withMessage(e.getMessage());
    } catch (IllegalStateException ex) {
      // Thrown if the posted time was rejected
      return PostResult.PERMANENT_FAILURE()
          .withError(ex)
          .withMessage(ex.getMessage());
    } catch (FluentJdbcSqlException e) {
      // get underlying SQL error if it exists (which should always be the case for FluentJdbcSqlException
      // because it warps the underlying exception thrown by the jdbc API)
      String message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
      return PostResult.PERMANENT_FAILURE()
          .withError(e)
          .withMessage("A database error has occurred - please contact your administrator: " + message);
    } catch (RuntimeException e) {
      return PostResult.TRANSIENT_FAILURE()
          .withError(e)
          .withMessage("There was an unexpected error while posting time.");
    }
    return PostResult.SUCCESS();
  }

  private final Function<Tag, Optional<String>> findMatterId = tag -> {
    if (!createdByConnector(tag)) {
      log.warn("The connector is not configured to handle this tag: {}. No time will be posted for this tag.",
          tag.getName());
      return Optional.empty();
    }
    final Optional<String> tagId = postTimeDao.findMatterIdByExternalId(tag.getExternalId())
        .or(() -> postTimeDao.findMatterIdByTagName(tag.getName()));

    if (tagId.isPresent()) {
      return tagId;
    }
    throw new MatterNotFoundException("Can't find matter for tag " + tag.getName());
  };

  private String tagUpsertPath() {
    return RuntimeConfig
        .getString(SqlPostTimeConnectorConfigKey.TAG_UPSERT_PATH)
        .orElseThrow(() -> new IllegalArgumentException("TAG_UPSERT_PATH needs to be set"));
  }

  @VisibleForTesting
  Set<String> getTimeGroupActivityCodes(final TimeGroup timeGroup) {
    return timeGroup.getTimeRows().stream()
        .map(TimeRow::getActivityTypeCode)
        .filter(StringUtils::isNotBlank)
        .collect(Collectors.toSet());
  }

  private boolean verifyActivityCode(final String activityCode) {
    return postTimeDao.doesActivityCodeExist(activityCode);
  }

  @Override
  public void shutdown() {
    postTimeDao.shutdown();
  }

  private boolean createdByConnector(Tag tag) {
    return tag.getPath().equals(tagUpsertPath())
        || tag.getPath().equals(StringUtils.strip(tagUpsertPath(), "/"));
  }

  private ZoneId getTimeZoneId() {
    return ZoneId.of(RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.TIMEZONE).orElse("UTC"));
  }

  private boolean isActivityTypeMandatory() {
    return RuntimeConfig.getBoolean(SqlPostTimeConnectorConfigKey.ACTIVITY_TYPE_MANDATORY).orElse(true);
  }

  private static class MatterNotFoundException extends RuntimeException {
    MatterNotFoundException(String message) {
      super(message);
    }
  }
}
