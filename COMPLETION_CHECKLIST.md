# DevOps Lab Completion Checklist — BCSL657D
Complete guide for students to track progress through all 12 experiments.

---

## Pre-Setup Checklist
- [ ] Ubuntu 22.04 LTS / WSL2 installed
- [ ] Terminal access (bash shell)
- [ ] Git installed
- [ ] Internet connection available
- [ ] Administrator/sudo access

---

## Experiment 1: Introduction to DevTools
**Objective**: Install Java, Maven, Gradle, Ansible  
**Status**: _____ (Not Started / In Progress / Completed)

### Tasks
- [ ] Read experiment-01-intro README
- [ ] Download and save `install_devtools.sh`
- [ ] Run: `chmod +x install_devtools.sh && sudo ./install_devtools.sh`
- [ ] Verify:
  - [ ] `java -version` shows Java 17
  - [ ] `mvn -version` shows Maven 3.9+
  - [ ] `gradle -v` shows Gradle 8.6
  - [ ] `git --version` shows Git 2.x
  - [ ] `ansible --version` shows Ansible

### Record/Journal Points
- [ ] Note installation duration and any errors
- [ ] Record all version numbers
- [ ] Screenshot terminal output
- [ ] Describe purpose of each tool

---

## Experiment 2: Working with Maven
**Objective**: Create Maven project, understand pom.xml, build, test, package  
**Status**: _____ (Not Started / In Progress / Completed)

### Tasks
- [ ] Navigate to experiment-02-maven/
- [ ] Review pom.xml structure
  - [ ] Understand modelVersion, groupId, artifactId, version
  - [ ] Identify dependencies: JUnit 5, SLF4J
  - [ ] Review plugins: Surefire, Shade
- [ ] Build project:
  - [ ] Run: `mvn clean compile`
  - [ ] Run: `mvn test` (verify 5 tests pass)
  - [ ] Run: `mvn package`
- [ ] Run JAR:
  - [ ] Run: `java -jar target/devops-maven-app-1.0-SNAPSHOT.jar`
  - [ ] Verify output shows calculator results

### Code Review
- [ ] Open App.java — understand Logger usage
- [ ] Open Calculator.java — understand methods
- [ ] Open CalculatorTest.java — understand @Test annotations
- [ ] Trace code flow from main() to test execution

### Record/Journal Points
- [ ] Document Maven lifecycle phases
- [ ] Compare pom.xml tags and their purposes
- [ ] Record test results and build time
- [ ] Screenshot JAR execution output

---

## Experiment 3: Working with Gradle
**Objective**: Create Gradle project, learn Groovy DSL, run custom tasks  
**Status**: _____ (Not Started / In Progress / Completed)

### Tasks
- [ ] Navigate to experiment-03-gradle/
- [ ] Review build.gradle:
  - [ ] Understand plugins: java, application
  - [ ] Review repositories: mavenCentral()
  - [ ] Review dependencies and test framework
  - [ ] Understand custom tasks: hello, projectInfo
- [ ] Review settings.gradle
  - [ ] Note rootProject name
- [ ] Build project:
  - [ ] Run: `./gradlew clean compileJava`
  - [ ] Run: `./gradlew test` (verify tests pass)
  - [ ] Run: `./gradlew build`
- [ ] Run custom tasks:
  - [ ] Run: `./gradlew hello` (observe output)
  - [ ] Run: `./gradlew projectInfo` (observe metadata)

### Code Review
- [ ] Compare Gradle's build.gradle vs Maven's pom.xml
  - Advantages of Groovy DSL
  - Flexibility vs Maven conventions

### Record/Journal Points
- [ ] Document Gradle task syntax
- [ ] Compare Gradle vs Maven build output
- [ ] Record build time for both tools
- [ ] Document custom task creation

---

## Experiment 4: Build & Run Java App — Maven then Migrate to Gradle
**Objective**: Compare build tools, migrate from Maven to Gradle  
**Status**: _____ (Not Started / In Progress / Completed)

### Tasks
- [ ] Part A — Maven Build:
  - [ ] Navigate to a copy of experiment-02-maven
  - [ ] Run: `mvn clean package`
  - [ ] Run: `java -jar target/devops-maven-app-1.0-SNAPSHOT.jar`
  - [ ] Note build time

- [ ] Part B — Migrate to Gradle:
  - [ ] Delete pom.xml
  - [ ] Run: `gradle wrapper --gradle-version 8.6` (initialize wrapper)
  - [ ] Create build.gradle
  - [ ] Create settings.gradle
  - [ ] Keep same Java source files
  - [ ] Run: `./gradlew build`
  - [ ] Note build time

