## Summary
**As a** service operator, **I want** to verify that canaries are calling into production against public endpoints **so that** I can ensure the availability, reliability, and performance of critical services from an external perspective.

### Vision
The vision for this verification is to ensure that canaries simulate real-world user behavior by calling public production endpoints. This allows us to detect issues that could impact customers and provides proactive insights into service health.

### Background
Canaries are automated scripts or tests that periodically call into production services to validate their functionality, latency, and reliability. By testing against public endpoints, canaries mimic external user interactions, helping to identify potential issues before they affect customers.

### Purpose
The purpose of this task is to validate that canaries are configured to test public production endpoints and verify their functionality, metrics collection, and alerting mechanisms.

## Steps for Verifying Canaries

### 1. **Identify Target Endpoints**
| **Endpoint Name**        | **Description**                           | **Purpose**                                    |
|---------------------------|-------------------------------------------|-----------------------------------------------|
| **API Gateway Endpoint**  | Public-facing API endpoint.              | Validate API availability and response times. |
| **Web Application URL**   | Public URL for web services.             | Test user-facing functionalities.             |
| **Static Assets Endpoint**| Endpoint for static resources (e.g., images, JS files). | Ensure proper content delivery.               |

### 2. **Check Canary Configuration**
#### A. **Configuration Details**
- **Environment**: Verify that the canaries are configured to target the production environment (e.g., `https://api.prod.example.com`).
- **Test Scenarios**:
  - API request/response validation.
  - Latency measurement.
  - Response status codes (e.g., 200 OK, 404 Not Found, 500 Internal Server Error).
  - Content correctness for web pages or assets.
- **Frequency**: Ensure canaries are running at an appropriate interval (e.g., every 1-5 minutes).

#### B. **Authentication**
- Verify that public endpoints requiring authentication are tested with valid credentials or tokens.
- Ensure credentials used by the canaries are securely stored and rotated regularly.

#### C. **Request Payloads**
- Confirm that the canaries send realistic request payloads to mimic actual user interactions.

### 3. **Verify Metrics Collection**
#### A. **Metrics Captured**
- **Availability**: Percentage of successful requests.
- **Latency**: Response time distribution (e.g., p50, p95, p99).
- **Error Rate**: Percentage of failed requests (4xx and 5xx errors).

#### B. **Monitoring Tools**
- Confirm that canary metrics are sent to monitoring platforms (e.g., AWS CloudWatch, Datadog).
- Ensure dashboards display real-time canary performance metrics.

### 4. **Verify Alerting Mechanisms**
#### A. **Alerts Configuration**
- **Thresholds**:
  - Availability: <99.9%.
  - Latency: >500ms for p95.
  - Error Rate: >1%.
- **Notification Channels**:
  - Alerts should be sent to relevant teams via email, Slack, or PagerDuty.

#### B. **Testing Alerts**
- Simulate failures in canary tests to verify that alerts are triggered and reach the appropriate recipients.

### 5. **Validation**
#### A. **Run Canaries**
- Execute canary tests and monitor their behavior in the dashboard.
- Verify logs to ensure that requests are made to the correct public endpoints.
#### B. **Analyze Results**
- Review metrics to confirm that they align with expected values.
- Investigate and address any anomalies or failures.

### 6. **Documentation**
- Maintain documentation of canary configurations, test scenarios, and expected results.
- Update runbooks with procedures for troubleshooting canary failures.

## Acceptance Criteria
- Should confirm that canaries are correctly configured to call public production endpoints.
- Should verify metrics collection and monitoring for availability, latency, and error rates.
- Should validate that alerting mechanisms are functional and configured with appropriate thresholds.
- Should ensure secure handling of authentication credentials for canary requests.

### Gherkin
Given a configured canary,
When it executes against public production endpoints,
Then it should validate availability, latency, and correctness, and send metrics and alerts as configured.

By verifying that canaries are calling public production endpoints, we ensure proactive monitoring of service health, providing a reliable mechanism for early detection of issues that could impact customers.
