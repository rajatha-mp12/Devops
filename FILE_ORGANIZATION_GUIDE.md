# BCSL657D DevOps Lab — File Organization & Structure Guide

## Overview
Complete organizational structure for 12 DevOps practical experiments with proper file organization following industry standards.

---

## Root Directory Files

| File | Purpose | Experiment |
|------|---------|-----------|
| `.gitignore` | Excludes build artifacts, IDE files, and logs from Git | All |
| `README_FULL.md` | Complete index and quick start guide | All |
| `README.md` | Brief overview (original) | All |
| `launcher.bat` | Windows batch launcher (optional) | All |
| `azure-pipelines-complete.yml` | Multi-stage Azure DevOps pipeline (NEW) | 9-12 |

---

## Experiment Directories & Files

### Experiment 01: Introduction to DevTools
**Location**: `experiment-01-intro/`  
**Objective**: Set up Java 17, Maven, Gradle, Git, Ansible

| File | Type | Purpose |
|------|------|---------|
| `install_devtools.sh` | Bash Script | One-click installation of all dev tools |

**Run**: 
```bash
chmod +x experiment-01-intro/install_devtools.sh
sudo ./experiment-01-intro/install_devtools.sh
```

---

### Experiment 02: Working with Maven
**Location**: `experiment-02-maven/`  
**Objective**: Create Maven project, manage dependencies, build, test, package

**Files**:
```
experiment-02-maven/
├── pom.xml                    # Project Object Model (Maven config)
├── .classpath                 # IDE classpath (auto-generated)
├── .project                   # IDE project (auto-generated)
├── .settings/                 # IDE settings (auto-generated)
├── src/
│   ├── main/java/com/devops/lab/
│   │   ├── App.java          # Main application class
│   │   └── Calculator.java   # Calculator utility class
│   └── test/java/com/devops/lab/
│       └── CalculatorTest.java      # JUnit 5 test class
└── target/                   # Build output (auto-generated)
    ├── classes/
    ├── test-classes/
    └── *.jar
```

**Key Files**:
- `pom.xml` — Dependencies: JUnit 5, SLF4J; Plugins: Surefire, Shade
- `App.java` — Calls Calculator methods, logs output
- `Calculator.java` — add(), subtract(), multiply(), divide() methods
- `CalculatorTest.java` — Unit tests for all methods

**Run**:
```bash
cd experiment-02-maven
mvn clean package
java -jar target/devops-maven-app-1.0-SNAPSHOT.jar
```

---

### Experiment 03: Working with Gradle
**Location**: `experiment-03-gradle/`  
**Objective**: Create Gradle project with Groovy DSL, manage tasks, build incrementally

**Files**:
```
experiment-03-gradle/
├── build.gradle               # Gradle build script (Groovy DSL)
├── settings.gradle            # Gradle workspace settings
├── gradlew                    # Gradle wrapper script (Unix executable)
├── gradlew.bat                # Gradle wrapper script (Windows)
├── .gradle/                   # Gradle cache (auto-generated)
├── gradle/
│   └── wrapper/
│       ├── gradle-wrapper.jar # Gradle distribution downloader
│       └── gradle-wrapper.properties  # Gradle version 8.6
├── .project                   # IDE project (auto-generated)
├── .settings/                 # IDE settings (auto-generated)
├── src/
│   ├── main/java/com/devops/lab/
│   │   ├── App.java
│   │   └── Calculator.java
│   └── test/java/com/devops/lab/
│       └── CalculatorTest.java
└── build/                     # Build output (auto-generated)
    ├── classes/
    ├── test-results/
    └── libs/
```

**Key Files**:
- `build.gradle` — Java plugin, application main class, JUnit 5, custom tasks (hello, projectInfo)
- `gradle/wrapper/gradle-wrapper.properties` — Gradle version: 8.6
- Same Java sources as Maven (App.java, Calculator.java)

**Run**:
```bash
cd experiment-03-gradle
./gradlew clean build
./gradlew run
./gradlew hello
```

---

### Experiment 04: Build & Run Java App — Maven then Migrate to Gradle
**Location**: `experiment-04-migration/`  
**Objective**: Compare Maven vs Gradle build times, demonstrate migration steps

**Files**:
```
experiment-04-migration/
└── compare_builds.sh          # Bash script to compare Maven vs Gradle performance
```

**Script Actions**:
- Runs Maven build with timing
- Runs Gradle clean build (cold cache)
- Runs Gradle build (with cache) — shows incremental improvement

**Run**:
```bash
cd experiment-04-migration
chmod +x compare_builds.sh
./compare_builds.sh
```

---

### Experiment 05: Introduction to Jenkins
**Location**: `experiment-05-jenkins/`  
**Objective**: Install and configure Jenkins, explore UI and concepts