- [ ] Compare Performance:
  - [ ] Run compare_builds.sh: `chmod +x && ./compare_builds.sh`
  - [ ] Analyze cold vs incremental builds

### Record/Journal Points
- [ ] Document migration steps
- [ ] Compare build times: Maven first build vs Gradle cold vs Gradle incremental
- [ ] Note any issues encountered during migration
- [ ] Explain which tool is faster and why

---

## Experiment 5: Introduction to Jenkins
**Objective**: Install and configure Jenkins, explore dashboard  
**Status**: _____ (Not Started / In Progress / Completed)

### Tasks
- [ ] Run Jenkins installer:
  - [ ] Navigate to experiment-05-jenkins/
  - [ ] Run: `sudo ./install_jenkins.sh`
  - [ ] Copy the initial admin password from terminal

- [ ] First-Time Startup:
  - [ ] Open browser: http://localhost:8080
  - [ ] Paste admin password
  - [ ] Click "Install suggested plugins"
  - [ ] Wait for plugin installation (5-10 mins)
  - [ ] Create first admin user (username, password, email)
  - [ ] Set Jenkins URL to http://localhost:8080

- [ ] Explore Dashboard:
  - [ ] Home page overview
  - [ ] "New Item" button — create practice job
  - [ ] "Manage Jenkins" — system configuration
  - [ ] Job configuration and workspace

### Record/Journal Points
- [ ] Screenshot Jenkins dashboard
- [ ] Document key UI sections
- [ ] Note Jenkins URL and port
- [ ] Record admin credentials (securely)
- [ ] Describe Jenkins use cases

---

## Experiment 6: Continuous Integration with Jenkins
**Objective**: Set up CI pipeline for Maven project  
**Status**: _____ (Not Started / In Progress / Completed)

### Tasks
- [ ] Prepare GitLab Repository (or use local clone):
  - [ ] Push code to GitLab/GitHub
  - [ ] Ensure main branch exists

- [ ] Jenkins Setup:
  - [ ] In Jenkins Dashboard: New Item > Enter name "DevOps-CI" > Pipeline
  - [ ] Configuration:
    - [ ] Definition: "Pipeline script from SCM"
    - [ ] SCM: Git
    - [ ] Repository URL: (your repo)
    - [ ] Credentials: (if private repo, add SSH or HTTPS)
    - [ ] Branch: */main
    - [ ] Script Path: experiment-06-ci/Jenkinsfile
  - [ ] Save

- [ ] Run Pipeline:
  - [ ] Click "Build Now"
  - [ ] Watch Stage View (Checkout → Compile → Test → Package → Code Quality)
  - [ ] Check Console Output for success/errors

- [ ] Verify Artifacts:
  - [ ] Check Artifacts area for JAR file
  - [ ] Review Test Results (JUnit)

### Record/Journal Points
- [ ] Screenshot Jenkinsfile
- [ ] Document each pipeline stage
- [ ] Note build success/failure
- [ ] Screenshot Stage View
- [ ] Record execution time
- [ ] Describe CI benefits

---

## Experiment 7: Configuration Management with Ansible
**Objective**: Write playbook, configure servers  
**Status**: _____ (Not Started / In Progress / Completed)

### Tasks
- [ ] Review Ansible Files:
  - [ ] Read hosts.ini (inventory structure)
  - [ ] Read setup_webserver.yml (playbook tasks)
  - [ ] Review templates/app.service.j2 (service template)

- [ ] Ansible Testing (dry-run):
  - [ ] Navigate to experiment-07-ansible/
  - [ ] Check playbook syntax: `ansible-playbook setup_webserver.yml --syntax-check`
  - [ ] Dry run: `ansible-playbook -i hosts.ini setup_webserver.yml --check`
  - [ ] Review what WOULD be changed

- [ ] For Real Deployment (if you have servers):
  - [ ] Update hosts.ini with real IP addresses and SSH users
  - [ ] Generate SSH keys: `ssh-keygen -t rsa`
  - [ ] Upload public key to servers
  - [ ] Run: `ansible-playbook -i hosts.ini setup_webserver.yml -v`

- [ ] If using localhost only:
  - [ ] Run: `ansible-playbook -i hosts.ini setup_webserver.yml -v`
  - [ ] Verify local environment has Java and Nginx

### Record/Journal Points
- [ ] Document Ansible inventory structure
- [ ] Describe each playbook task
- [ ] Note variables used (app_port, app_dir)
- [ ] Screenshot playbook execution
- [ ] Explain Jinja2 template syntax
- [ ] Document idempotency concept

---

