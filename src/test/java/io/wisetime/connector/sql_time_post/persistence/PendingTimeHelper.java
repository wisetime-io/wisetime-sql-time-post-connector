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
import lombok.Data;
import lombok.experimental.Accessors;
import org.codejargon.fluentjdbc.api.FluentJdbc;

/**
 * @author dchandler
 */
class PendingTimeHelper {

  private FluentJdbc fluentJdbc;

  PendingTimeHelper(FluentJdbc fluentJdbc) {
    this.fluentJdbc = fluentJdbc;
  }

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
    assertThat(pendingTime.getCaseId())
        .isEqualTo(worklog.getMatterId());
    assertThat(pendingTime.getActivityCode())
        .isEqualTo(worklog.getActivityCode());
    assertThat(pendingTime.getEmail())
        .isEqualTo(user.getEmail());
    assertThat(pendingTime.getUsername())
        .isEqualTo(user.getExternalId());
    assertThat(pendingTime.getStartTime())
        .isEqualToIgnoringSeconds(worklog.getStartTime());
    assertThat(pendingTime.getDurationSeconds())
        .isEqualTo(worklog.getDurationSeconds());
    assertThat(pendingTime.getChargeableTimeSeconds())
        .isEqualTo(worklog.getChargeableTimeSeconds());
    assertThat(pendingTime.getNarrativeInternal())
        .isEqualTo(worklog.getNarrativeInternal());
    assertThat(pendingTime.getNarrative())
        .isEqualTo(worklog.getNarrative());
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
