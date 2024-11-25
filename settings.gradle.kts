pluginManagement {
  plugins {
    id("io.wisetime.versionChecker") version "10.13.24"
  }
  repositories {
    gradlePluginPortal()
    maven {
      url = uri("https://europe-west3-maven.pkg.dev/wise-pub/gradle")
      content {
        includeGroup("io.wisetime.versionChecker")
      }
    }
  }
}
