/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.model;

import lombok.Data;
import lombok.experimental.Accessors;

import java.time.OffsetDateTime;

/**
 * @author pascal
 */
@Data
@Accessors(chain = true)
public class Worklog {
  String caseId;

  String userId;

  String activityCode;

  String narrative;

  String narrativeInternal;

  OffsetDateTime startTime;

  int durationSeconds;

  int chargeableTimeSeconds;
}
