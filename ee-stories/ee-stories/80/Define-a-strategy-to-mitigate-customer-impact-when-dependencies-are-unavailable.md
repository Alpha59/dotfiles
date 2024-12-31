## Summary
**As a** cloud architect or DevOps engineer, **I want** to define a **strategy to mitigate customer impact when dependencies are unavailable**, **so that** the system can maintain partial functionality or gracefully degrade during outages, ensuring a better customer experience and minimizing disruptions.

In distributed systems, dependencies such as third-party APIs, databases, or internal services may become unavailable, leading to downtime or degraded performance. By implementing fallback strategies, redundancy, and appropriate monitoring, customer impact can be minimized, allowing the system to continue operating at a reduced capacity or providing informative error messages.

### Vision
By defining a strategy for mitigating customer impact during dependency failures, the team will ensure that services remain available and functional, even when critical dependencies are down. This will improve system resilience, provide better user experiences during outages, and reduce the risk of complete system failure.

### Background
Dependency failures are a common cause of service outages or degraded performance in complex systems. External services or internal microservices may fail due to network issues, server outages, or excessive load. Without a mitigation strategy, these failures can lead to a complete loss of functionality for customers. A robust mitigation strategy ensures that the system can handle such failures gracefully, avoiding downtime and reducing the impact on customers.

### Purpose
The purpose of this story is to define a strategy that ensures customer-facing systems can handle dependency failures, maintaining partial functionality or providing useful fallbacks to minimize customer impact.

## Strategy

### 1. **Implement Graceful Degradation**
   - **Graceful degradation** refers to the ability of a system to reduce functionality without completely failing when dependencies are unavailable. This ensures that customers still have access to core features, even if non-essential services are down.

   **Steps**:
   - Identify core vs. non-core functionalities in your system.
   - Implement logic that allows core features to continue operating even when some services or APIs are down.
   - Display appropriate messages to users when a feature is unavailable, rather than failing entirely.

   **Example**: If a payment service is down, allow users to browse products and add items to their cart but delay payment until the service is restored.

### 2. **Implement Circuit Breakers**
   - Use a **circuit breaker pattern** to automatically stop calling an external dependency after repeated failures. This prevents overloading the system and gives the dependency time to recover.

   **Steps**:
   - Integrate a circuit breaker into the system using libraries like **Hystrix** (Java), **resilience4j** (Java), or **Polly** (.NET).
   - Set thresholds for the number of failures before tripping the circuit breaker, and define recovery periods.

   **Example**: If an external API fails after 3 consecutive attempts, trip the circuit breaker to stop further requests for 5 minutes, after which it retries.

   **Circuit Breaker Example in Java (resilience4j)**:
   ```java
   CircuitBreakerConfig config = CircuitBreakerConfig.custom()
       .failureRateThreshold(50)
       .waitDurationInOpenState(Duration.ofMillis(10000))
       .build();

   CircuitBreaker circuitBreaker = CircuitBreaker.of("dependencyService", config);
   ```

### 3. **Provide Fallback Mechanisms**
   - When a dependency fails, provide **fallback mechanisms** to maintain partial functionality. Fallbacks can include:
     - Cached data
     - Default responses
     - Reduced functionality with degraded performance

   **Steps**:
   - Cache frequently accessed data to provide a response when a service is down.
   - Return default values for non-critical data points (e.g., displaying a “temporarily unavailable” message for specific features).

   **Example**: If a product inventory service is down, use cached inventory data to allow users to continue viewing products, even if the data is slightly outdated.

   **Fallback Example in Java (Hystrix)**:
   ```java
   public String getProductDetails() {
       return HystrixCommand.from(() -> externalService.getProduct())
           .fallback(() -> "Product details unavailable")
           .execute();
   }
   ```

### 4. **Use Redundancy and Failover**
   - Set up **redundancy** for critical services by deploying them across multiple regions or availability zones. Use **failover mechanisms** to switch traffic to the healthy instance when a failure occurs.

   **Steps**:
   - Use AWS services like **Route 53** or **Elastic Load Balancing** to configure automatic failover across multiple availability zones or regions.
   - Deploy critical services in **active-active** or **active-passive** configurations for redundancy.

   **Example**: Deploy a database cluster across two regions, and if the primary region fails, route traffic to the secondary region automatically.

   **Route 53 DNS Failover Example**:
   ```bash
   aws route53 change-resource-record-sets --hosted-zone-id ZONE_ID --change-batch '{
       "Changes": [{
           "Action": "CREATE",
           "ResourceRecordSet": {
               "Name": "app.example.com",
               "Type": "A",
               "Failover": "PRIMARY",
               "SetIdentifier": "Primary Server",
               "TTL": 60,
               "ResourceRecords": [{"Value": "1.2.3.4"}]
           }
       }, {
           "Action": "CREATE",
           "ResourceRecordSet": {
               "Name": "app.example.com",
               "Type": "A",
               "Failover": "SECONDARY",
               "SetIdentifier": "Secondary Server",
               "TTL": 60,
               "ResourceRecords": [{"Value": "5.6.7.8"}]
           }
       }]
   }'
   ```

