/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.model;

import java.time.OffsetDateTime;
import lombok.Data;
import lombok.experimental.Accessors;

/**
 * @author pascal
 */
@Data
@Accessors(chain = true)
public class Worklog {
  String matterId;

  String userId;

  String activityCode;

  String narrative;

  String narrativeInternal;

  OffsetDateTime startTime;

  int durationSeconds;

  int chargeableTimeSeconds;
}
