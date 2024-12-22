/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.persistence;

import static org.assertj.core.api.Assertions.assertThat;

import io.wisetime.connector.sql_time_post.model.Worklog;
import io.wisetime.generated.connect.User;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.Optional;
import javax.inject.Inject;
import javax.inject.Singleton;
import lombok.Data;
import lombok.experimental.Accessors;
import org.codejargon.fluentjdbc.api.FluentJdbc;

/**
 * @author dchandler
 */
@Singleton
class PendingTimeTestHelper {

  @Inject
  private FluentJdbc fluentJdbc;

  Optional<PendingTime> getPendingTime() {
    return fluentJdbc.query().select("select * from wt_post_time")
        .firstResult(rs -> new PendingTime()
            .setCaseId(rs.getString("caseid"))
            .setUsername(rs.getString("username"))
            .setEmail(rs.getString("email"))
            .setActivityCode(rs.getString("activity_code"))
            .setNarrative(rs.getString("narrative"))
            .setNarrativeInternal(rs.getString("narrative_internal_note"))
            .setStartTime(OffsetDateTime.ofInstant(rs.getTimestamp("start_time").toInstant(),
                ZoneOffset.UTC))
            .setDurationSeconds(rs.getInt("total_time_secs"))
            .setChargeableTimeSeconds(rs.getInt("chargeable_time_secs")));
  }

  void assertPendingTime(PendingTime pendingTime, Worklog worklog, User user) {
    assertThat(pendingTime)
        .extracting(PendingTime::getCaseId,
            PendingTime::getActivityCode,
            PendingTime::getEmail,
            PendingTime::getUsername,
            PendingTime::getDurationSeconds,
            PendingTime::getChargeableTimeSeconds,
            PendingTime::getNarrativeInternal,
            PendingTime::getNarrative)
        .containsExactly(
            worklog.getMatterId(),
            worklog.getActivityCode(),
            user.getEmail(),
            user.getExternalId(),
            worklog.getDurationSeconds(),
            worklog.getChargeableTimeSeconds(),
            worklog.getNarrativeInternal(),
            worklog.getNarrative());

    assertThat(pendingTime.getStartTime())
        .isEqualToIgnoringSeconds(worklog.getStartTime());
  }

  /**
   * @author pascal
   */
  @Data
  @Accessors(chain = true)
  static class PendingTime {
    String caseId;

    String username;

    String email;

    String activityCode;

    String narrative;

    String narrativeInternal;

    OffsetDateTime startTime;

    int durationSeconds;

    int chargeableTimeSeconds;
  }
}
