## Defining a "Healthy Service" Alarm with Engineering Excellence Score

### Purpose
To create a composite "Healthy Service" alarm that aggregates multiple underlying metrics into an engineering excellence score. This score provides a holistic view of the service’s health and allows for proactive monitoring and issue detection.

---

### Metrics to Aggregate
#### 1. **Availability**
- **Metric**: Service uptime percentage.
- **Weight**: 30%.
- **Threshold**: ≥ 99.9%.

#### 2. **Latency**
- **Metric**: p95 and p99 API response times.
- **Weight**: 25%.
- **Thresholds**:
  - p95 Latency ≤ 300ms.
  - p99 Latency ≤ 500ms.

#### 3. **Error Rate**
- **Metric**: Percentage of requests resulting in errors (4xx, 5xx HTTP codes).
- **Weight**: 20%.
- **Threshold**: ≤ 0.5%.

#### 4. **Resource Utilization**
- **Metrics**:
  - CPU usage percentage.
  - RAM usage percentage.
  - Disk space usage percentage.
- **Weight**: 15%.
- **Thresholds**:
  - CPU ≤ 90%.
  - RAM ≤ 85%.
  - Disk ≤ 80%.

#### 5. **Dependency Health**
- **Metric**: Dependency uptime and latency.
- **Weight**: 10%.
- **Thresholds**:
  - Dependency uptime ≥ 99.9%.
  - Dependency latency (p95) ≤ 300ms.

---

### Engineering Excellence Score Formula
\[ \text{Score} = \sum \left( \text{Metric Weight} \times \text{Metric Health Value} \right) \]

- **Metric Health Value**: A normalized value (0 to 1) calculated as:
  - 1 if the metric meets or exceeds the threshold.
  - 0 if the metric fails to meet the threshold.
  - Linear interpolation for partial compliance (e.g., latency at 400ms results in \( \text{Health Value} = 0.5 \)).

---

### Alarm Definition

#### 1. **Healthy Service Alarm**
- **Trigger Condition**: Engineering Excellence Score drops below **0.85** (85%).
- **Evaluation Period**: 5 consecutive minutes.
- **Severity**: Sev2 for score < 0.85; Sev1 for score < 0.70.

---

### Implementation Steps

#### 1. **Metric Collection**
- **Tooling**: Use AWS CloudWatch, Prometheus, or Datadog.
- **Metrics**:
  - Service uptime (availability metrics).
  - API response latency (AWS API Gateway, APM tools).
  - Error rates (logs and API gateway metrics).
  - Resource utilization (cloud provider metrics or system agents).
  - Dependency health (ping checks or custom monitors).

#### 2. **Aggregation Logic**
- **Approach**:
  - Create a composite metric using a script or monitoring platform with custom calculations (e.g., AWS CloudWatch Metric Math, Prometheus recording rules).
  - Normalize individual metrics to a [0, 1] scale based on thresholds.
  - Compute the weighted sum as the engineering excellence score.

#### 3. **Alarm Configuration**
- **Platform**: Configure alarms in the monitoring tool.
- **Conditions**:
  - Score < 0.85: Trigger a warning alarm.
  - Score < 0.70: Trigger a critical alarm.
- **Notification**:
  - Notify on-call engineers via Slack, PagerDuty, or email.
  - Include a breakdown of metric contributions and failed thresholds.

#### 4. **Visualization**
- **Dashboard Components**:
  - **Engineering Excellence Score**:
    - Single stat widget showing current score.
    - Color-coded thresholds (green ≥ 0.85, yellow ≥ 0.70, red < 0.70).
  - **Underlying Metrics**:
    - Line charts for latency, error rate, and resource utilization.
    - Pie chart showing metric weight contributions to the score.

---

### Example Calculation
| **Metric**          | **Weight** | **Threshold**       | **Value** | **Health Value** | **Weighted Contribution** |
|----------------------|------------|---------------------|-----------|------------------|---------------------------|
| Availability         | 30%        | ≥ 99.9%            | 99.8%     | 0.8              | 0.24                      |
| p95 Latency          | 15%        | ≤ 300ms            | 250ms     | 1.0              | 0.15                      |
| p99 Latency          | 10%        | ≤ 500ms            | 600ms     | 0.5              | 0.05                      |
| Error Rate           | 20%        | ≤ 0.5%             | 0.7%      | 0.3              | 0.06                      |
| CPU Usage            | 10%        | ≤ 90%              | 85%       | 1.0              | 0.10                      |
| Dependency Uptime    | 15%        | ≥ 99.9%            | 99.95%    | 1.0              | 0.15                      |
| **Total Score**      | **100%**   |                     |           |                  | **0.75**                  |

Result: Alarm triggers due to score < 0.85.

---

### Testing and Validation
- Simulate scenarios (e.g., high latency, resource limits exceeded).
- Verify:
  - Alarms trigger when the score breaches thresholds.
  - Notifications include actionable breakdowns.
- Review the score formula and weights quarterly to ensure relevance.

---

### Maintenance and Review
- **Quarterly Reviews**:
  - Reassess metric weights and thresholds based on service evolution.
- **Feedback Loop**:
  - Collect feedback from on-call engineers and stakeholders.

---

### Acceptance Criteria
- Should aggregate metrics into a composite score reflecting service health.
- Should trigger alarms when the score falls below defined thresholds.
- Should provide actionable details in notifications.
- Should validate the system in both test and production environments.

---

### Gherkin

**Feature**: Healthy Service Alarm
**Scenario**: Aggregate metrics into a composite health score
- **Given** multiple service metrics,
- **When** the engineering excellence score is calculated,
- **Then** alarms should trigger if the score falls below 0.85, with actionable details.

This approach provides a comprehensive view of service health and enables proactive monitoring aligned with engineering excellence.