**Files**:
```
experiment-05-jenkins/
└── install_jenkins.sh         # One-click Jenkins installer + enablement
```

**Installation**:
- Adds Jenkins GPG key and repository
- Installs Jenkins package
- Auto-starts Jenkins service
- Outputs initial admin password

**Run**:
```bash
cd experiment-05-jenkins
chmod +x install_jenkins.sh
sudo ./install_jenkins.sh
```

**Access**: http://localhost:8080 (paste initial admin password)

---

### Experiment 06: Continuous Integration with Jenkins
**Location**: `experiment-06-ci/`  
**Objective**: Set up Jenkins CI pipeline, integrate Maven, run automated builds & tests

**Files**:
```
experiment-06-ci/
└── Jenkinsfile                # Jenkins declarative pipeline (Maven focus)
```

**Pipeline Stages**:
1. **Checkout** — Clone from GitLab
2. **Compile** — `mvn compile`
3. **Test** — `mvn test` + JUnit reporting
4. **Package** — `mvn package` + archive artifacts
5. **Code Quality** — Checkstyle check
6. **Post-Build** — Cleanup workspace

**Setup in Jenkins UI**:
- Dashboard > New Item > Pipeline
- SCM: Add GitLab repo URL
- Script Path: `experiment-06-ci/Jenkinsfile`
- Click "Build Now"

---

### Experiment 07: Configuration Management with Ansible
**Location**: `experiment-07-ansible/`  
**Objective**: Write and run Ansible playbooks for server configuration

**Files**:
```
experiment-07-ansible/
├── hosts.ini                  # Ansible inventory (hosts/groups)
├── setup_webserver.yml        # Playbook: install Java, Nginx, deploy app
└── templates/
    └── app.service.j2        # Systemd service template (NEW)
```

**`hosts.ini` Structure**:
- `[webservers]` group with web1, web2 hosts
- `[dbservers]` group with db1 host
- `[local]` for localhost testing
- Variables: SSH user, Python interpreter, private key

**`setup_webserver.yml` Tasks**:
1. Update apt cache
2. Install OpenJDK 17, Nginx
3. Create app directory
4. Copy JAR file
5. Create systemd service from template
6. Enable & start service
7. Print status

**`templates/app.service.j2`** (NEW):
- Systemd service template with variables: `{{ app_dir }}`
- Type: simple, restart on failure

**Run**:
```bash
cd experiment-07-ansible
ansible-playbook -i hosts.ini setup_webserver.yml --check    # Dry run
ansible-playbook -i hosts.ini setup_webserver.yml -v        # Real run
```

---

### Experiment 08: Jenkins CI Pipeline + Ansible Deployment
**Location**: `experiment-08-jenkins-ansible/`  
**Objective**: Combine Jenkins CI with Ansible deployment

**Files**:
```
experiment-08-jenkins-ansible/
└── Jenkinsfile                # Pipeline: Maven build → Ansible deploy
```

**Pipeline Stages**:
1. **Checkout**
2. **Build** — `mvn clean package`
3. **Test** — `mvn test`
4. **Archive** — Store artifacts
5. **Deploy with Ansible** — Run ansible-playbook

**Environment Variables**:
- `ARTIFACT` — Path to JAR file
- `ANSIBLE_HOST_KEY_CHECKING=False` — Skip SSH key verification

---

### Experiment 09: Introduction to Azure DevOps
**Location**: `experiment-09-azure-devops/`  
**Objective**: Set up Azure DevOps account, project, and basic pipeline

**Files**:
```
experiment-09-azure-devops/
└── azure-pipelines.yml        # Maven CI pipeline on Azure
```

**Pipeline Features**:
- **Trigger**: On main branch push
- **Pool**: ubuntu-latest agent
- **Cache**: Maven dependencies
- **Tasks**:
  1. Maven build & test
  2. Publish build artifacts
- **JUnit reporting**: Automatic test result publishing

---

### Experiment 10: Creating Build Pipelines in Azure DevOps
**Location**: `experiment-10-build-pipeline/`  
**Objective**: Build Gradle projects with Azure Pipelines

**Files**:
```
experiment-10-build-pipeline/
└── azure-pipelines-gradle.yml        # Gradle build pipeline on Azure
```

**Pipeline Features**:
- **Gradle Task**: `clean build`
- **Java Version**: 1.17
- **Publish**: Build artifacts (JAR files)
- **Test Results**: JUnit XML parsing

---

### Experiment 11: Creating Release Pipelines — Continuous Deployment
**Location**: `experiment-11-release-pipeline/`  
**Objective**: Deploy to Azure App Services, manage environments, multi-stage CI/CD

**Files**:
```
experiment-11-release-pipeline/
└── azure-pipelines-cd.yml            # Complete CI/CD pipeline with Azure deployment
```