## Experiment 8: Jenkins CI Pipeline + Ansible Deployment
**Objective**: Combine CI (Jenkins) with CD (Ansible)  
**Status**: _____ (Not Started / In Progress / Completed)

### Tasks
- [ ] Setup (similar to Experiment 6):
  - [ ] Jenkins: New Item > Pipeline > Configure
  - [ ] SCM: Your repo
  - [ ] Script Path: experiment-08-jenkins-ansible/Jenkinsfile

- [ ] Run Pipeline:
  - [ ] Click "Build Now"
  - [ ] Watch stages: Checkout → Build → Test → Archive → Deploy with Ansible
  - [ ] Monitor Console Output

- [ ] Verify Deployment:
  - [ ] If Ansible targets localhost:
    - [ ] Verify Java is running: `java -version`
    - [ ] Check JAR in /opt/devops-app/
  - [ ] If Ansible targets real servers:
    - [ ] SSH into server
    - [ ] Verify service: `systemctl status devops-app`

### Record/Journal Points
- [ ] Screenshot Jenkinsfile (CI + CD stages)
- [ ] Screenshot Jenkins Stage View
- [ ] Document environment variables
- [ ] Note Ansible deployment logs
- [ ] Describe complete CI/CD flow

---

## Experiment 9: Introduction to Azure DevOps
**Objective**: Set up Azure DevOps account, project, and basic pipeline  
**Status**: _____ (Not Started / In Progress / Completed)

### Tasks
- [ ] Azure DevOps Account:
  - [ ] Visit https://dev.azure.com
  - [ ] Sign in with Microsoft account (create if needed)
  - [ ] Create new Organization (if first time)

- [ ] Create Project:
  - [ ] Click "New project"
  - [ ] Name: "DevOps-BCSL657D"
  - [ ] Visibility: Private
  - [ ] Version Control: Git
  - [ ] Click "Create"

- [ ] Import Repository:
  - [ ] Go to Repos
  - [ ] Select "Import a repository"
  - [ ] Type: Git
  - [ ] Clone URL: https://gitlab.com/devops-bcsl657d/course-practicals.git (or your repo)
  - [ ] Click "Import"

- [ ] Explore Boards:
  - [ ] Create Work Items for each experiment
  - [ ] Link to repo commits

- [ ] Create Pipeline (optional):
  - [ ] Go to Pipelines > Create new
  - [ ] Select your repo > Existing Pipeline YAML file
  - [ ] Select: experiment-09-azure-devops/azure-pipelines.yml
  - [ ] Click "Run"

### Record/Journal Points
- [ ] Screenshot Azure DevOps dashboard
- [ ] Document project structure
- [ ] Note organization URL
- [ ] Understand Boards, Repos, Pipelines, Artifacts sections
- [ ] Compare Azure DevOps to Jenkins

---

## Experiment 10: Creating Build Pipelines in Azure DevOps
**Objective**: Build Gradle project using Azure Pipelines  
**Status**: _____ (Not Started / In Progress / Completed)

### Tasks
- [ ] Create Pipeline:
  - [ ] Pipelines > Create new > Select repo
  - [ ] Select existing `azure-pipelines-gradle.yml`
  - [ ] Review YAML file content

- [ ] Run Pipeline:
  - [ ] Click "Run"
  - [ ] Monitor execution in real-time

- [ ] Verify Results:
  - [ ] Check "Tests" tab for JUnit results
  - [ ] Check "Artifacts" tab for published JAR
  - [ ] Review pipeline logs

### Record/Journal Points
- [ ] Screenshot azure-pipelines-gradle.yml
- [ ] Document Gradle task: clean build
- [ ] Note test results and success rate
- [ ] Record build time
- [ ] Location of published artifacts

---

## Experiment 11: Creating Release Pipelines — Continuous Deployment
**Objective**: Deploy to Azure App Services (CD)  
**Status**: _____ (Not Started / In Progress / Completed)

### Prerequisites (Azure Setup)
- [ ] Azure Subscription active
- [ ] Create Resource Group: "devops-rg"
- [ ] Create App Service (Linux, Java 17 runtime)
- [ ] Note App Name and Subscription ID

### Tasks
- [ ] Create Pipeline:
  - [ ] Pipelines > Create new > Select repo
  - [ ] Select existing `azure-pipelines-cd.yml`

- [ ] Update YAML Variables:
  - [ ] Replace `azureSubscription` with your subscription name
  - [ ] Replace `appName` with your App Service name
  - [ ] Replace `resourceGroup` with your resource group

- [ ] Create Service Connection:
  - [ ] Project Settings > Service connections > New Azure Resource Manager
  - [ ] Authenticate and authorize

