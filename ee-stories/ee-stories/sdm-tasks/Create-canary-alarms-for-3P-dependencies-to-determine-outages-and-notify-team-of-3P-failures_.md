## Canary Alarms for Third-Party (3P) Dependencies

### Purpose
To implement canary alarms for monitoring the availability and performance of third-party (3P) dependencies. These alarms will identify outages or performance degradation and notify the team promptly, enabling swift incident response and mitigation.

---

### Canary Alarm Implementation

#### 1. **Overview**
- **Purpose of Canaries**: Simulate real user interactions with 3P dependencies to detect failures or slow responses before they significantly impact customers.
- **Key Metrics**:
  - Availability (success rate of canary tests).
  - Latency (response time from 3P dependency endpoints).
  - Error Rate (HTTP 4xx and 5xx responses).

---

### Steps to Configure Canary Alarms

#### 2. **Canary Design**
- **Frequency**: Run canary checks every 1 minute to balance real-time monitoring with cost and resource usage.
- **Endpoints**: Target critical 3P API endpoints or services required for core functionality.
- **Request Details**:
  - Simulate typical user requests (e.g., API calls with representative payloads).
  - Use valid authentication credentials and request headers.

#### 3. **Monitoring Metrics**
| **Metric**       | **Description**                          | **Threshold**       |
|-------------------|------------------------------------------|---------------------|
| **Availability**  | Percentage of successful canary requests | < 99.9% for 3 minutes |
| **Latency**       | Average response time in milliseconds    | > 300ms for p95 latency |
| **Error Rate**    | Percentage of 4xx/5xx responses          | > 1% for 3 minutes   |

---

### Alarm Configuration

#### 4. **Tools**
- **Monitoring Tools**: AWS CloudWatch, Datadog, or Prometheus.
- **Notification Channels**: Slack, PagerDuty, or email.

#### 5. **Alarm Rules**
| **Metric**       | **Condition**                                      | **Action**                           |
|-------------------|----------------------------------------------------|--------------------------------------|
| **Availability**  | Fewer than 99.9% successful responses for 3 minutes | Notify team with a warning alarm.    |
| **Latency**       | p95 latency exceeds 300ms for 3 minutes            | Trigger an alarm and notify team.    |
| **Error Rate**    | Error rate > 1% for 3 minutes                      | Escalate to SDM and log a Sev2 alarm.|

---

### Notifications

#### 6. **Alarm Message Template**
**Subject**: `[3P Dependency] Canary Alarm: [Metric Breach] on [Service Name]`

**Body**:
```
Incident ID: [ID]
Detected At: [Timestamp]
Dependency: [3P Service Name]

**Metric Breach**:
- Metric: [e.g., Latency]
- Current Value: [e.g., 350ms]
- Threshold: [e.g., 300ms]

**Impact**:
[Description of how this impacts the service.]

**Next Steps**:
- [Example: Investigate logs or reach out to 3P support.]

**Contact**:
[On-call POC or escalation contact]
```

---

### Implementation Example with AWS CloudWatch

#### 7. **Step 1: Create Canaries**
- Use **AWS CloudWatch Synthetics**:
  - **Script**: Write a custom Node.js or Python script to send requests to the 3P API and validate responses.
  - **Frequency**: Set canary frequency to 1 minute.

#### 8. **Step 2: Define Metrics**
- Track canary success, latency, and error rates:
  - **Success Metric**:
    ```json
    {
      "Namespace": "Custom/Canary",
      "MetricName": "Availability",
      "Dimensions": [{ "Name": "Endpoint", "Value": "[3P Endpoint]" }],
      "Value": [Success Rate]
    }
    ```
  - **Latency Metric**:
    ```json
    {
      "Namespace": "Custom/Canary",
      "MetricName": "Latency",
      "Dimensions": [{ "Name": "Endpoint", "Value": "[3P Endpoint]" }],
      "Value": [Response Time]
    }
    ```

#### 9. **Step 3: Configure Alarms**
- **Availability Alarm**:
  ```json
  {
    "AlarmName": "3P_Availability_Alarm",
    "MetricName": "Availability",
    "Namespace": "Custom/Canary",
    "Statistic": "Average",
    "ComparisonOperator": "LessThanThreshold",
    "Threshold": 99.9,
    "EvaluationPeriods": 3,
    "ActionsEnabled": true,
    "AlarmActions": ["Notify_Team"]
  }
  ```
- **Latency Alarm**:
  ```json
  {
    "AlarmName": "3P_Latency_Alarm",
    "MetricName": "Latency",
    "Namespace": "Custom/Canary",
    "Statistic": "p95",
    "ComparisonOperator": "GreaterThanThreshold",
    "Threshold": 300,
    "EvaluationPeriods": 3,
    "ActionsEnabled": true,
    "AlarmActions": ["Notify_Team"]
  }
  ```

---

### Maintenance and Testing

#### 10. **Regular Testing**
- Conduct quarterly validation of canary scripts to ensure they represent actual use cases.
- Simulate outages to confirm alarm triggers and notification workflows.

#### 11. **Periodic Review**
- Review metrics and thresholds monthly to align with updated service requirements.
- Update alarm rules and scripts as dependencies evolve.

---

### Acceptance Criteria
- Canary scripts should accurately simulate customer interactions with 3P dependencies.
- Alarms should trigger notifications for availability, latency, and error rate breaches within 3 minutes.
- Notifications should include actionable details for on-call teams.

---

### Gherkin

**Feature**: Canary Alarms for 3P Dependencies
**Scenario**: Monitoring availability and performance of 3P dependencies
- **Given** a 3P dependency is being monitored,
- **When** a canary metric breaches the threshold,
- **Then** the system should notify the team and escalate to SDM if required.

This implementation ensures real-time detection of 3P dependency issues, enabling faster response and minimized customer impact.
