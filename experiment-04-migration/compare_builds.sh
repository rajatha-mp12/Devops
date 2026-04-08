#!/bin/bash
# compare_builds.sh — compare Maven vs Gradle build times

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"

# Clean up duplicate files in Gradle project before building
echo "Cleaning up Gradle project..."
cd "$PARENT_DIR/experiment-03-gradle"
rm -rf src/main/java/com/devops/lab 2>/dev/null || true
rm -rf src/test/java/com/devops/lab 2>/dev/null || true
rm -rf .gradle 2>/dev/null || true
echo "Cleanup complete."

echo '=== Maven Build Time ==='
cd "$PARENT_DIR/experiment-02-maven"
time mvn clean package -q

echo ''
echo '=== Gradle Build Time (cold) ==='
cd "$PARENT_DIR/experiment-03-gradle"
chmod +x gradlew 2>/dev/null || true
time ./gradlew clean build -q

echo ''
echo '=== Gradle Build Time (incremental - no change) ==='
cd "$PARENT_DIR/experiment-03-gradle"
time ./gradlew build -q
