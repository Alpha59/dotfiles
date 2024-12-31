## Summary
**As a** DevOps engineer or service owner, **I want** to implement support for degraded modes in the service/feature, **so that** the system can maintain partial functionality during partial failures, ensuring that core operations can continue while non-essential features or degraded operations handle failures gracefully.

Implementing degraded modes ensures that when certain dependencies fail, the system doesn't experience complete downtime. Instead, critical operations continue, and users are informed of the limited functionality. This approach improves the system’s resilience and maintains the user experience, even during partial outages.

### Vision
By supporting degraded modes, the system will continue offering essential functionality during dependency failures or performance degradation. This allows users to perform critical tasks even when non-critical features are temporarily unavailable. This strategy enhances service availability and user satisfaction by preventing full system outages.

### Background
In distributed systems, external services, APIs, or internal components can sometimes fail, causing parts of the system to become unavailable. Instead of the entire service going offline during such failures, degraded modes allow the system to fallback to reduced functionality. By implementing this strategy, we ensure critical features remain operational while alerting users to the limitations in non-critical areas.

### Purpose
The purpose of this story is to implement support for degraded modes in the service, enabling the application to continue functioning with reduced features when partial failures occur. This includes handling failures of external services, slow responses, or internal subsystem failures.

## Details

### 1. **Identify Critical and Non-Critical Features**

   - **List Core Features**:
     Identify the essential features or services that must remain operational even during a partial failure. These are the features that should be prioritized when the system is in a degraded state.

   - **List Non-Essential Features**:
     Identify features that are non-essential or can operate with limited functionality during partial outages. These features should degrade gracefully without impacting the overall user experience.

   **Example**:
   - **Core Features**:
     - User authentication
     - Payment processing
     - Product purchases
   - **Non-Critical Features**:
     - User notifications
     - Recommendation engine
     - Background analytics

### 2. **Define Degraded Modes for Key Scenarios**

   **Step 1**: **Service Unavailability**
   - Define the degraded behavior when an external service (e.g., third-party APIs, database) becomes unavailable. For example:
     - If the recommendation engine is down, the service should still display products without recommendations.
     - If analytics collection is unavailable, the core features should still function without data collection.

   **Step 2**: **Performance Degradation**
   - Define behavior when services are available but experience performance issues, such as increased latency:
     - If the user notification system is slow, allow critical notifications to take precedence, and queue non-essential notifications for later processing.

   **Step 3**: **Partial Data Availability**
   - Define what happens when only part of the required data is available:
     - If a product catalog service only partially responds, display available products and inform users that some content is temporarily unavailable.

   **Examples of Degraded Modes**:
   - **Recommendation Engine Failure**: Show products but hide recommendations.
   - **Payment Gateway Slow Response**: Retry payment processing in the background and notify users of a delay.
   - **Analytics Failure**: Disable analytics tracking but continue user operations.

### 3. **Implement Fallback Logic**

   **Step 1**: **Introduce Circuit Breakers and Fallbacks**
   - Implement the **circuit breaker pattern** to detect failures in external services or components. When a failure is detected, the system will stop sending requests to the failing service and trigger degraded mode.
   - Implement fallback logic for each service, where an alternate behavior is used if a service is unavailable.

   **Example Circuit Breaker Implementation** (using **resilience4j** for Java):
   ```java
   CircuitBreakerConfig config = CircuitBreakerConfig.custom()
     .failureRateThreshold(50)
     .waitDurationInOpenState(Duration.ofMillis(10000))
     .build();

   CircuitBreaker circuitBreaker = CircuitBreaker.of("recommendationService", config);

   Supplier<String> fallbackSupplier = () -> "Fallback recommendations";

   String recommendations = circuitBreaker.executeSupplier(fallbackSupplier);
   ```

   **Step 2**: **Handle Timeouts and Retries**
   - Implement retry logic with timeouts for services that are slow to respond. If a service continues to fail after retries, switch to degraded mode.

   **Example (Node.js Axios)**:
   ```javascript
   const axios = require('axios');

   async function fetchRecommendations() {
     try {
       const response = await axios.get('https://api.example.com/recommendations', { timeout: 5000 });
       return response.data;
     } catch (error) {
       console.log("Service unavailable, switching to fallback");
       return getFallbackRecommendations();
     }
   }
   ```

### 4. **Implement User Notifications for Degraded Modes**

   **Step 1**: **Inform Users**
   - When the system is in a degraded mode, notify users that some features are temporarily unavailable or degraded. This ensures transparency and sets expectations.

   **Example UI Message**:
   - “Some features are currently unavailable. You can continue using the core service, but recommendations are temporarily disabled.”

   **Step 2**: **Graceful Degradation in the UI**
   - Update the UI to hide or display alternate content when certain services are in a degraded mode. Ensure that critical features remain accessible.

   **Example**:
   - If the recommendation engine fails, display: “Recommendations are currently unavailable.”

### 5. **Test Degraded Mode Scenarios**

   **Step 1**: **Simulate Failures**
   - Use failure injection or chaos engineering tools (e.g., **Gremlin**, **Chaos Monkey**, **AWS Fault Injection Simulator**) to simulate the failure of external dependencies. Test the system’s ability to switch to degraded mode.

   **Step 2**: **Test User Experience**
   - Test the user experience in the UI when the system is in a degraded mode. Ensure users are appropriately informed of limitations while core features remain functional.

   **Step 3**: **Monitor System Logs and Metrics**
   - Monitor logs and metrics to ensure the fallback and circuit breaker mechanisms are functioning correctly during failures. Use tools like **CloudWatch**, **Datadog**, or **Prometheus** to track system performance and failure handling.

### 6. **Document and Review Degraded Mode Implementation**

   **Step 1**: **Document Degraded Mode Behavior**
   - Document the expected behavior for each service or feature in a degraded mode. Include the fallback logic, the impact on user experience, and how long the system will remain in degraded mode before attempting recovery.

   **Step 2**: **Review with Stakeholders**
   - Review the degraded mode plan with stakeholders to ensure that the fallback mechanisms and user notifications align with business requirements.

### Testing

- **Degraded Mode Testing**:
   - Simulate failures in key dependencies and verify that the system correctly switches to degraded mode, continuing to provide essential services while non-critical functionality is reduced or disabled.

- **User Notification Testing**:
   - Ensure that users receive appropriate notifications when features are unavailable or degraded.

- **Performance Testing**:
   - Monitor the system’s performance during degraded mode to ensure that critical functionality remains responsive.

### External Dependencies
- **Chaos engineering tools** (e.g., Gremlin, Chaos Monkey) to simulate failures.
- **Monitoring tools** (e.g., CloudWatch, Datadog, Prometheus) to track system performance and failures.

## Acceptance Criteria
- Should implement degraded mode support for all critical and non-critical services.
- Should ensure that core functionality remains operational during partial failures.
- Should display appropriate fallback content and user notifications when services are degraded.
- Should test degraded modes with simulated failures to ensure proper functionality and recovery.

### Gherkin
```gherkin
Given an external dependency fails
When the system detects the failure
Then the system should switch to degraded mode, providing partial functionality with fallback logic.

Given the system is in degraded mode
When a user accesses a non-critical feature
Then the user should receive a notification about the reduced functionality.

Given a service recovers from failure
When the system retries the connection
Then the system should restore full functionality from degraded mode.
```
