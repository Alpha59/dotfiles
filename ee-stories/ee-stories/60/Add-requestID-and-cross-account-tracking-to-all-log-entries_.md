## Summary
**As a** DevOps engineer or software engineer, **I want** to add `requestID` and cross-account tracking to all log entries, **so that** I can trace requests across different services, accounts, and environments, improving observability, debugging, and monitoring of the system, especially in complex microservices and cross-account environments.

Adding `requestID` and cross-account tracking helps correlate requests and activities across services, making it easier to track issues, performance bottlenecks, and failures across multiple systems. This enables better root cause analysis, system monitoring, and auditing.

### Vision
By including `requestID` and cross-account tracking in all log entries, we ensure that requests can be traced end-to-end across multiple systems, services, and AWS accounts. This provides increased visibility into how different parts of the system interact and improves our ability to detect and troubleshoot issues effectively in complex, distributed environments.

### Background
In modern distributed systems, requests often pass through multiple services and may involve cross-account operations (e.g., cross-account API calls, resource access). Without proper tracking, it becomes difficult to trace these requests across services and accounts, making it harder to debug issues and monitor system performance. Adding unique request identifiers (`requestID`) and cross-account information (e.g., `accountID`, `originAccount`) to logs helps address these challenges by ensuring logs can be correlated across all components involved in processing a request.

### Purpose
The purpose of this story is to implement `requestID` and cross-account tracking in all log entries to improve observability and traceability across services and AWS accounts. This includes modifying logging mechanisms to ensure that each log entry contains a unique `requestID` and, where applicable, cross-account information.

## Details

### 1. **Generate and Propagate Request IDs**
   - **Generate a Unique Request ID**:
     - For each incoming request to a service or API, generate a unique `requestID` (e.g., using UUID or a similar unique identifier mechanism).
     - Example using Node.js with UUID:
       ```javascript
       const { v4: uuidv4 } = require('uuid');
       const requestID = uuidv4();
       ```

   - **Pass the Request ID Across Services**:
     - Ensure that the `requestID` is propagated across all services involved in handling the request. This includes adding the `requestID` to HTTP headers, message queues, and other communication protocols between services.
     - Example:
       - HTTP header: `X-Request-ID: <requestID>`
       - SQS message: `{ "requestID": "<requestID>", "payload": {...} }`

   - **Incorporate Request ID into Logs**:
     - Modify the logging configuration to ensure that the `requestID` is included in all log entries. This can be done by adding the `requestID` to the log context or as part of the log format.
     - Example with `winston` logging in Node.js:
       ```javascript
       const logger = winston.createLogger({
         format: winston.format.combine(
           winston.format.timestamp(),
           winston.format.printf(({ timestamp, level, message, requestID }) => {
             return `${timestamp} [${level}] [RequestID: ${requestID}] ${message}`;
           })
         ),
         transports: [new winston.transports.Console()]
       });
       ```

### 2. **Add Cross-Account Tracking**
   - **Account Identification**:
     - For services or API calls that involve cross-account operations, include information about the account making the request (`originAccount`) and the account receiving or processing the request (`targetAccount`).
     - Example for AWS:
       - **originAccount**: The AWS account ID of the source account making the request.
       - **targetAccount**: The AWS account ID of the destination account processing the request.
     - You can retrieve the current AWS account ID using the **STS** service:
       ```javascript
       const AWS = require('aws-sdk');
       const sts = new AWS.STS();
       sts.getCallerIdentity({}, function(err, data) {
         console.log("Account: ", data.Account);
       });
       ```

   - **Pass Cross-Account Information in Logs**:
     - Ensure that each log entry includes `originAccount` and `targetAccount` details where applicable. This helps trace cross-account requests and correlate logs across multiple accounts.
     - Example log entry format:
       ```
       Timestamp: 2024-10-09T12:34:56Z, Level: INFO, RequestID: abc123, OriginAccount: 123456789012, TargetAccount: 987654321098, Message: Request processed successfully.
       ```

   - **Pass Cross-Account Information in Requests**:
     - For cross-account API calls, include `originAccount` information in HTTP headers or payloads to ensure it is passed across services and accounts.
     - Example:
       - HTTP header: `X-Origin-Account: <originAccountID>`

