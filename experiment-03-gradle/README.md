# Experiment 03: Gradle - Employee & Order Management System

## Aim
Build an Employee Management & E-commerce Order System using Gradle and Spring Boot with Swagger UI.

## Real-World Scenario
A company needs to manage employee records and an e-commerce platform needs order management. Two different use cases to demonstrate Gradle flexibility.

## Features
- ✅ Employee CRUD Operations
- ✅ Order Management
- ✅ Department-based filtering
- ✅ Search functionality
- ✅ Swagger UI Documentation
- ✅ REST API

## Build & Run

```bash
cd experiment-03-gradle
chmod +x gradlew
./gradlew clean build
java -jar build/libs/gradle-demo-app-1.0.0.jar
```

## Access URLs

| Service | URL |
|---------|-----|
| Web App | http://localhost:8080 |
| Swagger UI | http://localhost:8080/swagger-ui.html |
| API Docs | http://localhost:8080/api-docs |
| Health | http://localhost:8080/actuator/health |

## API Endpoints

### Employee Management
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/employees` | Get all employees |
| GET | `/api/employees/{id}` | Get employee by ID |
| POST | `/api/employees` | Create new employee |
| PUT | `/api/employees/{id}` | Update employee |
| DELETE | `/api/employees/{id}` | Delete employee |
| GET | `/api/employees/department/{dept}` | Get by department |
| GET | `/api/employees/search?query=name` | Search employees |

### Order Management
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/orders` | Get all orders |
| GET | `/api/orders/{id}` | Get order by ID |
| POST | `/api/orders` | Create new order |
| PUT | `/api/orders/{id}/status?status=Shipped` | Update status |
| GET | `/api/orders/status/{status}` | Get by status |

## Test with curl

```bash
# Get all employees
curl http://localhost:8080/api/employees

# Get employee by ID
curl http://localhost:8080/api/employees/1

# Create employee
curl -X POST http://localhost:8080/api/employees \
  -H "Content-Type: application/json" \
  -d '{"name":"New Employee","email":"new@company.com","department":"IT","salary":60000,"designation":"Developer"}'

# Update employee
curl -X PUT http://localhost:8080/api/employees/1 \
  -H "Content-Type: application/json" \
  -d '{"name":"Alice Updated","email":"alice@company.com","Engineering","salary":80000,"designation":"Tech Lead"}'

# Delete employee
curl -X DELETE http://localhost:8080/api/employees/1

# Get employees by department
curl http://localhost:8080/api/employees/department/Engineering

# Search employees
curl http://localhost:8080/api/employees/search?query=Alice

# Get all orders
curl http://localhost:8080/api/orders

# Get order by ID
curl http://localhost:8080/api/orders/1

# Create new order
curl -X POST http://localhost:8080/api/orders \
  -H "Content-Type: application/json" \
  -d '{"customerName":"New Customer","product":"Tablet","quantity":1,"totalPrice":499.99,"status":"Processing","orderDate":"2026-04-07"}'

# Update order status
curl -X PUT "http://localhost:8080/api/orders/1/status?status=Delivered"

# Get orders by status
curl http://localhost:8080/api/orders/status/Processing
```

## Docker

```bash
# Build
cd experiment-03-gradle
docker build -t gradle-demo-app:latest .

# Run
docker run -p 8080:8080 gradle-demo-app:latest
```

## Gradle vs Maven Commands

| Action | Maven | Gradle |
|--------|-------|--------|
| Clean | `mvn clean` | `./gradlew clean` |
| Build | `mvn package` | `./gradlew build` |
| Run | `java -jar target/*.jar` | `java -jar build/libs/*.jar` |
| Tests | `mvn test` | `./gradlew test` |
| Clean Build | `mvn clean package` | `./gradlew clean build` |
