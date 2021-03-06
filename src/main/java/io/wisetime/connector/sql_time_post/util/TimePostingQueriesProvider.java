/*
 * Copyright (c) 2020 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post.util;

import io.wisetime.connector.config.RuntimeConfig;
import io.wisetime.connector.sql_time_post.ConnectorLauncher.SqlPostTimeConnectorConfigKey;
import io.wisetime.connector.sql_time_post.model.TimePostingQueries;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import javax.inject.Provider;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.Constructor;

/**
 * @author pascal
 */
public class TimePostingQueriesProvider implements Provider<TimePostingQueries> {
  @Override
  public TimePostingQueries get() {
    String sqlPath = RuntimeConfig.getString(SqlPostTimeConnectorConfigKey.TIME_POST_SQL_PATH)
        .orElseThrow(() -> new IllegalStateException("TIME_POST_SQL_PATH must be set"));

    try {
      final Stream<String> lines = Files.lines(Paths.get(sqlPath));
      final String contents = lines.collect(Collectors.joining("\n"));
      lines.close();

      final Yaml yaml = new Yaml(new Constructor(TimePostingQueries.class));
      return yaml.load(contents);
    } catch (IOException e) {
      throw  new IllegalStateException("Error loading time post queries");
    }
  }
}
