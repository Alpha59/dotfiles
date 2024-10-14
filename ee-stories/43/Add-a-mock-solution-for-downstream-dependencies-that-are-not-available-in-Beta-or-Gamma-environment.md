
# Add a mock solution for downstream dependencies that are not available in Beta or Gamma environment
### Summary
**As a** DevOps Engineer, **I want** to implement a mock solution for downstream dependencies that are not available in the Beta or Gamma environments, **So That** we can simulate the behavior of these dependencies, allowing for continuous testing and validation of application features without relying on unavailable external systems.

This story focuses on creating a mock service that simulates downstream dependencies (such as external APIs, databases, or third-party services) when these services are unavailable in non-production environments. This allows for functional testing, performance monitoring, and continuous integration workflows to proceed without being blocked by missing dependencies.

### Vision
By implementing mock services for unavailable downstream dependencies, we enable continuous testing and development in the Beta and Gamma environments, ensuring that services are tested and validated in isolation. This reduces the risk of integration issues and ensures that the application can progress through its testing lifecycle without being held back by unavailable external dependencies.

### Background
In non-production environments like Beta or Gamma, certain downstream dependencies (e.g., third-party APIs, database services, or internal microservices) may not be fully available or integrated. Mocking these dependencies provides a controlled way to simulate their responses and behaviors. Mock services can return predefined responses, simulate errors, or provide default data to ensure that application logic relying on these services can still be validated.

---

### Steps to Implement a Mock Solution for Downstream Dependencies

#### 1. **Identify Unavailable Dependencies and Their Expected Behavior**

First, identify the downstream dependencies that are not available in the Beta or Gamma environments. These could be APIs, databases, external services, or other microservices that are critical for the application’s functionality.

For each dependency, determine:
- The typical input and output (e.g., API requests and responses).
- Possible error conditions (e.g., network failures, timeouts, 4xx or 5xx errors).
- Key data or operations that the dependency handles (e.g., authentication, data retrieval, transaction processing).

---

#### 2. **Create a Mock Service Using AWS Lambda (or Similar Framework)**

For simplicity and scalability, AWS Lambda can be used to create mock services that simulate the behavior of the downstream dependencies. You can also use other serverless frameworks, containerized microservices, or libraries like **WireMock** or **Postman Mock Servers** depending on your environment.

##### Step 1: Set Up a Lambda Function to Act as a Mock Service

Here’s an example of creating a Lambda function that mocks an unavailable downstream API.

1. **Lambda Function Code**: Create a mock function that simulates an API returning some fixed data.

```javascript
exports.handler = async (event) => {
    const { path } = event;

    // Simulate responses based on the API endpoint being called
    if (path === '/mock-data') {
        return {
            statusCode: 200,
            body: JSON.stringify({
                success: true,
                data: {
                    id: 1,
                    name: 'Mock Data',
                    description: 'This is a mock response from the unavailable dependency.'
                }
            }),
        };
    } else if (path === '/mock-error') {
        return {
            statusCode: 500,
            body: JSON.stringify({
                success: false,
                error: 'Simulated downstream service failure.'
            }),
        };
    }

    // Default fallback for unrecognized paths
    return {
        statusCode: 404,
        body: JSON.stringify({
            success: false,
            error: 'Endpoint not found in mock service.'
        }),
    };
};
```

- **/mock-data** simulates a successful response with sample data.
- **/mock-error** simulates a failure in the downstream service.

##### Step 2: Deploy Lambda Function

You can use the **AWS CLI**, **Serverless Framework**, or **AWS CDK** to deploy the Lambda function. Here’s an example using AWS CLI:

```bash
aws lambda create-function --function-name MockDownstreamService   --runtime nodejs14.x   --role <IAM-Role-ARN>   --handler index.handler   --zip-file fileb://function.zip
```

The `function.zip` file contains the Node.js code for the Lambda function.

##### Step 3: Set Up API Gateway to Expose Mock Service

You can create an **API Gateway** to expose the mock Lambda function as an HTTP endpoint.

```bash
aws apigateway create-rest-api --name 'MockDownstreamAPI'
```

