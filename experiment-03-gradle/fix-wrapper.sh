#!/bin/bash
# Fix Gradle Wrapper
cd experiment-03-gradle

echo "Downloading Gradle wrapper..."

# Download wrapper jar
wget -q -O gradle/wrapper/gradle-wrapper.jar https://github.com/gradle/gradle/raw/v8.6.0/gradle/wrapper/gradle-wrapper.jar

echo "Wrapper downloaded. Building project..."

# Now build
chmod +x gradlew
./gradlew clean build

echo "Build complete!"
echo "Run: java -jar build/libs/gradle-demo-app-1.0.0.jar"
