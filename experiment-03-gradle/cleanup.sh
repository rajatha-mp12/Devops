# Delete old lab package files to fix Gradle build
# These files are duplicates causing build issues

rm -f src/main/java/com/devops/lab/App.java
rm -f src/main/java/com/devops/lab/Calculator.java
rm -f src/main/java/com/devops/lab/CalculatorController.java
rm -f src/main/java/com/devops/lab/DevOpsApplication.java
rm -f src/test/java/com/devops/lab/CalculatorTest.java
rmdir src/main/java/com/devops/lab 2>/dev/null || true
rmdir src/test/java/com/devops/lab 2>/dev/null || true
rmdir src/main/java/com/devops 2>/dev/null || true
rmdir src/test/java/com/devops 2>/dev/null || true

echo "Old lab files removed. Now rebuild:"
echo "./gradlew clean build"
