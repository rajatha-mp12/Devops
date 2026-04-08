# Experiment 10: Creating Build Pipelines in Azure DevOps

## Aim
Build Maven and Gradle projects using Azure Pipelines, integrate repositories, run unit tests with reports.

## Files
- `azure-pipelines-gradle.yml` — Gradle build pipeline

## Usage

### Maven Pipeline
Uses `experiment-09-azure-devops/azure-pipelines.yml`

### Gradle Pipeline
1. Pipelines → New Pipeline
2. Select repository
3. Select: experiment-10-build-pipeline/azure-pipelines-gradle.yml

### Pipeline Tasks
```yaml
- task: Gradle@3
  inputs:
    gradleWrapperFile: 'gradlew'
    tasks: 'clean build'
    publishJUnitResults: true
```

## Pipeline Structure
1. Checkout code
2. Cache dependencies
3. Build with Maven/Gradle
4. Run tests
5. Publish artifacts
