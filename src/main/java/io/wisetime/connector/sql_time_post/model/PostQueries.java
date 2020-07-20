/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostQueries {

  private String canQueryDb;
  private String createWorklog;
  private String doesActivityCodeExist;
  private String findMatterIdByTagName;
  private String findUserId;
}
