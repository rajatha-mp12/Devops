# Experiment 08: Jenkins CI Pipeline + Ansible Deployment

## Aim
Set up complete Jenkins CI pipeline and use Ansible to deploy artifacts.

## Files
- `Jenkinsfile` — CI pipeline with Ansible deployment

## Usage

### Pipeline Stages
1. Checkout source code
2. Build with Maven
3. Run tests
4. Archive artifacts
5. Deploy with Ansible

### Create Jenkins Job
1. Dashboard → New Item
2. Enter name → Pipeline
3. Definition: Pipeline script from SCM
4. Script Path: experiment-08-jenkins-ansible/Jenkinsfile

## Jenkinsfile Structure
```groovy
pipeline {
    stages {
        stage('Checkout') { ... }
        stage('Build') { sh 'mvn clean package' }
        stage('Test') { sh 'mvn test' }
        stage('Archive') { archiveArtifacts ... }
        stage('Deploy') {
            sh 'ansible-playbook -i ansible/hosts.ini ansible/setup_webserver.yml'
        }
    }
}
```
