/*
 * Copyright (c) 2021 Practice Insight Pty Ltd. All Rights Reserved.
 */

package io.wisetime.connector.sql_time_post;

import com.github.dockerjava.api.command.CreateContainerCmd;
import io.wisetime.test_docker.ContainerDefinition;
import io.wisetime.test_docker.ContainerRuntimeSpec;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.Function;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author dchandler
 */
public class MySqlServer implements ContainerDefinition {

  private static final Logger log = LoggerFactory.getLogger(MySqlServer.class);

  @Override
  public String getImageId() {
    return "mysql/mysql-server:8.0.23";
  }

  @Override
  public String getShortName() {
    return "mysql";
  }

  @Override
  public Function<ContainerRuntimeSpec, Boolean> containerReady() {
    return container -> {
      final String className = "com.mysql.cj.jdbc.Driver";
      try {
        Class.forName(className);
      } catch (ClassNotFoundException e) {
        throw new RuntimeException(
            String.format("Please add MySql server jdbc driver (%s) to your classpath to use '%s' test container",
                getClass().getName(),
                className)
        );
      }

      // during creation we use containerType.getShortName() for username, psw and db name
      String jdbcUrl = getJdbcUrl(container);
      try (Connection connection = DriverManager.getConnection(jdbcUrl, "foo", "bar")) {
        log.info("unexpected user/pass accepted, connection is ready! ({})", connection.getSchema());
        return true;
      } catch (SQLException sqlException) {
        if ("08S01".equals(sqlException.getSQLState())) {
          log.debug("MySql server not accepting connections, retrying {}", jdbcUrl);
          return false;
        }
        if ("28000".equalsIgnoreCase(sqlException.getSQLState())
            || sqlException.getMessage().toLowerCase().contains("access denied")) {
          log.debug("MySql server is ready to accept connections (auth denied)");
          return true;
        }
        log.info("MySql server container in unexpected state {} {} (assume not ready) {}",
            sqlException.getSQLState(),
            sqlException.getMessage(),
            jdbcUrl
        );
        return false;
      } catch (Exception e) {
        log.warn("connection failure {}, retrying", e.getMessage());
        return false;
      }
    };
  }

  public String getJdbcUrl(ContainerRuntimeSpec container) {
    return String.format("jdbc:mysql://%s:%d/%s",
        container.getContainerIpAddress(),
        container.getRequiredMappedPort(getPort()),
        getDatabase());
  }

  @Override
  public Function<CreateContainerCmd, CreateContainerCmd> modifyCreateCommand() {
    // return createCmd unmodified by default
    return createCmd -> {
      List<String> envList = new ArrayList<>();
      if (createCmd.getEnv() != null && createCmd.getEnv().length > 0) {
        envList.addAll(Arrays.asList(createCmd.getEnv()));
      }
      envList.add("MYSQL_RANDOM_ROOT_PASSWORD=yes");
      envList.add("MYSQL_DATABASE=" + getDatabase());
      envList.add("MYSQL_USER=" + getUsername());
      envList.add("MYSQL_PASSWORD=" + getPassword());
      return createCmd.withEnv(envList);
    };
  }

  public String getUsername() {
    return "docker";
  }

  public String getPassword() {
    return "docker";
  }

  public String getDatabase() {
    return "docker";
  }

  public int getPort() {
    return 3306;
  }
}
