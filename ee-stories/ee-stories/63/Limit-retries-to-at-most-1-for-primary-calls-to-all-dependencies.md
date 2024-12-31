## Summary
**As a** backend developer or DevOps engineer, **I want** to limit retries to at most 1 for primary calls to all dependencies, **so that** I can avoid overloading the system or dependencies with excessive retry requests, reduce latency, and ensure proper failure handling.

Limiting retries to a single attempt helps maintain system stability by preventing cascading failures or throttling issues caused by repeated retry attempts to a failed dependency. It ensures that the system fails fast, allowing for timely error handling and recovery mechanisms to engage without causing further strain on the system.

### Vision
By limiting retries to 1 for primary calls to all dependencies, the system becomes more resilient to transient failures without overwhelming dependent services. This approach ensures that errors are handled quickly, reducing the risk of cascading failures or degraded performance due to repeated retries.

### Background
Many systems implement automatic retry mechanisms when a dependency call fails, often due to transient issues like timeouts or network glitches. However, unbounded or excessive retries can compound problems, especially when multiple services are experiencing issues, leading to request amplification, increased latency, and potential overloads. Implementing a retry limit of 1 allows the system to handle transient issues without exacerbating failures by overwhelming dependencies.

### Purpose
The purpose of this story is to implement a limit of 1 retry for all primary dependency calls, ensuring that services handle failures efficiently without causing unnecessary strain on upstream services. This approach will improve error handling and prevent cascading failures due to multiple retries.

## Details

### 1. **Identify Primary Dependencies**
   - **Dependency Inventory**:
     - Identify all primary dependencies that the service interacts with. These may include databases, third-party APIs, internal microservices, external services, or message queues.
     - Example:
       - **Dependency 1**: Payment API
       - **Dependency 2**: Authentication service
       - **Dependency 3**: External data provider (e.g., weather data)

   - **Dependency Call Types**:
     - Identify the types of calls made to each dependency (e.g., API calls, database queries). This will inform how and where retry logic is applied.

### 2. **Implement Retry Limiting Logic**
   - **Retry Configuration**:
     - Implement retry logic to limit retries to at most 1 for each dependency call. This ensures that if a call fails, the system will only attempt 1 additional retry before failing and triggering error handling mechanisms.
     - Example in **Node.js** using the `axios-retry` library:
       ```javascript
       const axios = require('axios');
       const axiosRetry = require('axios-retry');

       axiosRetry(axios, {
           retries: 1,  // Limit to 1 retry
           retryCondition: (error) => {
               return error.response.status === 500;  // Retry on server errors only
           }
       });

       axios.get('https://api.example.com/dependency')
           .then(response => console.log(response.data))
           .catch(error => console.error('Request failed:', error));
       ```

   - **Exponential Backoff**:
     - Ensure that the retry includes an exponential backoff to minimize immediate retries and reduce the chance of overwhelming the dependency. This allows for short recovery periods between retry attempts.
     - Example:
       - Retry after 500ms, and if it fails again, give up (no further retries).

   - **Circuit Breaker Integration**:
     - Consider integrating a **circuit breaker** pattern to prevent repeated calls to a failing service. If multiple retry attempts fail, the circuit breaker will open, preventing additional calls until the service is healthy again.
     - Example using **Hystrix** (Java):
       ```java
       public class CommandDependencyCall extends HystrixCommand<String> {
           protected String run() throws Exception {
               // Make primary call
               return callDependency();
           }

           protected String getFallback() {
               return "Dependency is currently unavailable";
           }
       }
       ```

### 3. **Set Retry Conditions**
   - **Transient Failures**:
     - Define conditions under which a retry should be attempted. Typically, retries are triggered by transient failures such as:
       - **HTTP 5XX errors**: Server-side errors.
       - **Timeouts**: Call timed out due to network issues.
       - **Rate Limits (429)**: Too many requests (retry after a brief wait).

   - **Permanent Failures**:
     - Avoid retries on permanent failures such as:
       - **HTTP 4XX errors**: Client-side errors (e.g., invalid request parameters, authentication failures).
       - Example retry condition:
         ```javascript
         retryCondition: (error) => {
             return error.response && error.response.status >= 500;
         }
         ```

