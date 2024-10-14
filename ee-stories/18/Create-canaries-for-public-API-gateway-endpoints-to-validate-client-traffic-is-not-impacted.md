
# Create canaries for public API gateway endpoints to validate client traffic is not impacted
### Summary
**As a** DevOps Engineer, **I want** to create canaries for public API Gateway endpoints, **So That** we can continuously validate that client traffic is not impacted by downtime, misconfigurations, or performance issues, ensuring the availability and reliability of the APIs.

This story focuses on implementing canaries to simulate client requests to public API Gateway endpoints. By continuously monitoring API behavior through these automated tests, we aim to ensure that APIs are accessible, performing within acceptable limits, and responding correctly, thereby preventing client impact.

### Vision
Creating canaries for public API Gateway endpoints ensures that any issues affecting client traffic—such as downtime, misconfigurations, or latency—are detected early, allowing for prompt remediation. By automating API health checks and performance monitoring, we improve the system’s reliability and client experience, while reducing the risk of unnoticed failures or performance degradation.

### Background
Currently, without real-time monitoring of public API Gateway endpoints, there is a risk that issues affecting API availability or performance may not be detected until they impact clients. Canaries allow us to simulate real client traffic and validate the API’s behavior continuously, ensuring that any issues are identified and addressed before they affect clients.

### Purpose
The purpose of this story is to create and configure canaries for public API Gateway endpoints, simulating real client traffic to validate that the APIs are accessible and performant. This initiative aims to ensure the availability and reliability of the APIs, detect issues early, and prevent disruptions to client traffic.

## Details
1. **Identify Public API Gateway Endpoints**:
    - Identify all public API Gateway endpoints that serve client traffic and are critical to the system’s functionality.
    - For each API, document the expected responses, performance thresholds, and any specific behavior that needs to be validated (e.g., correct HTTP status codes, response times).

2. **Define Canaries for API Health Checks**:
    - Define canary test scenarios for each public API endpoint. These scenarios should mimic common client interactions, including:
      - Sending requests to the API with valid input parameters.
      - Handling various HTTP methods (e.g., GET, POST, PUT).
      - Validating the correctness of the responses (e.g., expected payloads, status codes).
      - Monitoring response times and ensuring they meet performance SLAs.

3. **Automate Canary Setup**:
    - Use monitoring tools like AWS CloudWatch Synthetics, Datadog Synthetics, or a similar canary testing tool to automate API health checks.
    - Set up canaries to periodically send requests to the public API endpoints at regular intervals (e.g., every 1 minute or 5 minutes).
    - Configure the canaries to simulate realistic traffic, including requests with different headers, query parameters, and payloads.

4. **Validate API Performance and Availability**:
    - Configure the canaries to monitor key performance metrics, such as:
      - **Response times**: Ensure API responses are within acceptable thresholds (e.g., < 500ms).
      - **Error rates**: Track the percentage of failed requests and monitor for 4xx/5xx HTTP status codes.
      - **Content validation**: Verify the structure and content of the responses to ensure correctness.
    - Use canary reports to compare actual performance and availability against defined SLAs.

5. **Set Up Alerts for Failures and Performance Degradation**:
    - Integrate canary results with monitoring and alerting platforms (e.g., AWS CloudWatch, Datadog) to automatically trigger alerts when:
      - API endpoints return unexpected status codes (e.g., 5xx errors).
      - Response times exceed predefined thresholds.
      - The canaries detect downtime or significant performance degradation.
    - Configure notifications to inform relevant teams (e.g., via Slack, PagerDuty, or email) when issues are detected.

6. **Monitor and Review Canary Results**:
    - Continuously monitor the performance of the canaries and review their reports to ensure API availability and reliability are maintained.
    - Analyze trends in canary results to proactively identify potential issues (e.g., increasing response times or error rates) before they impact clients.
    - Document any issues discovered through canary testing and follow up with root cause analysis and remediation.

7. **Document Canary Configuration and Maintenance**:
    - Document the configuration of each canary, including the APIs being monitored, test scenarios, and performance thresholds.
    - Establish a process for regularly reviewing and updating the canaries to ensure they reflect any changes to the API (e.g., new endpoints, modified parameters).
    - Set up maintenance schedules to ensure canaries are tested and kept up to date with system changes.

### Testing
- Execute the canaries in a test environment to verify that they correctly simulate client requests and monitor API performance and availability.
- Simulate API failures and performance degradation (e.g., increased latency, returning 5xx errors) to ensure that canary alerts are triggered appropriately.
- Validate that canaries accurately track performance metrics, such as response times and error rates, and log results for later analysis.
- Monitor the alerting system to ensure that notifications are sent to the relevant teams when API issues are detected.

### External Dependencies
- Integration with canary testing tools (e.g., AWS CloudWatch Synthetics, Datadog Synthetics) for automating and managing the canary tests.
- Access to API Gateway endpoints in the test and production environments for simulating client requests and validating responses.
- Collaboration with the operations and development teams to define performance SLAs, validate canary results, and resolve identified issues.

## Acceptance Criteria
- Should have created and configured canaries for all critical public API Gateway endpoints to simulate client traffic.
- Should have validated that the canaries can continuously monitor API availability, performance, and correctness, reporting metrics such as response times and error rates.
- Should have integrated canary results with the monitoring and alerting platform, ensuring that alerts are triggered when performance degradation or downtime occurs.
- Should have documented the canary configurations and established a process for maintaining and updating them as the API evolves.

### Gherkin
#### Scenario: Setting Up Canaries for Public API Endpoints
Given the identification of public API Gateway endpoints,
When canaries are configured for these endpoints,
Then they should periodically send requests to simulate client traffic and validate API availability, performance, and correctness.

#### Scenario: Triggering Alerts for API Downtime
Given a public API Gateway endpoint experiencing downtime,
When the canary detects a 5xx error or unresponsive API,
Then an alert should be triggered, notifying the relevant team of the issue.

#### Scenario: Monitoring API Performance with Canaries
Given the execution of canary tests for public APIs,
When the response time for an API exceeds the defined threshold,
Then the canary should log the issue and trigger an alert if necessary.

## API
N/A

## External Links
- [AWS CloudWatch Synthetics Documentation](https://docs.aws.amazon.com/
- [Datadog Synthetics API Testing](https://docs.datadoghq.com/synthetics/api_tests/)
- [Best Practices for Monitoring API Performance](#)
