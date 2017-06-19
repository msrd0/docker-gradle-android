# docker-gradle-android

Corresponding docker image: [msrd0/gradle-android](https://hub.docker.com/r/msrd0/gradle-android/)

The docker images is based on [`debian:stretch`](https://hub.docker.com/_/debian/) and contains (state 2017/06/19):

Software | Version
----------|--------
JDK | 1.8.0_131
Gradle | 3.2.1
Maven | 3.3.9

Android Component | Version
------------------|--------
Android SDK | 25.0.0
Android SDK Platform | 23
Android Build-Tools | 24.0.0
Android Support Repository | r47 (23.4.0)
Android Support Constraint Library | 1.0.2
Android Gradle Plugin | 2.2.2

Please note that lint is not working at the moment! This is not my fault but a problem with debian's android packages.

## Recommended Gradle Configuration

### Buildscript

```gradle
buildscript {
  repositories {
    mavenLocal()
    jcenter()
  }
  dependencies {
    // version 2.2.2 is in local maven repo -> quicker builds
    classpath 'com.android.tools.build:gradle:2.2.2'
  }
}
```

### Subproject

```gradle
repositories {
  mavenLocal()
  jcenter()
}

apply plugin: 'com.android.application'

android {
  // don't change those versions:
  compileSdkVersion 23
  buildToolsVersion "24.0.0"
  
  defaultConfig {
    targetSdkVersion 23
  }
  
  lintOptions {
    abortOnError false
  }
}

dependencies {
  // don't change those versions:
  compile 'com.android.support:appcompat-v7:23.4.0'
  compile 'com.android.support:support-v4:23.4.0'
  compile 'com.android.support:design:23.4.0'
  compile 'com.android.support.constraint:constraint-layout:1.0.2'
}
```