### 3. **Modify Logging Frameworks**
   - **Update Logging Libraries**:
     - Modify the logging libraries or frameworks (e.g., **winston**, **log4j**, **bunyan**, or **pino**) used in the services to include `requestID` and cross-account tracking information as part of the log format. This can be done by adding metadata fields to the log entries.

   - **Standardize Logging Format**:
     - Ensure that all services follow a standardized logging format, including `requestID`, `originAccount`, and `targetAccount` (where applicable). This helps maintain consistency across logs from different services and accounts.
     - Example standardized log format:
       ```
       Timestamp: <ISO8601 timestamp>
       Level: <log level>
       RequestID: <unique request ID>
       OriginAccount: <source AWS account>
       TargetAccount: <destination AWS account>
       Message: <log message>
       ```

### 4. **Testing the Implementation**
   - **Log Validation in Development and Beta Environments**:
     - Test the logging of `requestID` and cross-account tracking in development and beta environments. Ensure that all log entries contain the correct `requestID`, `originAccount`, and `targetAccount`.
     - Example test:
       - Send a request through multiple services and ensure that the `requestID` is propagated across all log entries.
       - Verify that cross-account requests include both the `originAccount` and `targetAccount` in the logs.

   - **Simulate Cross-Account Requests**:
     - Test cross-account requests by simulating interactions between services in different AWS accounts. Ensure that logs capture the `requestID` and both `originAccount` and `targetAccount` values correctly.

   - **Verify End-to-End Traceability**:
     - Verify that the `requestID` allows end-to-end traceability across multiple services and AWS accounts by following a request from its origin to completion in the logs.

   - **Error Handling and Logging**:
     - Ensure that error logs also include `requestID` and cross-account information, allowing easier troubleshooting and correlation of issues across services.

### 5. **Integrate with Monitoring and Alerting Tools**
   - **Centralized Log Aggregation**:
     - Integrate with centralized logging tools such as **AWS CloudWatch Logs**, **ELK Stack (Elasticsearch, Logstash, Kibana)**, **Splunk**, or **Datadog** to aggregate logs and make it easier to search logs using `requestID` or account information.
     - Example:
       - Search logs in CloudWatch using `requestID`:
         ```bash
         fields @timestamp, @message
         | filter requestID = "abc123"
         | sort @timestamp desc
         ```

   - **Monitoring and Alerts**:
     - Set up alerts for unusual patterns or errors in logs based on `requestID` and cross-account information. This ensures quick detection and response to issues that span multiple services or accounts.
     - Example: Set up an alert in **Datadog** to trigger when multiple failed requests with the same `requestID` occur across different services.

### Testing
- **Unit Testing**:
   - Write unit tests to verify that `requestID` is generated, propagated, and logged correctly across services. Ensure that the correct cross-account information (`originAccount`, `targetAccount`) is captured in log entries.

- **Integration Testing**:
   - Perform integration tests where requests flow through multiple services, ensuring that `requestID` is consistent across all logs and that cross-account information is correctly propagated.

- **Load Testing**:
   - Simulate high-traffic scenarios to verify that the system handles logging at scale and that the `requestID` and cross-account information are correctly captured under load.

### External Dependencies
- Logging libraries and frameworks (e.g., **winston**, **log4j**, **bunyan**, **pino**).
- Centralized logging systems (e.g., **AWS CloudWatch Logs**, **Elasticsearch**, **Datadog**, **Splunk**).
- Cross-account API calls or operations between services.

## Acceptance Criteria
- Should generate a unique `requestID` for each incoming request and propagate it across all services involved in handling the request.
- Should include `requestID` in all log entries across services for traceability.
- Should log `originAccount` and `targetAccount` information for cross-account requests.
- Should test the logging implementation in development and beta environments to ensure it works as expected and enables end-to-end traceability.

### Gherkin
```gherkin
Given a request is made to the API
When the request passes through multiple services
Then the logs should include a unique requestID for each step of the request
And the request

ID should be propagated across all services involved.
```
```gherkin
Given a cross-account request is made between AWS accounts
When the logs are generated
Then the log entries should include the originAccount and targetAccount details
And the logs should allow tracing the request across AWS accounts.
```

## API
N/A

## External Links
- [AWS CloudWatch Logs Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html)
- [AWS STS GetCallerIdentity API](https://docs.aws.amazon.com/STS/latest/APIReference/API_GetCallerIdentity.html)
- [Winston Logging Documentation](https://github.com/winstonjs/winston)