**Pipeline Stages**:
1. **Build** — Maven compile, test, package
2. **Deploy** — Push JAR to Azure App Service (Linux, Java 17)

**Key Tasks**:
- `Maven@4` — Build & test
- `PublishBuildArtifacts@1` — Store artifacts
- `AzureWebApp@1` — Deploy to Azure

**Variables**:
- `azureSubscription` — Your Azure subscription name
- `appName` — Your Azure App Service name
- `resourceGroup` — Your Azure resource group

---

### Experiment 12: Complete DevOps Pipeline — Practical Exercise
**Location**: `experiment-12-complete/`  
**Objective**: Master setup script installing ALL tools for all 12 experiments

**Files**:
```
experiment-12-complete/
└── master_setup.sh            # Comprehensive multi-tool installer
```

**Installs**:
- Java 17 (openjdk-17-jdk)
- Maven (latest)
- Gradle 8.6 (with wrapper)
- Jenkins (with auto-start)
- Ansible (from PPA)
- Git
- Clones course repo to `/opt/devops-lab`

**Run**:
```bash
cd experiment-12-complete
chmod +x master_setup.sh
sudo ./master_setup.sh
```

**Output**: Displays all installed versions + Jenkins URL + initial admin password

---

## New File: Root Level Multi-Stage Pipeline

**Location**: `azure-pipelines-complete.yml` (at root)  
**Purpose**: Complete end-to-end DevOps pipeline integrating all tools

**Stages**:
1. **Build_Maven** — Maven build from experiment-02
2. **Build_Gradle** — Gradle build from experiment-03
3. **Deploy_Ansible** — Ansible deployment (dry-run + real)
4. **Release_Azure** — Deploy to Azure App Services

**Features**:
- Dependency chain: Maven/Gradle → Ansible → Azure
- Artifact caching for Maven & Gradle
- Multi-job parallel builds
- Conditional deployments

---

## File Organization Standards Applied

### ✅ Good Practices
- **Naming**: Clear, descriptive, snake_case for scripts and YAML
- **Structure**: Organized by experiment number (01-12)
- **Grouping**: All related files in same directory
- **Templates**: Separated into templates/ subdirectory
- **Artifacts**: Build output in target/ or build/ (excluded via .gitignore)
- **Configuration**: Central pom.xml, build.gradle
- **Scripts**: Executable bash scripts with shebang (#!/bin/bash)

### ✅ Standards Followed
- Maven: `pom.xml` at root of project
- Gradle: `build.gradle`, `settings.gradle`, `gradle/wrapper/`
- Jenkins: `Jenkinsfile` at repo root (or per-stage)
- Ansible: Inventory in `hosts.ini`, playbooks in YML, templates in `templates/`
- Azure Pipelines: `azure-pipelines.yml` in repo root

### ✅ Exclusions
`.gitignore` excludes:
- Build outputs: `target/`, `build/`, `*.jar`
- IDE files: `.classpath`, `.project`, `.settings/`, `.idea/`
- Caches: `.gradle/`, `.m2/`
- Logs & temp: `*.log`, `temp/`
- OS files: `.DS_Store`, `Thumbs.db`
- Secrets: `.env`

---

## Summary Table

| Exp | Directory | Files | Tools |
|-----|-----------|-------|-------|
| 01 | `01-intro/` | `install_devtools.sh` | Bash, Java, Maven, Gradle |
| 02 | `02-maven/` | `pom.xml`, Java sources | Maven, JUnit 5, SLF4J |
| 03 | `03-gradle/` | `build.gradle`, Java sources | Gradle 8.6, JUnit 5 |
| 04 | `04-migration/` | `compare_builds.sh` | Maven vs Gradle comparison |
| 05 | `05-jenkins/` | `install_jenkins.sh` | Jenkins 2.x automation |
| 06 | `06-ci/` | `Jenkinsfile` (Maven) | Jenkins, Maven, JUnit |
| 07 | `07-ansible/` | `hosts.ini`, `setup_webserver.yml`, templates/ | Ansible, YAML, Jinja2 |
| 08 | `08-jenkins-ansible/` | `Jenkinsfile` (CI+Deploy) | Jenkins, Ansible |
| 09 | `09-azure-devops/` | `azure-pipelines.yml` | Azure Pipelines, Maven |
| 10 | `10-build-pipeline/` | `azure-pipelines-gradle.yml` | Azure Pipelines, Gradle |
| 11 | `11-release-pipeline/` | `azure-pipelines-cd.yml` | Azure Pipelines, App Services |
| 12 | `12-complete/` | `master_setup.sh` | All tools installer |
| — | `root/` | `.gitignore`, `azure-pipelines-complete.yml` | Git, Azure multi-stage |

---

**Status**: ✅ All files organized and documented  
**Last Updated**: April 6, 2026