Once the API is created, map the Lambda function to API Gateway routes, allowing your application to call the mock endpoints.

---

#### 3. **Set Up Mock Behavior for Various Scenarios**

The mock service should be able to handle a variety of scenarios to mimic real-world behavior. Examples include:

- **Success Responses**: Return valid data for expected inputs.
- **Failure Responses**: Simulate timeouts, 4xx, and 5xx errors.
- **Latency**: Introduce artificial delays to simulate network latency.
- **Error Handling**: Simulate error conditions such as service unavailability or bad request responses.

Here’s how you can extend the Lambda function to introduce more realistic conditions, such as latency or errors:

```javascript
exports.handler = async (event) => {
    const { path } = event;
    const simulateLatency = process.env.SIMULATE_LATENCY || false;

    if (simulateLatency) {
        // Simulate latency by adding a delay
        await new Promise(resolve => setTimeout(resolve, 2000));
    }

    if (path === '/mock-data') {
        return {
            statusCode: 200,
            body: JSON.stringify({
                success: true,
                data: {
                    id: 1,
                    name: 'Mock Data',
                    description: 'This is a mock response from the unavailable dependency.'
                }
            }),
        };
    } else if (path === '/mock-error') {
        return {
            statusCode: 500,
            body: JSON.stringify({
                success: false,
                error: 'Simulated downstream service failure.'
            }),
        };
    }

    return {
        statusCode: 404,
        body: JSON.stringify({
            success: false,
            error: 'Endpoint not found in mock service.'
        }),
    };
};
```

You can set up the Lambda function to simulate latency by using an environment variable (`SIMULATE_LATENCY`), which you can toggle during testing.

---

#### 4. **Integrate the Mock Solution with Beta/Gamma Environments**

In the Beta or Gamma environments, ensure that calls to the unavailable downstream dependencies are redirected to the mock service. You can do this by:

- **Feature Flags**: Use feature flags to enable or disable real dependency calls in the application. When enabled, the application will redirect requests to the mock service.
- **Environment Configuration**: Update the environment-specific configuration to point to the mock service URL (e.g., the API Gateway endpoint) instead of the real downstream service.
- **Proxy Mock Calls**: For dependencies that are internal services, you can proxy calls from the main application to the mock service when in Beta or Gamma.

---

#### 5. **Test the Mock Solution**

Ensure that the mock service behaves as expected by testing various scenarios, including:

- **Successful Responses**: Verify that the mock service returns the expected data and mimics the behavior of the actual service.
- **Error Responses**: Verify that errors are simulated correctly, including 4xx and 5xx responses.
- **Latency Handling**: Ensure that the application can handle slow responses or timeouts simulated by the mock service.

You can use **Postman**, **cURL**, or automated tests to validate the responses from the mock service.

---

### Example Configuration for Environment-Specific Mock Integration

In your application’s environment configuration, set the URLs for the dependencies based on the environment:

```json
{
  'production': {
    'apiUrl': 'https://prod-api.example.com',
    'downstreamServiceUrl': 'https://prod-downstream-service.example.com'
  },
  'beta': {
    'apiUrl': 'https://beta-api.example.com',
    'downstreamServiceUrl': 'https://mock-downstream-api.execute-api.us-east-1.amazonaws.com/mock'
  },
  'gamma': {
    'apiUrl': 'https://gamma-api.example.com',
    'downstreamServiceUrl': 'https://mock-downstream-api.execute-api.us-east-1.amazonaws.com/mock'
  }
}
```

In Beta or Gamma environments, the `downstreamServiceUrl` is pointed to the mock API Gateway endpoint.

---

### Acceptance Criteria
- Should have a mock service that simulates unavailable downstream dependencies.
- Should handle various responses, including successful responses, 4xx, 5xx errors, and timeouts.
- Should integrate the mock service into Beta and Gamma environments using configuration or feature flags.
- Should have tested the mock service to ensure that it mimics the real dependency’s behavior.
- Should ensure that the application can continue to function and be tested in Beta/Gamma environments without relying on unavailable services.
