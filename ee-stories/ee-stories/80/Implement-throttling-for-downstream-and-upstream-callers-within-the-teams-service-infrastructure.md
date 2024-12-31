## Summary
**As a** DevOps engineer or software developer, **I want** to implement **throttling for both downstream and upstream callers** within the team's service infrastructure, **so that** we can prevent system overload, ensure fair resource allocation, and maintain the stability of the service under high traffic conditions.

Throttling controls the rate at which requests are processed by the service, reducing the risk of overwhelming downstream services or being overwhelmed by upstream services. Implementing throttling mechanisms ensures that the system remains resilient under heavy load, prioritizes critical traffic, and maintains a consistent level of performance.

### Vision
By implementing throttling for both downstream and upstream callers, the team will achieve better control over resource usage, protect services from traffic surges, and ensure a stable user experience. Throttling also helps in complying with SLAs by managing traffic more effectively and avoiding outages due to excessive load.

### Background
Throttling is a technique used to limit the number of requests or data transfer rates to or from a service. It prevents downstream services from being overwhelmed by excessive traffic and ensures that upstream services cannot flood the system with more requests than it can handle. Throttling mechanisms can include rate limiting, burst control, and request queuing, and they should be configured at various points in the service infrastructure.

### Purpose
The purpose of this story is to implement throttling mechanisms to control the rate of requests for both downstream services (services the team calls) and upstream callers (clients calling the team's service). This will improve system resilience, reduce the risk of downtime, and ensure service stability under varying traffic conditions.

## Details

### 1. **Define Throttling Requirements for Downstream and Upstream Callers**
   - **Downstream Throttling**: Limit the number of requests made by the service to downstream dependencies (e.g., databases, third-party APIs, microservices) to avoid overwhelming them.
   - **Upstream Throttling**: Limit the number of incoming requests from clients to the team's service to prevent overloading the system.

   **Example Throttling Parameters**:
   - **Rate Limit**: The maximum number of requests per second allowed.
   - **Burst Limit**: The maximum number of requests that can be processed in a short burst.
   - **Retry Behavior**: Define how requests should be retried if throttling limits are reached (e.g., exponential backoff).

### 2. **Implement Upstream Throttling**
   - Configure rate limiting on the service to control the number of incoming requests from upstream clients. This can be implemented using:
     - **API Gateway or Ingress Controllers**: Configure rate limiting at the entry point (e.g., AWS API Gateway, NGINX Ingress Controller).
     - **Service Code**: Implement throttling in the service code using middleware or filters.

   **Example Using AWS API Gateway**:
   - Set up **throttle settings** for the API to control the rate and burst limits for requests.
   ```bash
   aws apigateway update-stage \
     --rest-api-id <api-id> \
     --stage-name <stage-name> \
     --patch-operations op=replace,path=/methodSettings/*/*/throttling/rateLimit,value=100
   ```

   **Example Using NGINX Ingress Controller**:
   - Configure rate limiting in the Ingress resource:
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: my-service-ingress
     annotations:
       nginx.ingress.kubernetes.io/limit-rps: "10"
       nginx.ingress.kubernetes.io/limit-burst-multiplier: "3"
   ```

   **Middleware Implementation (Node.js Express)**:
   ```javascript
   const rateLimit = require("express-rate-limit");

   const limiter = rateLimit({
     windowMs: 60 * 1000, // 1 minute
     max: 100, // limit each IP to 100 requests per minute
     message: "Too many requests, please try again later."
   });

   app.use(limiter);
   ```

### 3. **Implement Downstream Throttling**
   - Use libraries or configuration settings to limit the rate of requests made to downstream services. This may involve:
     - **Rate-limiting middleware** in the service.
     - **Client SDK configurations** to limit the number of outgoing requests.
     - **Circuit breakers and retries** with backoff strategies to handle failures.

   **Example Using a Circuit Breaker Pattern (Resilience4j in Java)**:
   - Configure rate limiting and circuit breaker thresholds:
   ```java
   RateLimiterConfig config = RateLimiterConfig.custom()
       .timeoutDuration(Duration.ofMillis(500))
       .limitRefreshPeriod(Duration.ofSeconds(1))
       .limitForPeriod(10)
       .build();
   RateLimiter rateLimiter = RateLimiter.of("myRateLimiter", config);

   Supplier<String> decoratedSupplier = RateLimiter.decorateSupplier(rateLimiter, () -> {
       // Call downstream service
       return "response from downstream service";
   });
   ```

   **Using AWS SDK Client Configurations**:
   - Limit outgoing requests to an AWS service (e.g., DynamoDB or S3).
   ```javascript
   const AWS = require('aws-sdk');
   const dynamoDb = new AWS.DynamoDB.DocumentClient({
     maxRetries: 3,
     httpOptions: {
       timeout: 5000
     }
   });
   ```

### 4. **Monitor and Adjust Throttling Limits**
   - Use monitoring tools such as **CloudWatch**, **Prometheus**, or **Datadog** to track request rates, error rates, and latency.
   - Adjust the throttling limits based on the monitoring data to optimize performance without causing unnecessary throttling.

   **Example CloudWatch Alarms for Monitoring Throttling**:
   ```bash
   aws cloudwatch put-metric-alarm \
     --alarm-name "High-Request-Throttle-Rate" \
     --metric-name "ThrottledRequests" \
     --namespace "AWS/ApiGateway" \
     --statistic "Sum" \
     --period 300 \
     --threshold 100 \
     --comparison-operator "GreaterThanThreshold" \
     --evaluation-periods 1 \
     --alarm-actions arn:aws:sns:region:account-id:alert-topic
   ```

### 5. **Configure Retry Logic for Throttled Requests**
   - Implement **exponential backoff** and **jitter** for retrying throttled requests, both for upstream and downstream calls.
   - Avoid overloading the system by carefully managing the retry interval.

   **Example Exponential Backoff with Jitter (Python)**:
   ```python
   import time
   import random

   def exponential_backoff_with_jitter(base_delay, max_delay, attempt):
       delay = min(base_delay * (2 ** attempt), max_delay)
       jitter = random.uniform(0, delay * 0.1)
       return delay + jitter

   for attempt in range(5):
       try:
           # Call downstream service
           pass
       except Exception as e:
           delay = exponential_backoff_with_jitter(1, 60, attempt)
           time.sleep(delay)
   ```

### 6. **Update the Runbook with Throttling Guidelines**
   - Document the implemented throttling configuration, including rate and burst limits for both upstream and downstream callers.
   - Provide troubleshooting steps for adjusting limits and handling common throttling-related issues.
   - Include guidelines for configuring retries and monitoring metrics.

   **Runbook Sections to Include**:
   - **Throttling Configuration Overview**: Describe the rate limits and burst settings for different services.
   - **Adjusting Throttling Limits**: Instructions for changing the configuration based on traffic patterns.
   - **Monitoring and Alerts**: How to monitor for throttling events and set up alarms.
   - **Retry Logic and Circuit Breakers**: Guidelines on implementing retries for both incoming and outgoing requests.

### Testing
- Test upstream throttling by simulating high traffic and verifying that requests exceeding the limit receive the appropriate response (e.g., `429 Too Many Requests`).
- Test downstream throttling by generating high volumes of requests to a downstream service and ensuring that rate limits prevent overload.
- Monitor throttling-related metrics and adjust configurations as needed based on test results.

### Acceptance Criteria
- Should implement rate and burst limits for both upstream (incoming) and downstream (outgoing) traffic.
- Should configure retry logic with exponential backoff for throttled requests.
- Should monitor throttling metrics and set up alerts for significant throttling events.
- Should update the runbook with configuration details and troubleshooting steps for managing throttling.
- Should test the throttling configuration to ensure proper functioning and adjust limits based on test results.

### External Links
- [AWS API Gateway Throttling](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-request-throttling.html)
- [Rate Limiting in NGINX](https://www.nginx.com/blog/rate-limiting-nginx/)
- [Resilience4j Documentation](https://resilience4j.readme.io/docs)
- [Circuit Breaker Pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/circuit-breaker/)