### 5. **Monitor and Alert on Dependency Failures**
   - Set up **monitoring and alerting** to detect when dependencies fail and provide immediate feedback to the team.
   - Use tools like **AWS CloudWatch**, **Datadog**, or **Prometheus** to monitor latency, error rates, and connection timeouts from dependencies.

   **Steps**:
   - Monitor the health of dependencies using **CloudWatch** alarms, setting thresholds for response times and error rates.
   - Set up alerts via email, SMS, or Slack for immediate notification when a failure is detected.

   **Example CloudWatch Alarm for API Gateway Failure**:
   ```bash
   aws cloudwatch put-metric-alarm --alarm-name "High-5XX-Errors" \
     --metric-name "5XXError" --namespace "AWS/ApiGateway" \
     --statistic "Sum" --period 300 --threshold 5 \
     --comparison-operator GreaterThanThreshold --evaluation-periods 1 \
     --alarm-actions arn:aws:sns:region:account-id:MySNSTopic
   ```

### 6. **Implement Retry Mechanisms**
   - For transient failures, implement **exponential backoff retries** to avoid overwhelming the dependency with continuous requests.

   **Steps**:
   - Configure retries with exponential backoff and jitter to handle temporary outages.
   - Set a maximum retry count to avoid indefinite retry loops.

   **Example in Python (using Requests)**:
   ```python
   import requests
   from requests.adapters import HTTPAdapter
   from requests.packages.urllib3.util.retry import Retry

   s = requests.Session()
   retries = Retry(total=5, backoff_factor=1, status_forcelist=[500, 502, 503, 504])
   s.mount('https://', HTTPAdapter(max_retries=retries))
   response = s.get('https://example.com/api')
   ```

### 7. **Provide User Notifications**
   - When dependency failures impact the user experience, provide **clear communication** to users through status pages, in-app messages, or notifications.

   **Steps**:
   - Display messages within the app informing users of degraded service or outages.
   - Update the **service status page** with ongoing incidents and estimated resolution times.

   **Example**: Display a banner in the application stating, “Some features are temporarily unavailable due to an ongoing issue. We are working to resolve it.”

### 8. **Test and Validate the Mitigation Strategy**
   - Conduct **chaos engineering** tests (e.g., using **AWS Fault Injection Simulator** or **Gremlin**) to simulate dependency failures and validate that the mitigation strategy works as expected.
   - Test failover, circuit breakers, and fallback mechanisms under controlled conditions.

   **Steps**:
   - Simulate a service outage to verify that the system continues operating with reduced functionality.
   - Validate that customer-facing communications are accurate and helpful during outages.

   **Example Chaos Test Using AWS Fault Injection Simulator**:
   ```bash
   aws fis start-experiment --experiment-template-id template-12345
   ```

### Testing
- Simulate various dependency failures and verify that graceful degradation, circuit breakers, and fallback mechanisms are functioning as expected.
- Test failover mechanisms by taking down critical services and confirming that the system switches to backup instances.
- Ensure that monitoring tools detect failures and send alerts to the team promptly.

### Acceptance Criteria
- Should implement graceful degradation to maintain partial functionality when dependencies fail.
- Should configure circuit breakers to stop calling dependencies after repeated failures.
- Should provide fallback mechanisms such as cached data or default values.
- Should set up monitoring and alerting for dependency failures with appropriate notifications to the team.
- Should configure retry mechanisms with exponential backoff for transient failures.
- Should communicate dependency failures to users with clear notifications and status updates.
- Should conduct tests to validate the effectiveness of the mitigation strategy.

### External Links
- [AWS Fault Injection Simulator](https://aws.amazon.com/fis/)
- [Resilience4j Circuit Breaker Documentation](https://resilience4j.readme.io/docs/circuitbreaker)
- [AWS Route 53 DNS Failover](https://docs.aws

.amazon.com/Route53/latest/DeveloperGuide/dns-failover.html)
- [Chaos Engineering Principles](https://principlesofchaos.org/)
