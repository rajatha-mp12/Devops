# Experiment 06: Continuous Integration with Jenkins

## Aim
Set up a CI pipeline in Jenkins, integrate with Maven/Gradle, run automated builds and tests on every code push.

## Files
- `Jenkinsfile` — CI pipeline definition

## Jenkinsfile Structure
```groovy
pipeline {
    agent any
    stages {
        stage('Checkout') { steps { git ... } }
        stage('Build')    { steps { sh 'mvn clean package' } }
        stage('Test')     { steps { sh 'mvn test' } }
        stage('Package')  { steps { sh 'mvn package' } }
    }
    post {
        success { echo 'Build SUCCEEDED!' }
        failure { echo 'Build FAILED!' }
    }
}
```

## Usage

### Create Jenkins Job
1. Dashboard → New Item
2. Enter name → Pipeline
3. Definition: Pipeline script from SCM
4. SCM: Git → Repository URL
5. Script Path: experiment-06-ci/Jenkinsfile
6. Save → Build Now

### Run Pipeline
```bash
# Test locally
jenkinsfile-runner -f experiment-06-ci/Jenkinsfile
```

## Pipeline Stages
1. **Checkout** — Clone source code
2. **Compile** — Compile source code
3. **Test** — Run unit tests
4. **Package** — Create JAR
5. **Archive** — Store artifacts
