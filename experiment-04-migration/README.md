# Experiment 04: Maven to Gradle Migration

## Overview
This experiment demonstrates how to migrate a Maven project to Gradle.

## Migration Steps

### 1. Create settings.gradle
```bash
echo "rootProject.name = 'maven-demo-app'" > settings.gradle
```

### 2. Create build.gradle
Convert your pom.xml dependencies to Gradle format.

### 3. Copy source files
```bash
cp -r ../experiment-02-maven/src ./src
```

### 4. Generate Gradle Wrapper
```bash
gradle wrapper --gradle-version 8.6
chmod +x gradlew
```

### 5. Build with Gradle
```bash
./gradlew clean build
```

## Common Issues & Fixes

### Issue: Permission denied
```bash
chmod +x gradlew compare_builds.sh
```

### Issue: No settings.gradle or build.gradle
Run `gradle init` or create the files manually.

### Issue: Git merge conflicts
```bash
git pull --rebase
# If conflicts, fix them:
echo "rootProject.name = 'maven-demo-app'" > settings.gradle
git add settings.gradle
git rebase --continue
```

### Issue: Divergent branches
```bash
git pull --rebase
# Or abort and use merge:
git rebase --abort
git pull --no-rebase
```

## Run the App
```bash
./gradlew bootRun
# Or:
./gradlew build
java -jar build/libs/maven-demo-app-1.0.0.jar
```

## Compare Builds
```bash
chmod +x compare_builds.sh
./compare_builds.sh
```

## Gradle build.gradle (converted from pom.xml)
```groovy
plugins {
    id 'java'
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
}

group = 'com.devops.maven'
version = '1.0.0'

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springdoc:springdoc-openapi-starter-webmvc-ui:2.3.0'
    implementation 'org.springframework.boot:spring-boot-starter-actuator'
    
    testImplementation 'org.junit.jupiter:junit-jupiter:5.10.0'
    testRuntimeOnly 'org.junit.platform:junit-platform-launcher'
}

bootJar {
    archiveFileName = 'maven-demo-app-1.0.0.jar'
    mainClass = 'com.devops.maven.MavenDemoApplication'
}

test {
    useJUnitPlatform()
}
```
