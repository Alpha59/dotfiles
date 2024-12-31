## Expected Transactions Per Second (TPS) and Alarms for Service Load Management

### Purpose
This document defines the **expected Transactions Per Second (TPS)** for the team’s service, along with **alarms** to trigger when the service reaches 80% of its TPS limit, as determined by load tests. This ensures that the team can proactively manage the load on the service, avoiding bottlenecks and maintaining performance under peak conditions.

---

### 1. **Expected TPS for the Service**

#### **What is TPS?**
- **TPS (Transactions Per Second)** refers to the number of requests (or transactions) that a service can handle per second. It is a critical metric for evaluating the performance and scalability of the system.

#### **TPS Target**:
- Based on load tests, the team has determined that the service should be able to handle a peak load of **1000 TPS** under normal circumstances. This number is based on the results from performance and load testing, which simulate real-world usage patterns.

#### **TPS Breakdown**:
- **Peak TPS**: **1000 TPS**
  - This is the maximum number of transactions the service is expected to handle in a second during peak load.
- **Average TPS**: **750 TPS**
  - This is the typical number of transactions the service is expected to handle under normal load conditions.

#### **Load Test Validation**:
- During the load tests, the service successfully handled **1000 TPS** without performance degradation, and the response time remained under 2 seconds for 95% of the requests.
- Load testing was performed with various scenarios, including gradual increases in TPS to ensure that the system can scale dynamically.

---

### 2. **Alarm Configuration for TPS**

#### **Why Set Alarms for TPS?**
- **Proactive Monitoring**: Setting alarms when the TPS reaches 80% of the expected peak (800 TPS) allows the team to take action before hitting the maximum capacity, thus preventing degradation of service performance.
- **Capacity Planning**: Alarms help monitor whether the system is operating close to its maximum capacity, providing early warning to scale resources or optimize performance.
- **Operational Response**: With the TPS alarm in place, operational teams can respond by scaling infrastructure, optimizing code, or adding more resources as necessary.

#### **Alarm Criteria**:
1. **Threshold**: The alarm should be triggered when TPS reaches **80%** of the maximum expected TPS (i.e., **800 TPS**).
2. **Action**: When the alarm is triggered, it should prompt one of the following actions:
   - **Scaling**: Automatically scale the service using **Auto Scaling Groups** (for EC2) or scale the container services (e.g., ECS or EKS).
   - **Alerting**: Send an alert to the team via **SNS**, **Slack**, or **Email**.
   - **Investigation**: Manually investigate the root cause if scaling does not resolve the issue or if performance issues persist.

#### **CloudWatch Alarm Configuration**:
AWS CloudWatch can be used to monitor TPS. The following CloudWatch alarm configuration is an example of how to set an alarm for 80% of TPS (800 TPS):

```bash
aws cloudwatch put-metric-alarm \
    --alarm-name "ServiceTPSHigh" \
    --metric-name "TPS" \
    --namespace "AWS/Custom" \
    --statistic "Average" \
    --period 60 \
    --threshold 800 \
    --comparison-operator GreaterThanOrEqualToThreshold \
    --evaluation-periods 1 \
    --alarm-actions arn:aws:sns:us-east-1:123456789012:AlertTopic \
    --ok-actions arn:aws:sns:us-east-1:123456789012:AlertTopic \
    --dimensions Name=ServiceName,Value=MyService
```

#### **CloudWatch Metric**:
- **Metric Name**: `TPS`
- **Namespace**: `AWS/Custom`
- **Statistic**: `Average` TPS over the 60-second period
- **Threshold**: 800 TPS
- **Alarm Action**: Trigger notification to the team through **SNS** or other alerting mechanisms.

---

### 3. **Scaling and Performance Optimization**

#### **Scaling the Service**:
- **Auto Scaling**: Use AWS Auto Scaling to automatically scale EC2 instances or containerized services (e.g., ECS, EKS) when the service reaches 80% of its TPS capacity.
  - For example, configure Auto Scaling to add more EC2 instances or containers when the TPS exceeds 80% to handle the increased load.

#### **Elastic Load Balancing**:
- **Load Balancer Configuration**: Ensure that your **Elastic Load Balancer (ALB/NLB)** is set up to distribute traffic evenly across your instances or containers to handle the increased load efficiently.

#### **Performance Optimization**:
- **Caching**: Use **Amazon ElastiCache** or **CloudFront** to offload traffic from the backend services and reduce TPS load.
- **Database Optimization**: Implement **read replicas** or **database sharding** to distribute the database load and prevent database-related performance bottlenecks under high TPS.

---

### 4. **Test Results and Verification**

#### **Verification Plan**:
1. **Load Testing**: Periodically run load tests to simulate different TPS scenarios and ensure that the service performs as expected up to the peak TPS.
2. **Monitoring During Production**: Regularly monitor TPS in production using AWS CloudWatch or third-party monitoring tools to ensure that the system stays within acceptable performance limits.
3. **Automated Scaling Tests**: Simulate high TPS loads during testing to ensure that Auto Scaling and load balancing mechanisms work effectively in response to traffic spikes.

#### **Test Reporting**:
- **TPS Metrics**: Report TPS during load tests, including the peak TPS and any performance issues encountered (e.g., latency, failed requests).
- **Alarm and Action Logs**: Maintain logs of when TPS alarms were triggered, the corresponding actions taken, and any scaling events or interventions.
- **Performance Metrics**: Include response times, CPU utilization, and memory usage as part of the test results to assess overall system health during high TPS.

---

### 5. **Acceptance Criteria**

1. **TPS Thresholds**:
   - The service should be able to handle up to **1000 TPS** without performance degradation.
   - A CloudWatch alarm should be triggered when TPS reaches **80%** of the expected peak (**800 TPS**).

2. **Scaling Response**:
   - **Auto Scaling** should be automatically triggered when TPS reaches the threshold, ensuring the service can handle increased load without manual intervention.

3. **Alerting**:
   - Alerts should be sent to the appropriate team members when the TPS alarm is triggered, allowing the team to take action.

4. **Performance**:
   - The system should maintain acceptable response times and error rates when TPS is at or near the 80% threshold.

---

### Gherkin

**Feature**: Monitoring and Scaling for TPS
**Scenario**: Ensure the system handles high TPS and triggers appropriate alarms and scaling actions
- **Given** the system is configured to handle up to 1000 TPS,
- **When** TPS reaches 800 (80% of the expected maximum),
- **Then** an alarm should be triggered, the system should scale automatically, and an alert should be sent to the team.

By following these guidelines, the team can proactively monitor service performance and scale resources to ensure that the service handles increasing traffic without disruption, improving the system’s overall reliability and responsiveness.
