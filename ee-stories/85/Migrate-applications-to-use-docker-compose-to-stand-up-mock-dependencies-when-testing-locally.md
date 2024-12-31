### Summary
**As a** DevOps Engineer, **I want** to migrate applications to use Docker Compose to stand up mock dependencies when testing locally **So That** developers can easily simulate the application environment and its dependencies during local development and testing, ensuring consistency and reducing the risk of integration issues.

This story focuses on configuring Docker Compose to manage mock versions of external services, databases, and APIs, providing a lightweight, containerized environment for local development. This allows developers to test their applications in isolation with minimal setup, avoiding the need to connect to live services while still ensuring the application behaves as expected.

### Vision
By migrating applications to use Docker Compose for local testing with mock dependencies, we ensure that all developers have access to a consistent, easy-to-set-up environment that mimics production-like conditions. This will improve the development workflow, reduce dependency-related issues during testing, and speed up the process of verifying application functionality.

### Background
Many applications rely on external services (e.g., databases, APIs, messaging queues) that may not always be available or accessible during local development. Docker Compose allows developers to define and run multi-container Docker applications, which can include mock versions of these dependencies. By simulating these dependencies locally, developers can work independently of external services and ensure their code is properly tested before integration with real services.

---

### Steps to Migrate Applications to Use Docker Compose with Mock Dependencies

#### 1. **Install Docker and Docker Compose**
Ensure that all developers have **Docker** and **Docker Compose** installed on their local machines.

##### Step 1: Install Docker
- Download Docker from the official website: [https://www.docker.com/get-started](https://www.docker.com/get-started).
- Follow the installation instructions for your operating system (Windows, macOS, Linux).

##### Step 2: Install Docker Compose
Docker Compose is included with Docker Desktop. For Linux, install it separately:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

---

#### 2. **Create a `docker-compose.yml` File**

A `docker-compose.yml` file defines the services (application and mock dependencies) that will run in containers. This file allows you to specify the configurations for each service, such as the image to use, ports, volumes, and environment variables.

##### Example `docker-compose.yml` for a Node.js Application with a Mock Database and API:

```yaml
version: '3'
services:
  app:
    image: node:14
    container_name: my_app
    working_dir: /usr/src/app
    volumes:
      - .:/usr/src/app
    ports:
      - "3000:3000"
    environment:
      NODE_ENV: development
      DB_HOST: db
      API_URL: http://mock-api:8080
    command: npm start
    depends_on:
      - db
      - mock-api

  db:
    image: postgres:13
    container_name: mock_db
    environment:
      POSTGRES_USER: testuser
      POSTGRES_PASSWORD: testpassword
      POSTGRES_DB: testdb
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data

  mock-api:
    image: openapitools/openapi-mock:latest
    container_name: mock_api
    environment:
      SPEC_URL: https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/examples/v3.0/petstore.yaml
    ports:
      - "8080:8080"

volumes:
  db_data:
```

This configuration defines:
- **`app`**: The main application service, running in a Node.js container, depending on a mock database (`db`) and a mock API (`mock-api`).
- **`db`**: A mock PostgreSQL database service.
- **`mock-api`**: A mock API service using an OpenAPI specification.

---

#### 3. **Modify Application to Use Mock Dependencies**

Ensure that the application is configured to use the mock services provided by Docker Compose when running locally.

##### Step 1: Update Environment Variables
In the `docker-compose.yml`, we define environment variables such as `DB_HOST` and `API_URL`. Ensure that the application reads these environment variables correctly.

Example (for Node.js):

```javascript
const dbHost = process.env.DB_HOST || 'localhost';
const apiUrl = process.env.API_URL || 'http://localhost:8080';
```

By using environment variables, the application can connect to the mock services during local testing while still pointing to real services in other environments (e.g., staging, production).

---

#### 4. **Run Docker Compose for Local Development**

Once the `docker-compose.yml` file is set up and the application is modified to use mock dependencies, developers can spin up the entire environment using Docker Compose.

##### Step 1: Start the Services
To bring up the entire stack (application and mock dependencies), run the following command in the root directory of your project:

```bash
docker-compose up
```

This command will start all services defined in `docker-compose.yml`. The application will be able to interact with the mock database and API as if they were real services.

##### Step 2: Access Logs and Test Application
Check the logs for each service to ensure everything is running correctly:

```bash
docker-compose logs
```

Test the application locally by accessing it through the exposed ports (e.g., `http://localhost:3000`).

---

#### 5. **Run Tests Locally with Mock Dependencies**

Once Docker Compose is running, developers can run their unit and integration tests using the mock dependencies.

##### Step 1: Run Tests
Ensure that the application is connected to the mock dependencies, and then run your test suite.

Example for Node.js:

```bash
npm test
```

The application will now interact with the mock database and API during tests, providing a consistent and controlled environment for local development.

---

#### 6. **Optional: Automate Testing with Docker Compose in CI/CD**

You can integrate Docker Compose into your CI/CD pipeline to run tests in a containerized environment during continuous integration.

##### Step 1: Add Docker Compose to CI/CD Pipeline
In your CI configuration file (e.g., `.gitlab-ci.yml`, `.github/workflows`), add steps to run Docker Compose before executing tests.

Example for **GitLab CI**:

```yaml
stages:
  - test

test:
  services:
    - docker:dind

  before_script:
    - docker-compose up -d

  script:
    - npm test
```

---

### Acceptance Criteria
- Should create a `docker-compose.yml` file that defines the application and its mock dependencies (e.g., databases, APIs).
- Should configure the application to use the mock dependencies for local development.
- Should ensure that the Docker Compose setup allows the application to run locally without needing external services.
- Should ensure developers can run tests locally using the mock environment.
- Should verify that Docker Compose can bring up the entire local development environment with a single command (`docker-compose up`).
