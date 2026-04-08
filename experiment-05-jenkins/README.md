# 🚀 End-to-End CI/CD Pipeline with Jenkins (Dockerized) + Azure Container Apps

---

## 📌 Project Overview

This project demonstrates a **complete CI/CD pipeline** using:

* Jenkins (Dockerized)
* Docker
* Azure Container Registry (ACR)
* Azure Container Apps
* GitHub Webhooks (Auto Trigger)

---

## 🏗️ Architecture

```
GitHub → Jenkins (Docker) → Maven Build → Docker Build → ACR → Azure Container Apps
```

---

# 🐳 Jenkins Setup Using Docker

## 📦 Dockerfile

```dockerfile
FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    docker.io \
    maven && \
    apt-get clean

# Azure CLI
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ jammy main" > /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install -y azure-cli

USER jenkins
```

---

## 🔨 Build Jenkins Image

```bash
docker build -t jenkins-azure-docker .
```

---

## ▶️ Run Jenkins Container (IMPORTANT)

```bash
docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins-azure-docker
```

---

## 🔐 Get Initial Admin Password

```bash
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

---

## 🌐 Access Jenkins

```
http://<VM-IP>:8080
```

---

# 🛠️ Fix: Docker Permission Issue (CRITICAL)

## ❌ Error

```
permission denied while trying to connect to the Docker daemon socket
```

---

## ✅ Step 1: Check Docker Group on Host

```bash
getent group docker
```

Example:

```
docker:x:114:jenkins,azureuser
```

👉 Note the GID (e.g., `114`)

---

## ✅ Step 2: Fix Inside Jenkins Container

```bash
docker exec -u root -it jenkins bash
```

```bash
groupmod -g 114 docker
usermod -aG docker jenkins
exit
```

---

## ✅ Step 3: Restart Jenkins

```bash
docker restart jenkins
```

---

## ✅ Step 4: Verify

```bash
docker exec -it jenkins id
```

Expected:

```
groups=1000(jenkins),114(docker)
```

---

## 🎯 Result

* ✅ Docker build works
* ✅ No permission errors

---

# ⚙️ Jenkins Pipeline (Jenkinsfile)

```groovy
pipeline {
    agent any

    environment {
        ACR_NAME = "jenkinspractice"
        IMAGE_NAME = "backend-app"
        RESOURCE_GROUP = "my-rg"
        CONTAINER_APP = "backend-app"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Maven') {
            steps {
                dir('experiment-02-maven') {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('Docker Build') {
            steps {
                dir('experiment-02-maven') {
                    sh '''
                    docker build -t $ACR_NAME.azurecr.io/$IMAGE_NAME:$BUILD_NUMBER .
                    '''
                }
            }
        }

        stage('Azure Login') {
            steps {
                withCredentials([
                    string(credentialsId: 'AZURE_CLIENT_ID', variable: 'CLIENT_ID'),
                    string(credentialsId: 'AZURE_CLIENT_SECRET', variable: 'CLIENT_SECRET'),
                    string(credentialsId: 'AZURE_TENANT_ID', variable: 'TENANT_ID')
                ]) {
                    sh '''
                    az login --service-principal \
                      -u $CLIENT_ID \
                      -p $CLIENT_SECRET \
                      --tenant $TENANT_ID
                    '''
                }
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                az acr login --name $ACR_NAME
                docker push $ACR_NAME.azurecr.io/$IMAGE_NAME:$BUILD_NUMBER
                '''
            }
        }

        stage('Deploy to Azure') {
            steps {
                sh '''
                az containerapp update \
                  --name $CONTAINER_APP \
                  --resource-group $RESOURCE_GROUP \
                  --image $ACR_NAME.azurecr.io/$IMAGE_NAME:$BUILD_NUMBER
                '''
            }
        }
    }
}
```

---

# 🔐 Azure Service Principal Setup

```bash
az ad sp create-for-rbac \
  --name jenkins-sp \
  --role contributor \
  --scopes /subscriptions/<SUBSCRIPTION_ID>
```

---

# 🔐 Fix: ACR Push Permission (IMPORTANT)

## ❌ Default Role

```
AcrPull (only pull allowed)
```

---

## ✅ Grant Push Permission

```bash
az role assignment create \
  --assignee <CLIENT_ID> \
  --role AcrPush \
  --scope /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/<RG>/providers/Microsoft.ContainerRegistry/registries/<ACR_NAME>
```

---

## ✅ Verify

```bash
az role assignment list --assignee <CLIENT_ID> --output table
```

Expected:

```
AcrPush
```

---

# 📦 Docker Commands

## Build Image

```bash
docker build -t jenkinspractice.azurecr.io/backend-app:v1 .
```

## Login to ACR

```bash
az acr login --name jenkinspractice
```

## Push Image

```bash
docker push jenkinspractice.azurecr.io/backend-app:v1
```

## Pull Image

```bash
docker pull jenkinspractice.azurecr.io/backend-app:v1
```

---

# 🔑 Jenkins Credentials

| Credential ID       | Type        |
| ------------------- | ----------- |
| AZURE_CLIENT_ID     | Secret Text |
| AZURE_CLIENT_SECRET | Secret Text |
| AZURE_TENANT_ID     | Secret Text |

---

# 🔄 GitHub Webhook

## URL

```
http://<VM-IP>:8080/github-webhook/
```

## Enable

* GitHub hook trigger for GITScm polling

---

# 🎯 Features

* ✅ Fully automated CI/CD pipeline
* ✅ Dockerized Jenkins setup
* ✅ Secure Azure authentication
* ✅ ACR integration
* ✅ Auto deployment to Azure Container Apps

---

# 🚀 Outcome

* Zero manual deployment
* End-to-end automation
* Production-ready DevOps workflow

---

# 💡 Future Improvements

* Multi-environment (Dev/Stage/Prod)
* Kubernetes (AKS) deployment
* Monitoring & logging (Prometheus/Grafana)
* Rollback strategy

---

# 🙌 Author

**DevOps Engineer 🚀**
