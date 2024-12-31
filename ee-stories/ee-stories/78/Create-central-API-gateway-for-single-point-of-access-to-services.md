## Summary
**As a** DevOps engineer or cloud architect, **I want** to create a **central API Gateway** for a single point of access to various backend services, **so that** all service requests can be routed through a common interface, improving security, scalability, and ease of management.

A central API gateway acts as a reverse proxy to accept all application programming interface (API) calls, aggregate the services behind it, and return the appropriate responses. This approach simplifies client access to multiple services and improves observability, monitoring, and security by enforcing a consistent layer of authentication, logging, and rate limiting.

### Vision
By implementing a central API Gateway, the team will provide a unified entry point for all services, enabling better security and streamlined routing. This setup will reduce complexity for external clients and ensure that all requests to backend services are monitored and secured with consistent policies.

### Background
In a microservices architecture, multiple services are often exposed individually to clients. Without a central API Gateway, managing authentication, authorization, security policies, and service routing becomes complex. A centralized API Gateway allows you to apply consistent policies, monitor traffic, and scale services independently while providing clients with a simplified interface.

### Purpose
The purpose of this story is to configure a central API Gateway that serves as a single access point for various backend services, allowing secure, monitored, and optimized communication between external clients and internal services.

## Details

### 1. **Choose the API Gateway Platform**
   - **AWS API Gateway**: A fully managed service that enables developers to create, publish, maintain, and secure APIs at any scale. It integrates seamlessly with AWS services like Lambda, ECS, and RDS.
   - **Kong**: An open-source API Gateway that provides features like authentication, rate limiting, and logging, and can be hosted on-premise or in the cloud.
   - **Nginx**: A lightweight web server and API gateway that can be configured as a reverse proxy to route API calls.

   **In this example, we'll use AWS API Gateway for its ease of integration with AWS services and built-in security features.**

### 2. **Design the API Gateway Structure**
   - Define the **routes** that will connect each service behind the gateway to its appropriate path. Each route will point to a different backend service.
   - Use **method mappings** to define the HTTP methods (GET, POST, PUT, DELETE) supported by each API route.
   - **Example Routes**:
     - `/users` → Backend User Service
     - `/orders` → Backend Order Service
     - `/products` → Backend Product Service

   **Example API Mapping**:
   ```bash
   https://api.example.com/users -> User Service
   https://api.example.com/orders -> Order Service
   https://api.example.com/products -> Product Service
   ```

### 3. **Create an API Gateway in AWS**
   - **Step 1: Set Up the API Gateway**
     - Navigate to the **API Gateway** service in the AWS console.
     - Choose **Create API**, then select **HTTP API** for lightweight use cases, or **REST API** if advanced features like API keys or usage plans are required.

   **Example AWS CLI Command to Create an API Gateway**:
   ```bash
   aws apigateway create-rest-api \
     --name 'CentralAPI' \
     --description 'Central API Gateway for Microservices' \
     --endpoint-configuration types=REGIONAL
   ```

   - **Step 2: Define Resources and Methods**
     - For each service, define an **API resource** (e.g., `/users`, `/orders`).
     - Map the **HTTP methods** (GET, POST, etc.) to backend services like AWS Lambda, ECS, or an HTTP endpoint.

   **Example Resource Creation for a User Service**:
   ```bash
   aws apigateway create-resource \
     --rest-api-id abcdef1234 \
     --parent-id abc123 \
     --path-part users
   ```

   **Map a POST Method to the User Service**:
   ```bash
   aws apigateway put-method \
     --rest-api-id abcdef1234 \
     --resource-id xyz789 \
     --http-method POST \
     --authorization-type NONE

   aws apigateway put-integration \
     --rest-api-id abcdef1234 \
     --resource-id xyz789 \
     --http-method POST \
     --type HTTP \
     --integration-http-method POST \
     --uri 'https://backend.example.com/users'
   ```

