/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post;

import static org.assertj.core.api.Assertions.assertThat;

import io.wisetime.connector.sql_time_post.fake.FakeTimeGroupGenerator;
import io.wisetime.generated.connect.TimeGroup;
import java.util.Set;
import org.junit.jupiter.api.Test;
import org.testcontainers.shaded.com.google.common.collect.ImmutableList;

/**
 * @author pascal
 */
class SqlTimePostConnectorUtilsTest {

  @Test
  void getTimeGroupModifiers_returns_all_unique_timerow_modifiers() {
    final SqlTimePostConnector connector = new SqlTimePostConnector();
    final FakeTimeGroupGenerator fakeEntities = new FakeTimeGroupGenerator();
    final String activityType1 = "123";
    final String activityType2 = null;
    final String activityType3 = "Modifier";
    final String activityType4 = "123";
    final TimeGroup timeGroup = fakeEntities.randomTimeGroup().timeRows(ImmutableList.of(
        fakeEntities.randomTimeRow(activityType1),
        fakeEntities.randomTimeRow(activityType2),
        fakeEntities.randomTimeRow(activityType3),
        fakeEntities.randomTimeRow(activityType4)
    ));
    final Set<String> modifiers = connector.getTimeGroupActivityCodes(timeGroup);
    assertThat(modifiers)
        .as("should not contain any duplicates")
        .hasSize(3);
    assertThat(modifiers)
        .as("should contain all distinct values")
        .contains(activityType1, activityType2, activityType3);
  }
}
