import io.wisetime.version.GitVersionCalc
import io.wisetime.version.model.LegebuildConst

/*
 * Copyright (c) 2019 Practice Insight Pty Ltd. All Rights Reserved.
 */

plugins {
  java
  idea
  id("com.google.cloud.tools.jib") version "3.3.1"
  id("com.github.ben-manes.versions") version "0.48.0"
  id("io.wisetime.versionChecker")
  id("io.freefair.lombok") version "8.3"
}

apply(from = "$rootDir/gradle/conf/checkstyle.gradle")
apply(from = "$rootDir/gradle/conf/jacoco.gradle")

java {
  sourceCompatibility = JavaVersion.VERSION_17
  targetCompatibility = JavaVersion.VERSION_17
}

val versionInfo: GitVersionCalc.WiFiGitVersionInfo = GitVersionCalc.getVersionInfoForLibrary(project.rootDir)
val branchName: String = versionInfo.branchName
// only run jib on master
project.tasks.getByPath("jib").setOnlyIf { branchName == "master" }
project.version = versionInfo.gitVersionStr

group = "io.wisetime"

jib {
  container {
    ports = listOf("9100")
    mainClass = "io.wisetime.connector.sql_time_post.ConnectorLauncher"
    jvmFlags = listOf("-Djava.awt.headless=true")
  }
  from {
    platforms {
      platform {
        os = "linux"
        architecture = "amd64"
      }
    }
    image = "europe-west3-docker.pkg.dev/wise-pub/tools/jdk/jdk:17.0.13"
  }
  to {
    project.afterEvaluate { // <-- so we evaluate version after it has been set
      image = "europe-west3-docker.pkg.dev/wise-pub/connectors/wisetime-sql-time-post-connector:${project.version}"
    }
  }
}

repositories {
  mavenCentral()
  maven {
    // WiseTime artifacts
    url = uri("https://europe-west3-maven.pkg.dev/wise-pub/java")
    content {
      includeGroup("io.wisetime")
    }
  }
}


if (gradle.startParameter.taskRequests.toString().contains("dependencyUpdates")) {
  // add exclusions for reporting on updates and vulnerabilities
  apply(from = "$rootDir/gradle/versionPluginConfig.gradle")
}

dependencies {
  implementation("io.wisetime:wisetime-connector:5.1.7")

  implementation("com.google.inject:guice:${LegebuildConst.GUICE_VERSION}") {
    exclude(group = "com.google.guava", module = "guava")
  }
  implementation("com.google.guava:guava:${LegebuildConst.GUAVA_VERSION}")
  implementation("com.fasterxml.jackson.core:jackson-databind:${LegebuildConst.JACKSON_FASTER}")
  implementation("org.apache.commons:commons-lang3:${LegebuildConst.COMMONS_LANG3}")

  implementation("org.codejargon:fluentjdbc:1.8.6")
  implementation("com.zaxxer:HikariCP:5.0.1")
  implementation("com.microsoft.sqlserver:mssql-jdbc:9.2.1.jre15")
  implementation("mysql:mysql-connector-java:8.0.33") {
    exclude(group = "com.google.protobuf", module = "protobuf-java")
  }
  implementation("org.postgresql:postgresql:42.6.0")

  implementation("org.yaml:snakeyaml:1.24")

  testImplementation("org.junit.jupiter:junit-jupiter:5.9.3")
  testImplementation("org.mockito:mockito-core:2.27.0")
  testImplementation("org.assertj:assertj-core:3.12.2")
  testImplementation("org.flywaydb:flyway-core:7.5.4")
  testImplementation("com.github.javafaker:javafaker:1.0.2") {
    exclude(group = "org.apache.commons", module = "commons-lang3")
  }
  testImplementation("io.wisetime:wisetime-test-support:${LegebuildConst.WT_TEST_SUPPORT}")
}

configurations.all {
  resolutionStrategy {
    eachDependency {
      if (requested.group == "com.fasterxml.jackson.core") {
        useVersion(LegebuildConst.JACKSON_FASTER)
        because("use consistent version for all transitive dependencies")
      }
      if (requested.group == "joda-time" && requested.name == "joda-time") {
        useVersion(LegebuildConst.JODA_TIME)
        because("use consistent version for all transitive dependencies")
      }
      if (requested.name == "commons-lang3") {
        useVersion(LegebuildConst.COMMONS_LANG3)
        because("use consistent version for all transitive dependencies")
      }
    }
  }
}

tasks.register<DefaultTask>("printVersionStr") {
  doLast {
    println("${project.version}")
  }
}

tasks.test {
  useJUnitPlatform()
  testLogging {
    // "passed", "skipped", "failed"
    events("skipped", "failed")
  }
}

