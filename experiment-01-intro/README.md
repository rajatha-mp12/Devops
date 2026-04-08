# Experiment 01: Introduction & Tools Installation

## Aim
Understand Build Automation Tools — Overview of Maven and Gradle, their key differences, and perform installation and setup of both.

## Theory
Build automation tools manage the process of compiling source code, running tests, and packaging the final application.

## Files
- `install_devtools.sh` — Installs Java 17, Maven, Gradle 8.6, Git

## Usage

### Run Installation Script
```bash
chmod +x install_devtools.sh
sudo ./install_devtools.sh
```

### Verify Installation
```bash
java -version
mvn -version
gradle -version
git --version
```

## Installed Tools
- Java 17 (OpenJDK)
- Maven 3.9.x
- Gradle 8.6
- Git

## Comparison: Maven vs Gradle

| Feature | Maven | Gradle |
|---------|-------|--------|
| Configuration | pom.xml (XML) | build.gradle (Groovy) |
| Build Speed | Slower | Faster (build cache) |
| Flexibility | Convention-based | Programmable |
| IDE Support | Good | Excellent |
| Android Dev | Less used | Primary choice |
