/*
 * Copyright (c) 2019 Practice Insight Pty Ltd. All Rights Reserved.
 */

buildscript {
  repositories {
    mavenCentral()
    maven {
      // WT published releases
      setUrl("https://s3.eu-central-1.amazonaws.com/artifacts.wisetime.com/mvn2/plugins")
      content {
        includeGroup("io.wisetime")
      }
    }
  }
}

plugins {
  java
  idea
  id("fr.brouillard.oss.gradle.jgitver") version "0.9.1"
  id("com.google.cloud.tools.jib") version "3.0.0"
  id("com.github.ben-manes.versions") version "0.38.0"
  id("io.wisetime.versionChecker") version "10.11.59"
  id("io.freefair.lombok") version "5.3.0"
}

apply(from = "$rootDir/gradle/conf/checkstyle.gradle")
apply(from = "$rootDir/gradle/conf/jacoco.gradle")

java {
  toolchain {
    languageVersion.set(JavaLanguageVersion.of(11))
    vendor.set(JvmVendorSpec.ADOPTOPENJDK)
    implementation.set(JvmImplementation.J9)
  }
  consistentResolution {
    useCompileClasspathVersions()
  }
}

group = "io.wisetime"

jib {
  container {
    ports = listOf("9100")
    mainClass = "io.wisetime.connector.sql_time_post.ConnectorLauncher"
    jvmFlags = listOf("-server", "-Djava.awt.headless=true")
  }
  from {
    image = "gcr.io/wise-pub/connect-java-11-j9@sha256:98ec5f00539bdffeb678c3b4a34c07c77e4431395286ecc6a083298089b3d0ec"
  }
  to {
    project.afterEvaluate { // <-- so we evaluate version after it has been set
      image = "wisetime/wisetime-sql-time-post-connector:${project.version}"
    }
  }
}

repositories {
  mavenCentral()
  maven {
    // Our published releases repo
    setUrl("https://s3.eu-central-1.amazonaws.com/artifacts.wisetime.com/mvn2/releases")
    content {
      includeGroup("io.wisetime")
    }
  }
}

tasks.withType(com.google.cloud.tools.jib.gradle.JibTask::class.java) {
  dependsOn(tasks.compileJava)
  onlyIf {
    val versionCalculator = fr.brouillard.oss.jgitver.GitVersionCalculator.location(project.rootDir)
      .setAutoIncrementPatch(false)
      .setUseDirty(true)
    val branchName = versionCalculator.meta(fr.brouillard.oss.jgitver.metadata.Metadatas.BRANCH_NAME).orElse("")
    branchName == "master"
  }
}

if (gradle.startParameter.taskRequests.toString().contains("dependencyUpdates")) {
  // add exclusions for reporting on updates and vulnerabilities
  apply(from = "$rootDir/gradle/versionPluginConfig.gradle")
}

dependencies {
  implementation("io.wisetime:wisetime-connector:3.0.13")

  implementation("com.google.inject:guice:5.0.1") {
    exclude(group = "com.google.guava", module = "guava")
  }
  implementation("com.google.guava:guava:30.1-jre")

  implementation("org.codejargon:fluentjdbc:1.8.6")
  implementation("com.zaxxer:HikariCP:3.3.1")
  implementation("com.microsoft.sqlserver:mssql-jdbc:6.4.0.jre8")
  implementation("mysql:mysql-connector-java:8.0.21") {
    exclude(group = "com.google.protobuf", module = "protobuf-java")
  }
  implementation("org.postgresql:postgresql:42.2.16")

  implementation("org.yaml:snakeyaml:1.24")

  testImplementation("org.junit.jupiter:junit-jupiter:5.4.2")
  testImplementation("org.mockito:mockito-core:2.27.0")
  testImplementation("org.assertj:assertj-core:3.12.2")
  testImplementation("org.flywaydb:flyway-core:7.5.4")
  testImplementation("com.github.javafaker:javafaker:0.17.2") {
    exclude(group = "org.apache.commons", module = "commons-lang3")
  }
  testImplementation("io.wisetime:wisetime-test-support:2.6.13")
}

configurations.all {
  resolutionStrategy {
    eachDependency {
      if (requested.group == "com.fasterxml.jackson.core") {
        useVersion("2.12.3")
        because("use consistent version for all transitive dependencies")
      }
      if (requested.name == "commons-lang3") {
        useVersion("3.12.0")
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

tasks.clean {
  delete("${projectDir}/out")
}

jgitver {
  autoIncrementPatch(false)
  strategy(fr.brouillard.oss.jgitver.Strategies.PATTERN)
  versionPattern("\${meta.CURRENT_VERSION_MAJOR}.\${meta.CURRENT_VERSION_MINOR}.\${meta.COMMIT_DISTANCE}")
  regexVersionTag("v(\\d+\\.\\d+(\\.0)?)")
}
