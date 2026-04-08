# Experiment 02: Maven - Student Management System

## Aim
Build a Student Management System REST API using Maven and Spring Boot with Swagger UI.

## Real-World Scenario
A college needs a web application to manage student records. Students can be added, updated, deleted, and searched.

## Features
- ✅ Student CRUD Operations
- ✅ Product Management
- ✅ Search functionality
- ✅ Swagger UI Documentation
- ✅ REST API

## Build & Run

```bash
cd experiment-02-maven
mvn clean package
java -jar target/maven-demo-app-1.0.0.jar
```

## Azure Pipeline Deployment

To deploy using Azure Pipelines:

1. Ensure you have an Azure DevOps project set up.
2. Create a service connection for your Azure subscription.
3. Update the `azureSubscription` and `resourceGroup` variables in `azure-pipelines.yml`.
4. Commit and push the code to the `main` branch to trigger the pipeline.

The pipeline will:
- Build the Maven project
- Create a Docker image tagged with the build ID
- Push to Azure Container Registry (`jenkinspractice`)
- Deploy to Azure Container App (`backend-app`)

## Access URLs

| Service | URL |
|---------|-----|
| Web App | http://localhost:8080 |
| Swagger UI | http://localhost:8080/swagger-ui.html |
| API Docs | http://localhost:8080/api-docs |
| Health | http://localhost:8080/actuator/health |

## API Endpoints

### Student Management
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/students` | Get all students |
| GET | `/api/students/{id}` | Get student by ID |
| POST | `/api/students` | Create new student |
| PUT | `/api/students/{id}` | Update student |
| DELETE | `/api/students/{id}` | Delete student |
| GET | `/api/students/search?query=name` | Search students |

### Product Management
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/products` | Get all products |
| GET | `/api/products/{id}` | Get product by ID |
| POST | `/api/products` | Add new product |
| PUT | `/api/products/{id}/stock?quantity=10` | Update stock |
| GET | `/api/products/category/{category}` | Get by category |

## Test with curl

```bash
# Get all students
curl http://localhost:8080/api/students

# Get student by ID
curl http://localhost:8080/api/students/1

# Create student
curl -X POST http://localhost:8080/api/students \
  -H "Content-Type: application/json" \
  -d '{"name":"New Student","email":"new@email.com","course":"AI","age":20,"grade":"A"}'

# Update student
curl -X PUT http://localhost:8080/api/students/1 \
  -H "Content-Type: application/json" \
  -d '{"name":"John Updated","email":"john@email.com","course":"CS","age":21,"grade":"A+"}'

# Delete student
curl -X DELETE http://localhost:8080/api/students/1

# Search students
curl http://localhost:8080/api/students/search?query=John

# Get all products
curl http://localhost:8080/api/products

# Update product stock
curl -X PUT http://localhost:8080/api/products/1/stock?quantity=75
```

## Docker

```bash
# Build
cd experiment-02-maven
docker build -t maven-demo-app:latest .

# Run
docker run -p 8080:8080 maven-demo-app:latest
```