### 4. **Implement Security Policies**
   - Configure security policies to ensure that only authorized users can access the API. You can use **Cognito**, **IAM roles**, or **API keys** for securing the API.
   - **Enable HTTPS** to ensure all traffic is encrypted between clients and the API Gateway.
   - Use **JWT (JSON Web Tokens)** or **OAuth** to authenticate API requests.

   **Example: Using AWS Cognito for API Authentication**:
   - Create a Cognito user pool and configure API Gateway to authorize requests using the Cognito pool.
   ```bash
   aws apigateway create-authorizer \
     --rest-api-id abcdef1234 \
     --name CognitoAuthorizer \
     --type COGNITO_USER_POOLS \
     --provider-arns arn:aws:cognito-idp:region:account-id:userpool/userpool-id
   ```

   - Apply the authorizer to the API Gateway method.
   ```bash
   aws apigateway update-method \
     --rest-api-id abcdef1234 \
     --resource-id xyz789 \
     --http-method POST \
     --patch-operations op=replace,path=/authorizationType,value=COGNITO_USER_POOLS
   ```

### 5. **Enable Logging and Monitoring**
   - Enable detailed logging for all API Gateway requests using **AWS CloudWatch Logs**. This allows you to track performance, errors, and usage patterns.
   - Set up **CloudWatch Alarms** for error rates or latency spikes, notifying the team when performance degrades or when there are security concerns.

   **Example: Enabling API Gateway Logs**:
   ```bash
   aws apigateway update-stage \
     --rest-api-id abcdef1234 \
     --stage-name dev \
     --patch-operations op=replace,path=/methodSettings/*/*/logging/dataTrace,value=true
   ```

   - Enable metrics like **Latency**, **4xx Error Rate**, and **5xx Error Rate** to ensure you're aware of any issues.

### 6. **Rate Limiting and Throttling**
   - Apply **rate limiting** and **throttling** to protect your backend services from being overwhelmed by too many requests. AWS API Gateway provides built-in support for setting request limits and burst capacity.
   - Define a **usage plan** and apply it to each client using API keys, controlling how many requests each user can make within a given time period.

   **Example: Setting Rate Limits and Bursting Capacity**:
   ```bash
   aws apigateway create-usage-plan \
     --name "BasicPlan" \
     --throttle burstLimit=100,rateLimit=50
   ```

### 7. **Deploy the API**
   - Once the API configuration is complete, deploy it to a specific stage (e.g., `dev`, `prod`) to make it accessible to external clients.

   **Example AWS CLI to Deploy the API**:
   ```bash
   aws apigateway create-deployment \
     --rest-api-id abcdef1234 \
     --stage-name prod
   ```

   - Share the **API URL** with external clients and update the DNS records (if necessary) to map a friendly domain name to the API Gateway endpoint.

### 8. **Test the API Gateway**
   - Use tools like **Postman**, **cURL**, or **AWS CLI** to test the API by sending requests to the routes you defined.
   - Test both authenticated and unauthenticated requests to ensure security policies are correctly enforced.
   - Simulate high traffic to test rate limiting and throttling.

   **Example cURL Request**:
   ```bash
   curl -X POST https://api.example.com/users -H "Authorization: Bearer <JWT_TOKEN>" -d '{"name": "John Doe"}'
   ```

### Testing
- Verify that all routes in the API Gateway map correctly to their respective backend services.
- Test security policies by attempting to access the API without authentication and ensuring the request is blocked.
- Test rate limiting and throttling to ensure that clients cannot exceed predefined limits.
- Monitor the API's latency, error rates, and request patterns using CloudWatch.

### Acceptance Criteria
- Should configure a central API Gateway to act as a single point of access for all backend services.
- Should apply security policies (e.g., Cognito, API keys) to secure API endpoints.
- Should enable CloudWatch Logs and Metrics to monitor API performance and traffic patterns.
- Should implement rate limiting and throttling to protect backend services.
- Should successfully deploy and test the API Gateway, verifying that all routes are correctly mapped and secured.

### External Links
- [AWS API Gateway Documentation](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)
- [Kong API Gateway Documentation](https://docs.konghq.com/)
- [Enabling API Gateway Logs](https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-logging.html)
