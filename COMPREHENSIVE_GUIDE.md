# DevOps Workshop - BCSL657D

Complete Teaching Manual for Azure Cloud Deployment

---

# Table of Contents

1. [DevOps Basics](#devops-basics)
2. [Linux Basics](#linux-basics)
3. [Cloud Computing - Azure](#cloud-computing-azure)
4. [Git Version Control](#git-version-control)
5. [Ansible - Configuration Management](#ansible-configuration-management)
6. [VM Creation on Azure](#vm-creation-on-azure)
7. [Jenkins Installation](#jenkins-installation)
8. [Jenkins Pipeline](#jenkins-pipeline)
9. [Azure DevOps Pipelines](#azure-devops-pipelines)
10. [Source Code Projects](#source-code-projects)

---

# 1. DevOps Basics

## What is DevOps?

DevOps is a set of practices that combines software development (Dev) and IT operations (Ops). It aims to:
- Shorten development lifecycle
- Provide continuous delivery
- Increase deployment frequency
- Improve collaboration between teams

## DevOps Lifecycle

```
Plan → Code → Build → Test → Deploy → Operate → Monitor → Feedback
```

## DevOps Culture

| Principle | Description |
|-----------|-------------|
| Collaboration | Bridge gap between dev and ops teams |
| Automation | Automate repetitive tasks |
| Continuous Improvement | Always optimize workflows |
| Shared Responsibility | Teams own the entire lifecycle |

## DevOps Tools

| Category | Tools |
|----------|-------|
| Build Tools | Maven, Gradle |
| CI/CD | Jenkins, Azure DevOps, GitLab CI |
| Configuration Management | Ansible, Chef, Puppet |
| Containerization | Docker, Kubernetes |
| Cloud Platforms | Azure, AWS, GCP |

---

# 2. Linux Basics

## Basic Commands

### File Operations
```bash
ls                    # List files
ls -la                # List with details
cd /path              # Change directory
pwd                   # Print working directory
mkdir folder          # Create directory
rm file               # Delete file
rm -rf folder         # Delete folder recursively
cp source dest        # Copy file
mv old new            # Move/rename file
cat file              # Display file contents
touch file            # Create empty file
```

### System Info
```bash
uname -a              # System information
df -h                 # Disk usage
free -m               # Memory usage
top                   # Process manager
ps aux                # Running processes
whoami                # Current user
hostname              # Hostname
```

### Package Management (Ubuntu/Debian)
```bash
apt update            # Update package list
apt upgrade           # Upgrade packages
apt install package   # Install package
apt remove package    # Remove package
apt search keyword    # Search packages
```

### Networking
```bash
ip addr               # Show IP address
ping hostname         # Test connectivity
curl url              # HTTP request
wget url              # Download file
ssh user@host         # Remote login
scp file user@host:   # Secure copy
```

### Permissions
```bash
chmod +x file         # Make executable
chmod 755 file       # Set permissions
chown user:group file # Change ownership
```

### Process Management
```bash
kill process_id       # Kill process
killall process_name  # Kill all processes
systemctl status service   # Service status
systemctl start service    # Start service
systemctl stop service     # Stop service
systemctl restart service  # Restart service
```

---

# 3. Cloud Computing - Azure

## What is Cloud Computing?

Cloud computing is the delivery of computing services over the internet, including:
- Servers
- Storage
- Databases
- Networking
- Software

## Azure Services Overview

| Service Category | Services |
|-----------------|----------|
| Compute | Virtual Machines, Azure Kubernetes Service, App Service |
| Storage | Blob Storage, Disk Storage, File Storage |
| Database | SQL Database, Cosmos DB, Azure Cache |
| Networking | Virtual Network, Load Balancer, CDN |
| DevOps | Azure DevOps, GitHub Actions |

## Azure Core Concepts

### Resource Group
A container that holds related resources for an Azure solution.

### Virtual Machine (VM)
On-demand, scalable computing resources in the cloud.

### Azure App Service
Fully managed platform for building, deploying, and scaling web apps.

### Azure DevOps
 Microsoft's DevOps solution including:
- Azure Boards (project management)
- Azure Repos (Git hosting)
- Azure Pipelines (CI/CD)
- Azure Test Plans
- Azure Artifacts

---

# 4. Git Version Control

## Git Basics

### Configuration
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --list
```

### Creating Repository
```bash
mkdir project
cd project
git init
git status
```

### Basic Workflow
```bash
# Clone repository
git clone https://github.com/user/repo.git

# Check status
git status

# Add files to staging
git add file.txt
git add .               # Add all files

# Commit changes
git commit -m "Commit message"

# View history
git log
git log --oneline

# Push to remote
git push origin main

# Pull from remote
git pull origin main
```

### Branches
```bash
# List branches
git branch

# Create branch
git branch feature-branch

# Switch branch
git checkout feature-branch

# Create and switch
git checkout -b new-branch

# Merge branch
git checkout main
git merge feature-branch

# Delete branch
git branch -d branch-name
```

### Remote Operations
```bash
# Add remote
git remote add origin https://github.com/user/repo.git

# List remotes
git remote -v

# Push to remote
git push -u origin main

# Fetch changes
git fetch origin
```

---

# 5. Ansible Configuration Management

## What is Ansible?

Ansible is an open-source configuration management tool that automates:
- Server provisioning
- Application deployment
- Configuration management

## Installation

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install ansible
ansible --version
```

## Inventory File

```ini
[webservers]
web1 ansible_host=192.168.1.10 ansible_user=ubuntu
web2 ansible_host=192.168.1.11 ansible_user=ubuntu

[dbservers]
db1 ansible_host=192.168.1.20 ansible_user=ubuntu

[all:vars]
ansible_python_interpreter=/usr/bin/python3
```

## Ansible Commands

```bash
# Test connectivity
ansible all -i inventory -m ping

# List hosts
ansible all -i inventory --list-hosts

# Run playbook (dry-run)
ansible-playbook -i inventory playbook.yml --check

# Run playbook
ansible-playbook -i inventory playbook.yml

# Syntax check
ansible-playbook --syntax-check playbook.yml
```

## Example Playbook

```yaml
---
- name: Install Java and Maven
  hosts: all
  become: yes
  
  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes
    
    - name: Install Java
      apt:
        name: openjdk-17-jdk
        state: present
    
    - name: Install Maven
      apt:
        name: maven
        state: present
```

---

# 6. VM Creation on Azure

## Step-by-Step Guide

### Step 1: Login to Azure Portal
1. Go to https://portal.azure.com
2. Sign in with your Microsoft account

### Step 2: Create Virtual Machine
1. Click "Create a resource"
2. Select "Virtual Machine"
3. Fill in details:
   - **Subscription**: Select your subscription
   - **Resource Group**: Create new or select existing
   - **Virtual machine name**: devops-vm
   - **Region**: Select region
   - **Image**: Ubuntu Server 22.04 LTS
   - **Size**: Standard_B1s (or as needed)
   - **Authentication type**: SSH public key
   - **Username**: ubuntu

### Step 3: Configure Networking
1. Go to "Networking" tab
2. Create new Virtual Network
3. Configure Public IP
4. Allow inbound ports: SSH (22), HTTP (80), HTTPS (443)

### Step 4: Review and Create
1. Click "Review + Create"
2. Click "Create"
3. Download SSH key

### Step 5: Connect to VM
```bash
# Using SSH key
ssh -i path/to/key ubuntu@your-vm-ip

# Or using password
ssh ubuntu@your-vm-ip
```

### Step 6: Update VM
```bash
sudo apt update
sudo apt upgrade -y
```

---

# 7. Jenkins Installation

## Installation on Ubuntu

```bash
# Add Jenkins repository
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list

# Install Jenkins
sudo apt update
sudo apt install jenkins

# Start Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Check status
sudo systemctl status jenkins

# Get initial password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

## Access Jenkins
- URL: http://localhost:8080
- Initial password: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`

---

# 8. Jenkins Pipeline

## Jenkinsfile Example

```groovy
pipeline {
    agent any
    
    environment {
        APP_NAME = 'maven-demo-app'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/user/repo.git'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'ansible-playbook -i hosts.ini deploy.yml'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
```

---

# 9. Azure DevOps Pipelines

## Azure Pipeline Example

```yaml
# azure-pipelines.yml
trigger:
  branches:
    include:
      - main

pool:
  vmImage: 'ubuntu-latest'

stages:
  - stage: Build
    jobs:
      - job: MavenBuild
        steps:
          - task: Maven@3
            inputs:
              mavenPomFile: 'experiment-02-maven/pom.xml'
              goals: 'clean package'
          
          - task: PublishBuildArtifacts@1
            inputs:
              PathtoPublish: 'experiment-02-maven/target'
              ArtifactName: 'drop'

  - stage: Deploy
    jobs:
      - deployment: DeployToAzure
        environment: 'production'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureWebApp@1
                  inputs:
                    azureSubscription: 'Azure-Service-Connection'
                    appType: 'webAppLinux'
                    appName: 'devops-app'
                    package: '$(Pipeline.Workspace)/drop/*.jar'
```

---

# 10. Source Code Projects

## Project 1: Maven - Student & Product Management System

**Location:** `experiment-02-maven/`

### Build & Run
```bash
# Clone repository
git clone https://github.com/your-repo/azure-poc.git
cd azure-poc

# Build project
cd experiment-02-maven
mvn clean package

# Run application
java -jar target/maven-demo-app-1.0.0.jar
```

### Run with Docker
```bash
cd experiment-02-maven
docker build -t maven-demo-app:latest .
docker run -p 8080:8080 maven-demo-app:latest
```

### API Endpoints - Students
```bash
# Get all students
curl http://localhost:8080/api/students

# Get student by ID
curl http://localhost:8080/api/students/1

# Create student
curl -X POST http://localhost:8080/api/students \
  -H "Content-Type: application/json" \
  -d '{"name":"John Doe","email":"john@email.com","course":"Computer Science","age":20,"grade":"A"}'

# Update student
curl -X PUT http://localhost:8080/api/students/1 \
  -H "Content-Type: application/json" \
  -d '{"name":"John Updated","email":"john@email.com","course":"IT","age":21,"grade":"A+"}'

# Delete student
curl -X DELETE http://localhost:8080/api/students/1

# Search students
curl http://localhost:8080/api/students/search?query=John
```

### API Endpoints - Products
```bash
# Get all products
curl http://localhost:8080/api/products

# Get product by ID
curl http://localhost:8080/api/products/1

# Create product
curl -X POST http://localhost:8080/api/products \
  -H "Content-Type: application/json" \
  -d '{"name":"Tablet","category":"Electronics","price":499.99,"stock":30}'

# Update product stock
curl -X PUT http://localhost:8080/api/products/1/stock?quantity=75

# Get products by category
curl http://localhost:8080/api/products/category/Electronics
```

---

## Project 2: Gradle - Employee & Order Management System

**Location:** `experiment-03-gradle/`

### Build & Run
```bash
cd experiment-03-gradle
chmod +x gradlew
./gradlew clean build
java -jar build/libs/gradle-demo-app-1.0.0.jar
```

### Run with Docker
```bash
cd experiment-03-gradle
docker build -t gradle-demo-app:latest .
docker run -p 8080:8080 gradle-demo-app:latest
```

### API Endpoints - Employees
```bash
# Get all employees
curl http://localhost:8080/api/employees

# Get employee by ID
curl http://localhost:8080/api/employees/1

# Create employee
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d '{"name":"Jane Smith","email":"jane@company.com","department":"IT","salary":70000,"designation":"Developer"}'

# Update employee
curl -X PUT http://localhost:8080/api/employees/1 \
  -H "Content-Type: application/json" \
  -d '{"name":"Jane Updated","email":"jane@company.com","department":"Engineering","salary":80000,"designation":"Tech Lead"}'

# Delete employee
curl -X DELETE http://localhost:8080/api/employees/1

# Get employees by department
curl http://localhost:8080/api/employees/department/Engineering

# Search employees
curl http://localhost:8080/api/employees/search?query=Alice
```

### API Endpoints - Orders
```bash
# Get all orders
curl http://localhost:8080/api/orders

# Get order by ID
curl http://localhost:8080/api/orders/1

# Create order
curl -X POST http://localhost:8080/api/orders \
  -H "Content-Type: application/json" \
  -d '{"customerName":"New Customer","product":"Tablet","quantity":1,"totalPrice":499.99,"status":"Processing","orderDate":"2026-04-07"}'

# Update order status
curl -X PUT "http://localhost:8080/api/orders/1/status?status=Delivered"

# Get orders by status
curl http://localhost:8080/api/orders/status/Processing
```

---

## Accessing Applications

| Service | URL |
|---------|-----|
| Web App | http://localhost:8080 |
| Swagger UI | http://localhost:8080/swagger-ui.html |
| API Docs | http://localhost:8080/api-docs |
| Health Check | http://localhost:8080/actuator/health |

---

## Quick Start - Complete Setup

### Step 1: Clone Repository
```bash
git clone https://github.com/your-repo/azure-poc.git
cd azure-poc
```

### Step 2: Auto Setup (Installs All Tools + Fixes Gradle Wrapper)
```bash
chmod +x auto_setup.sh
sudo ./auto_setup.sh
```

### Step 3: Build and Run Maven Project
```bash
cd experiment-02-maven
mvn clean package
java -jar target/maven-demo-app-1.0.0.jar
```

### Step 4: Build and Run Gradle Project (Auto-fixed)
```bash
cd experiment-03-gradle
chmod +x gradlew
./gradlew clean build
java -jar build/libs/gradle-demo-app-1.0.0.jar
```

### If Gradle Wrapper Issue Occurs:
```bash
cd experiment-03-gradle

# Download wrapper jar
wget -O gradle/wrapper/gradle-wrapper.jar https://raw.githubusercontent.com/gradle/gradle/v8.6.0/gradle/wrapper/gradle-wrapper.jar

# Or use system gradle as fallback
gradle clean build

# Then run
java -jar build/libs/gradle-demo-app-1.0.0.jar
```

### Step 5: Access Swagger UI
```
http://your-server-ip:8080/swagger-ui.html
```

---

## Jenkins Pipeline Commands

### Build Jenkins Job from Command Line
```bash
# Check Jenkins status
sudo systemctl status jenkins

# Restart Jenkins
sudo systemctl restart jenkins

# Get Jenkins logs
sudo journalctl -u jenkins -n 50
```

---

## Docker Commands

### Build Images
```bash
# Maven project
cd experiment-02-maven
docker build -t maven-demo-app:latest .

# Gradle project
cd experiment-03-gradle
docker build -t gradle-demo-app:latest .
```

### Run Containers
```bash
# Maven container
docker run -d -p 8080:8080 --name maven-app maven-demo-app:latest

# Gradle container
docker run -d -p 8081:8080 --name gradle-app gradle-demo-app:latest
```

### Manage Containers
```bash
# List running containers
docker ps

# Stop container
docker stop maven-app

# Remove container
docker rm maven-app

# View logs
docker logs maven-app
```

---

## Azure DevOps Pipeline Commands

### Create Service Connection
1. Go to Azure DevOps → Project Settings
2. Go to Service Connections
3. Create New → Azure Resource Manager
4. Select subscription and create

### Run Pipeline from CLI
```bash
# Install Azure DevOps CLI
az extension add --name azure-devops

# Run pipeline
az pipelines run --name "My Pipeline"
```

---

## Assessment Details

### CIE — 50 Marks
| Component | Weightage | Marks |
|-----------|-----------|-------|
| Record (12 experiments) | 60% | 30 |
| CIE Test | 40% | 20 |

### SEE — 50 Marks
- Write-up: 20%
- Conduction: 60%
- Viva: 20%

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Maven build fails | Run `mvn clean` first |
| Gradle build fails | Run `./gradlew clean` |
| Port 8080 in use | Kill process: `sudo kill $(lsof -t -i:8080)` |
| Jenkins won't start | Check logs: `sudo journalctl -u jenkins` |
| Ansible ping fails | Check inventory file |
| Azure pipeline fails | Check service connection |
