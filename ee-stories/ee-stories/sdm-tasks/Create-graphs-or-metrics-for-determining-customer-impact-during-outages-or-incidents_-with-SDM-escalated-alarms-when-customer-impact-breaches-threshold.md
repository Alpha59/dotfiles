## Metrics and Graphs for Determining Customer Impact During Outages or Incidents

### Purpose
To provide actionable metrics and visualizations for assessing customer impact during outages or incidents, ensuring timely escalations when predefined thresholds are breached. This enhances incident management and ensures rapid response and communication.

---

### Metrics to Monitor Customer Impact

#### 1. **Active User Impact**
- **Definition**: The percentage or number of active users unable to access or use the service.
- **Calculation**:
  \[
  \text{User Impact (\%)} = \frac{\text{Impacted Users}}{\text{Total Active Users}} \times 100
  \]
- **Thresholds**:
  - Warning: ≥ 5% impacted users.
  - Critical: ≥ 10% impacted users.

#### 2. **Error Rate**
- **Definition**: Percentage of requests resulting in errors (4xx, 5xx HTTP codes).
- **Calculation**:
  \[
  \text{Error Rate (\%)} = \frac{\text{Failed Requests}}{\text{Total Requests}} \times 100
  \]
- **Thresholds**:
  - Warning: ≥ 0.5%.
  - Critical: ≥ 1%.

#### 3. **Latency Impact**
- **Definition**: Percentage of requests with latency exceeding service-level agreements (SLAs).
- **Calculation**:
  \[
  \text{Latency Breach (\%)} = \frac{\text{Requests Above SLA}}{\text{Total Requests}} \times 100
  \]
- **Thresholds**:
  - Warning: ≥ 10% of requests above SLA.
  - Critical: ≥ 20% of requests above SLA.

#### 4. **Transaction Impact**
- **Definition**: Number of critical transactions (e.g., payments, API calls) failing during the incident.
- **Thresholds**:
  - Warning: ≥ 100 failed transactions in 5 minutes.
  - Critical: ≥ 500 failed transactions in 5 minutes.

#### 5. **Customer Feedback**
- **Definition**: Spike in support tickets or complaints during the incident.
- **Thresholds**:
  - Warning: ≥ 50 tickets in 15 minutes.
  - Critical: ≥ 100 tickets in 15 minutes.

---

### Dashboard Graphs and Visualizations

#### 1. **Active User Impact Graph**
- **Visualization**: Line chart showing:
  - Total active users.
  - Impacted users over time.
- **Annotations**: Add threshold lines for 5% and 10% impact.

#### 2. **Error Rate Graph**
- **Visualization**: Bar chart showing:
  - Error rates broken down by HTTP status codes (4xx, 5xx).
  - Total requests for context.
- **Annotations**: Threshold markers at 0.5% and 1%.

#### 3. **Latency Impact Graph**
- **Visualization**: Heatmap displaying:
  - Latency distributions by percentile (p50, p95, p99).
- **Annotations**: Highlight requests exceeding SLAs.

#### 4. **Transaction Impact Graph**
- **Visualization**: Line chart showing failed transactions over time.
- **Annotations**: Threshold lines at 100 and 500 failed transactions.

#### 5. **Customer Feedback Graph**
- **Visualization**: Stacked bar chart displaying:
  - Number of support tickets received by category (e.g., login issues, API failures).
- **Annotations**: Threshold markers at 50 and 100 tickets.

---

### Alarm Configuration for SDM Escalation

#### 1. **Metrics to Monitor**
| **Metric**           | **Threshold (Warning)** | **Threshold (Critical)** | **Action**                          |
|-----------------------|--------------------------|---------------------------|--------------------------------------|
| Active User Impact    | ≥ 5%                    | ≥ 10%                    | Notify SDM and on-call engineers.   |
| Error Rate            | ≥ 0.5%                  | ≥ 1%                     | Escalate to SDM for mitigation.     |
| Latency Impact        | ≥ 10%                   | ≥ 20%                    | Trigger SDM-aligned Sev2 alarm.     |
| Transaction Impact    | ≥ 100 in 5 minutes      | ≥ 500 in 5 minutes       | Escalate to SDM for critical response. |
| Customer Feedback     | ≥ 50 tickets in 15 min  | ≥ 100 tickets in 15 min  | Alert SDM for external communication. |

#### 2. **Alarm Settings**
- **Platform**: Use AWS CloudWatch, Datadog, or Prometheus.
- **Actions**:
  - Send alerts to SDM via PagerDuty or Slack.
  - Generate incidents in the incident management system (e.g., Jira).
- **Message Template**:
  - **Subject**: `[ServiceName] Critical Customer Impact Detected`
  - **Body**:
    ```
    **Metric Breached**: [Metric Name]
    **Value**: [Current Value]
    **Threshold**: [Threshold Value]
    **Time**: [Timestamp]
    **Recommended Action**: Review incident dashboard and join incident call.
    [Link to Dashboard] | [Link to Runbook]
    ```

---

### Maintenance and Testing

#### 1. **Monthly Reviews**
- Review thresholds and adjust based on customer expectations and SLA changes.
- Validate metrics for relevance and accuracy.

#### 2. **Simulated Incidents**
- Conduct quarterly incident drills to test alarm triggers, escalations, and response workflows.

---

### Acceptance Criteria
- Dashboard graphs should display customer impact metrics with clear thresholds.
- Alarms should trigger escalations to SDMs within 5 minutes of breaching thresholds.
- Notifications should include actionable insights and links to dashboards and runbooks.

---

### Gherkin

**Feature**: Customer Impact Metrics and SDM Escalation
**Scenario**: Escalating alarms for customer-impacting incidents
- **Given** customer-impacting metrics are monitored,
- **When** a metric breaches predefined thresholds,
- **Then** an alarm should trigger an SDM escalation within 5 minutes.

This system ensures timely escalation and actionable insights for incidents, minimizing customer impact and improving response efficiency.
