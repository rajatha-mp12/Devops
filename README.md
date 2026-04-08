# DevOps Workshop - BCSL657D

Complete Teaching Manual | Semester 6 | Credits: 01

---

# Quick Start (Recommended)

## One-Command Setup
```bash
# Clone and run auto setup
git clone https://github.com/your-repo/azure-poc.git
cd azure-poc
chmod +x auto_setup.sh
sudo ./auto_setup.sh
```

---

# Step-by-Step Guide

Follow these steps in order to complete all 12 experiments.

---

## Step 1: Clone Repository

```bash
git clone https://github.com/your-repo/azure-poc.git
cd azure-poc
```

---

## Step 2: Auto Setup (Installs All Tools)

```bash
chmod +x auto_setup.sh
sudo ./auto_setup.sh
```

This will install:
- Java 17
- Maven
- Gradle 8.6
- Git
- Jenkins
- Ansible
- Docker
- **Fix Gradle wrapper**

---

## Step 3: Maven - Student & Product Management

```bash
cd experiment-02-maven
mvn clean package
java -jar target/maven-demo-app-1.0.0.jar
```

**Or using Docker:**
```bash
cd experiment-02-maven
docker build -t maven-demo-app:latest .
docker run -p 8080:8080 maven-demo-app:latest
```

---

## Step 4: Gradle - Employee & Order Management

```bash
cd experiment-03-gradle

# If gradle wrapper issue, download jar first:
wget -O gradle/wrapper/gradle-wrapper.jar https://raw.githubusercontent.com/gradle/gradle/v8.6.0/gradle/wrapper/gradle-wrapper.jar

# Build
chmod +x gradlew
./gradlew clean build

# Run
java -jar build/libs/gradle-demo-app-1.0.0.jar
```

**Or using system Gradle (fallback):**
```bash
cd experiment-03-gradle
gradle clean build
java -jar build/libs/gradle-demo-app-1.0.0.jar
```

**Or using Docker:**
```bash
cd experiment-03-gradle
docker build -t gradle-demo-app:latest .
docker run -p 8080:8080 gradle-demo-app:latest
```

---

## Step 5: Compare Build Tools

```bash
cd experiment-04-migration
chmod +x compare_builds.sh
./compare_builds.sh
```

---

## Step 6: Install Jenkins

```bash
cd experiment-05-jenkins
chmod +x install_jenkins.sh
sudo ./install_jenkins.sh
```

Access: http://localhost:8080

---

## Step 7: Jenkins CI Pipeline

Create pipeline in Jenkins UI with Jenkinsfile from `experiment-06-ci/`

---

## Step 8: Configure Ansible

```bash
cd experiment-07-ansible
ansible-playbook -i hosts.ini setup_webserver.yml
```

---

## Step 9: Jenkins + Ansible

Create pipeline with Jenkinsfile from `experiment-08-jenkins-ansible/`

---

## Step 10-12: Azure DevOps

Use YAML files from experiments 09, 10, 11

---

# API Endpoints

## Maven Project - Student & Product Management

### Student API
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/students` | Get all students |
| GET | `/api/students/{id}` | Get student by ID |
| POST | `/api/students` | Create student |
| PUT | `/api/students/{id}` | Update student |
| DELETE | `/api/students/{id}` | Delete student |
| GET | `/api/students/search?query=name` | Search students |

### Product API
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/products` | Get all products |
| GET | `/api/products/{id}` | Get product by ID |
| POST | `/api/products` | Create product |
| PUT | `/api/products/{id}/stock?quantity=10` | Update stock |
| GET | `/api/products/category/{category}` | Get by category |

## Gradle Project - Employee & Order Management

### Employee API
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/employees` | Get all employees |
| GET | `/api/employees/{id}` | Get employee by ID |
| POST | `/api/employees` | Create employee |
| PUT | `/api/employees/{id}` | Update employee |
| DELETE | `/api/employees/{id}` | Delete employee |
| GET | `/api/employees/department/{dept}` | Get by department |

### Order API
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/orders` | Get all orders |
| GET | `/api/orders/{id}` | Get order by ID |
| POST | `/api/orders` | Create order |
| PUT | `/api/orders/{id}/status?status=Shipped` | Update status |
| GET | `/api/orders/status/{status}` | Get by status |

---

# Test API with curl

## Student Management
```bash
curl http://localhost:8080/api/students
curl http://localhost:8080/api/students/1
curl -X POST http://localhost:8080/api/students -H "Content-Type: application/json" -d '{"name":"John","email":"john@email.com","course":"CS","age":20,"grade":"A"}'
curl -X DELETE http://localhost:8080/api/students/1
```

## Product Management
```bash
curl http://localhost:8080/api/products
curl -X PUT http://localhost:8080/api/products/1/stock?quantity=50
```

## Employee Management
```bash
curl http://localhost:8080/api/employees
curl http://localhost:8080/api/employees/1
curl -X POST http://localhost:8080/api/employees -H "Content-Type: application/json" -d '{"name":"Jane","email":"jane@company.com","department":"IT","salary":50000,"designation":"Developer"}'
```

## Order Management
```bash
curl http://localhost:8080/api/orders
curl -X PUT "http://localhost:8080/api/orders/1/status?status=Delivered"
```

---

# Access URLs

| Service | URL |
|---------|-----|
| Web App | http://localhost:8080 |
| Swagger UI | http://localhost:8080/swagger-ui.html |
| API Docs | http://localhost:8080/api-docs |
| Health | http://localhost:8080/actuator/health |

---

# Troubleshooting

## Gradle Wrapper Issue
```bash
# Fix: Download wrapper jar
cd experiment-03-gradle
wget -O gradle/wrapper/gradle-wrapper.jar https://raw.githubusercontent.com/gradle/gradle/v8.6.0/gradle/wrapper/gradle-wrapper.jar

# Or use system gradle
gradle clean build

# Then run
java -jar build/libs/gradle-demo-app-1.0.0.jar
```

## Port Already in Use
```bash
# Find and kill process on port 8080
sudo lsof -ti:8080 | xargs sudo kill -9

# Or restart the application
```

## Maven Build Fails
```bash
# Clean and rebuild
cd experiment-02-maven
mvn clean
mvn package
```

---

# Tools Covered

| Category | Tools |
|----------|-------|
| Build Tools | Maven, Gradle |
| CI/CD | Jenkins, Azure DevOps |
| Configuration Management | Ansible |
| Container | Docker |
| Cloud | Azure |
| Web Framework | Spring Boot |
| API Documentation | Swagger UI |

---

# Quick Reference Commands

```bash
# === AUTO SETUP (Recommended) ===
chmod +x auto_setup.sh
sudo ./auto_setup.sh

# === MAVEN ===
cd experiment-02-maven
mvn clean package
java -jar target/maven-demo-app-1.0.0.jar

# === GRADLE ===
cd experiment-03-gradle
wget -O gradle/wrapper/gradle-wrapper.jar https://raw.githubusercontent.com/gradle/gradle/v8.6.0/gradle/wrapper/gradle-wrapper.jar
chmod +x gradlew
./gradlew clean build
java -jar build/libs/gradle-demo-app-1.0.0.jar

# === DOCKER ===
docker build -t maven-demo-app:latest experiment-02-maven/
docker run -p 8080:8080 maven-demo-app:latest

# === JENKINS ===
sudo systemctl status jenkins
sudo systemctl restart jenkins
# URL: http://localhost:8080

# === ANSIBLE ===
cd experiment-07-ansible
ansible-playbook -i hosts.ini setup_webserver.yml
```
