/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.fake;

import static java.lang.String.format;

import com.github.javafaker.Faker;
import io.wisetime.generated.connect.Tag;
import io.wisetime.generated.connect.TimeGroup;
import io.wisetime.generated.connect.TimeRow;
import io.wisetime.generated.connect.User;
import java.util.List;
import java.util.UUID;
import java.util.function.Supplier;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * Generator of entities with random field values. Typically used to mock real data.
 *
 * @author pascal
 */
public class FakeTimeGroupGenerator {

  private static final Faker FAKER = new Faker();
  private static final String TAG_PATH = format("/%s/%s/", FAKER.lorem().word(), FAKER.lorem().word());

  public TimeGroup randomTimeGroup() {
    return randomTimeGroup(FAKER.lorem().word());
  }

  public TimeGroup randomTimeGroup(String activityTypeCode) {
    final Supplier<TimeRow> timeRowSupplier = () -> randomTimeRow(activityTypeCode);
    final List<TimeRow> timeRows = randomEntities(timeRowSupplier, 1, 10);

    return new TimeGroup()
        .callerKey(FAKER.bothify("#?#?#?#?#?"))
        .groupId(UUID.randomUUID().toString())
        .description(FAKER.lorem().paragraph())
        .totalDurationSecs(timeRows.stream().mapToInt(TimeRow::getDurationSecs).sum())
        .groupName(FAKER.color().name())
        .tags(randomEntities(() -> randomTag(TAG_PATH), 1, 3))
        .user(randomUser())
        .timeRows(timeRows)
        .narrativeType(randomEnum(TimeGroup.NarrativeTypeEnum.class))
        .durationSplitStrategy(randomEnum(TimeGroup.DurationSplitStrategyEnum.class));
  }

  public Tag randomTag(final String path) {
    return randomTag(path, FAKER.letterify("??-") + FAKER.number().numberBetween(1000, 9999));
  }

  public Tag randomTag(final String tagUpsertPath, final String name) {
    return new Tag()
        .path(tagUpsertPath)
        .name(name)
        .description(FAKER.lorem().characters(30, 200));
  }

  public User randomUser() {
    final String firstName = FAKER.name().firstName();
    final String lastName = FAKER.name().lastName();
    final String usernameFull = FAKER.name().username();
    final String username = usernameFull.length() > 6 ? usernameFull.substring(0, 6) : usernameFull;
    return new User()
        .name(firstName + " " + lastName)
        .email(FAKER.internet().emailAddress(firstName))
        .externalId(username)
        .businessRole(FAKER.company().profession())
        .experienceWeightingPercent(FAKER.random().nextInt(0, 100));
  }

  public TimeRow randomTimeRow() {
    return new TimeRow()
        .activity(FAKER.lorem().characters(10, 30))
        .activityHour(2018110100 + FAKER.random().nextInt(1, 23))
        .firstObservedInHour(FAKER.number().numberBetween(0, 59))
        .durationSecs(FAKER.random().nextInt(120, 600))
        .submittedDate(Long.valueOf(FAKER.numerify("2018091#1#5#2####")))
        .modifier(FAKER.lorem().word())
        .description(FAKER.lorem().sentence())
        .source(randomEnum(TimeRow.SourceEnum.class));
  }

  public TimeRow randomTimeRow(String activityTypeCode) {
    return randomTimeRow().activityTypeCode(activityTypeCode);
  }

  private <T> List<T> randomEntities(final Supplier<T> supplier, final int min, final int max) {
    return IntStream
        .range(0, FAKER.random().nextInt(min, max))
        .mapToObj(i -> supplier.get())
        .collect(Collectors.toList());
  }

  private static <T extends Enum<?>> T randomEnum(final Class<T> clazz) {
    final int index = FAKER.random().nextInt(clazz.getEnumConstants().length);
    return clazz.getEnumConstants()[index];
  }
}