### 4. **Handle Failures After Retry Limit**
   - **Error Handling**:
     - After the 1 retry attempt has failed, handle the failure appropriately by:
       - Logging the error and retry attempts.
       - Returning a meaningful error message to the user or service.
       - Triggering fallback mechanisms if applicable (e.g., use cached data or a default response).
     - Example error handling:
       ```javascript
       axios.get('https://api.example.com/dependency')
           .then(response => console.log(response.data))
           .catch(error => {
               console.error('Final attempt failed:', error);
               // Return error or fallback response
           });
       ```

   - **Graceful Degradation**:
     - Implement graceful degradation strategies in case the dependency remains unavailable, such as serving cached data or sending a failure notification. This ensures minimal disruption to the user experience.
     - Example fallback:
       ```java
       protected String getFallback() {
           return "Dependency unavailable. Please try again later.";
       }
       ```

### 5. **Monitoring and Logging**
   - **Track Retry Attempts**:
     - Log retry attempts, including:
       - Number of retries.
       - Reason for retry (e.g., timeout, server error).
       - Time between retries (backoff applied).
     - Example logging:
       ```javascript
       axios.interceptors.response.use(null, (error) => {
           console.error(`Retry attempt failed for: ${error.config.url}`);
           return Promise.reject(error);
       });
       ```

   - **Alert on Excessive Retries**:
     - Set up alerts in monitoring systems (e.g., **CloudWatch**, **Datadog**) for excessive retry attempts or failures to ensure prompt response and diagnosis of issues.
     - Example CloudWatch Alarm:
       ```bash
       aws cloudwatch put-metric-alarm --alarm-name "RetryLimitExceeded" \
         --metric-name RetryAttemptsExceeded \
         --namespace Custom/Retries \
         --threshold 5 \
         --comparison-operator GreaterThanOrEqualToThreshold \
         --evaluation-periods 1 \
         --alarm-actions arn:aws:sns:us-east-1:123456789012:NotifyMe
       ```

### 6. **Test Retry Logic**
   - **Simulate Transient Failures**:
     - Test retry logic by simulating transient failures (e.g., timeout or HTTP 500 errors) to verify that the system retries once and handles subsequent failure correctly.
     - Example test:
       - Simulate an API returning HTTP 500 on the first call, and ensure that only 1 retry is attempted before failing.

   - **Test Permanent Failures**:
     - Simulate permanent failures (e.g., HTTP 400 errors) and verify that no retries are made and the error is immediately handled.

### Testing
- **Retry Testing**:
   - Simulate transient failures and verify that only 1 retry is attempted before handling the error. Ensure that no excessive retries are made, and proper backoff is applied.

- **Error Handling Testing**:
   - Test the error-handling mechanisms after the retry limit is reached. Ensure that meaningful error messages or fallback responses are returned to the user or downstream services.

### External Dependencies
- **API Gateway** or microservices for primary dependency calls.
- **Logging and monitoring tools** (e.g., CloudWatch, Datadog) for tracking retry attempts and failures.

## Acceptance Criteria
- Should limit retries to at most 1 for all primary dependency calls.
- Should implement exponential backoff for retries and avoid retrying permanent failures (e.g., HTTP 4XX).
- Should log retry attempts and trigger alerts if excessive retries occur.
- Should gracefully handle failures after retry attempts are exhausted.

### Gherkin
```gherkin
Given a service makes a call to a dependency
When the call fails due to a transient issue
Then the system should retry the call once
And log the retry attempt.
```
```gherkin
Given a service makes a call to a dependency
When the call fails with a permanent failure (e.g., HTTP 400)
Then no retries should be attempted
And the system should handle the failure immediately.
```
