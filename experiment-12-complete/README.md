# Experiment 12: Complete DevOps Pipeline — Practical Exercise

## Aim
Build and deploy complete end-to-end DevOps pipeline integrating all tools: Git, Maven/Gradle, Jenkins, Ansible, Azure DevOps.

## Files
- `master_setup.sh` — Master installation script
- `Jenkinsfile` — Complete Jenkins pipeline
- `azure-pipelines-complete.yml` — Complete Azure DevOps pipeline

## Usage

### Run Master Setup
```bash
chmod +x master_setup.sh
sudo ./master_setup.sh
```

### Jenkins Complete Pipeline
1. Dashboard → New Item
2. Enter name → Pipeline
3. Script Path: experiment-12-complete/Jenkinsfile
4. Build Now

### Azure DevOps Complete Pipeline
1. Pipelines → New Pipeline
2. Select: experiment-12-complete/azure-pipelines-complete.yml

## Pipeline Flow
```
Git Push → Jenkins/Azure DevOps
    ↓
Build (Maven + Gradle)
    ↓
Test (JUnit)
    ↓
Security Scan (OWASP)
    ↓
Deploy to Dev (Ansible)
    ↓
Deploy to Staging (Azure)
    ↓
Deploy to QA (Azure)
    ↓
Deploy to Production (Azure)
    ↓
Notify (Slack/Email)
```

## Complete Pipeline Stages
| Stage | Tool | Description |
|-------|------|-------------|
| Checkout | Git | Clone repository |
| Build | Maven/Gradle | Compile code |
| Test | JUnit | Run tests |
| Security | OWASP | Vulnerability scan |
| Deploy Dev | Ansible | Deploy to dev |
| Test Dev | Manual | Functional tests |
| Deploy Staging | Azure | Staging environment |
| Deploy QA | Azure | QA environment |
| Deploy Prod | Azure | Production |
| Notify | Slack | Send notification |