- [ ] Run Pipeline:
  - [ ] Click "Run"
  - [ ] Monitor Build stage (Maven compile, test, package)
  - [ ] Monitor Deploy stage (artifact upload to App Service)

- [ ] Verify Deployment:
  - [ ] Visit your app URL: https://[appName].azurewebsites.net
  - [ ] Application should be running

### Record/Journal Points
- [ ] Screenshot azure-pipelines-cd.yml (both Build and Deploy stages)
- [ ] Document Service Connection setup
- [ ] Screenshot pipeline execution (both stages)
- [ ] Note deployment time
- [ ] Verify app is accessible via Azure

---

## Experiment 12: Complete DevOps Pipeline — Practical Exercise & Wrap-up
**Objective**: Master setup + reflection on all 12 experiments  
**Status**: _____ (Not Started / In Progress / Completed)

### Tasks
- [ ] Master Setup (All-in-one):
  - [ ] Navigate to experiment-12-complete/
  - [ ] Run: `sudo ./master_setup.sh`
  - [ ] Verify all tools install successfully
  - [ ] Note Jenkins initial admin password

- [ ] Complete End-to-End Pipeline:
  - [ ] Use root-level `azure-pipelines-complete.yml` (if not already done)
  - [ ] This pipeline integrates Exps 2, 3, 7, and 11 into one flow

### Final Assessment Preparation
- [ ] Compile Journal:
  - [ ] Write-up for each experiment (purpose, procedure, results)
  - [ ] Document all commands used
  - [ ] Include screenshots of outputs
  - [ ] Record any errors and how they were fixed

- [ ] Prepare for Viva:
  - [ ] Understand DevOps concepts
  - [ ] Be able to explain each tool's purpose
  - [ ] Know the CI/CD pipeline flow
  - [ ] Practice running commands

### Record/Journal Points
Complete comprehensive journal covering:
- [ ] All 12 experiments with detailed write-ups
- [ ] Screenshots of each stage
- [ ] All commands and outputs
- [ ] Lessons learned
- [ ] Challenges faced and solutions
- [ ] Time taken for each experiment
- [ ] Tool versions used

---

## Assessment Checklist

### CIE (Continuous Internal Evaluation) — 50 Marks
- [ ] Record/Journal (60% = 30 marks)
  - [ ] All 12 experiments documented
  - [ ] Procedure clearly described
  - [ ] Results and outputs recorded
  - [ ] Neatly formatted and organized

- [ ] CIE Test (40% = 20 marks)
  - [ ] Viva questions preparation
  - [ ] Practical conduction skills
  - [ ] Ability to run commands and explain

### SEE (Semester End Exam) — 50 Marks (scaled from 100)
- [ ] Write-up (20% = 20 marks)
  - [ ] Clear explanation of experiment
  - [ ] Theory and learning outcomes

- [ ] Conduction & Results (60% = 60 marks)
  - [ ] Ability to execute commands
  - [ ] Correct outputs
  - [ ] Troubleshooting skills

- [ ] Viva Voce (20% = 20 marks)
  - [ ] Concept understanding
  - [ ] Tool knowledge
  - [ ] Problem-solving approach

### Passing Criteria
- [ ] Minimum 40 marks overall (CIE + SEE combined)
- [ ] At least 40% in each component

---

## Quick Reference Commands

```bash
# Experiment 1 - Install Tools
sudo ./experiment-01-intro/install_devtools.sh

# Experiment 2 - Maven
cd experiment-02-maven && mvn clean package

# Experiment 3 - Gradle
cd experiment-03-gradle && ./gradlew clean build && ./gradlew run

# Experiment 4 - Compare Builds
./experiment-04-migration/compare_builds.sh

# Experiment 5 - Jenkins
sudo ./experiment-05-jenkins/install_jenkins.sh
# Then visit http://localhost:8080

# Experiment 7 - Ansible
cd experiment-07-ansible
ansible-playbook -i hosts.ini setup_webserver.yml --check

# Experiment 12 - Master Setup
sudo ./experiment-12-complete/master_setup.sh
```

---

## Final Submission Checklist
- [ ] All 12 experiments completed
- [ ] Complete journal/record written
- [ ] Screenshots for each major milestone
- [ ] Code and configurations committed to Git
- [ ] Journal file(s) prepared (PDF or written format)
- [ ] Ready for viva/practical exam
- [ ] Can explain each tool and its purpose
- [ ] Can execute all commands without errors

---

**Course Code**: BCSL657D | **Semester**: 6 | **Credits**: 01  
**Total Marks**: 100 (CIE: 50 + SEE: 50)  
**Passing**: ≥40 marks  

**Good Luck!**
