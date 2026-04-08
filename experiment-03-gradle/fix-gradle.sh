#!/bin/bash
# Fix Gradle project - remove duplicate files

cd "$(dirname "$0")"

echo "Removing old lab files..."
rm -rf src/main/java/com/devops/lab
rm -rf src/test/java/com/devops/lab
rm -rf .gradle

echo "Cleaned! Now rebuild:"
./gradlew clean build

echo ""
echo "Run: java -jar build/libs/devops-gradle-app-1.0.0.jar"
