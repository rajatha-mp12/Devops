# Experiment 11: Creating Release Pipelines — Continuous Deployment

## Aim
Deploy applications to Azure App Services, manage secrets, set up continuous deployment.

## Files
- `azure-pipelines-cd.yml` — CI + CD pipeline

## Usage

### Create Release Pipeline
1. Pipelines → Releases → New release pipeline
2. Add artifact (from build pipeline)
3. Add stage (Dev, QA, Production)
4. Configure deployment tasks

### Azure Web App Deployment
```yaml
- task: AzureWebApp@1
  inputs:
    azureSubscription: '$(azureSubscription)'
    appName: '$(appName)'
    package: '$(Pipeline.Workspace)/drop/*.jar'
    runtimeStack: 'JAVA|17-java17'
```

## Deployment Stages
| Stage | Environment | Description |
|-------|-------------|-------------|
| Dev | Development | Initial testing |
| QA | Quality Assurance | Integration testing |
| Prod | Production | Live deployment |
