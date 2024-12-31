## Plan for Ensuring Customer-Impacting Alarms Trigger a Sev2 Alarm

### Purpose
To ensure that all customer-impacting alarms automatically trigger a Sev2 incident within 5 minutes of detecting customer impact. This guarantees prompt awareness and resolution of issues affecting customer experience.

---

### Implementation Steps

#### 1. **Identify Customer-Impacting Alarms**
- **Definition**: Alarms that indicate degraded or unavailable service components directly affecting customers.
- **Common Metrics**:
  - **Service Availability**:
    - Overall service uptime.
    - Dependency availability.
  - **Latency**:
    - API response times (p95, p99).
  - **Error Rates**:
    - Percentage of failed requests (4xx, 5xx HTTP codes).
  - **Resource Utilization**:
    - CPU, memory, and disk limits causing service interruptions.

---

#### 2. **Configure Alarms**
- **Tools**: AWS CloudWatch, Datadog, Prometheus, or similar monitoring systems.
- **Thresholds and Conditions**:
  - **Availability**:
    - Trigger when service availability drops below **99.9%** for 2 consecutive minutes.
  - **Latency**:
    - Trigger when **p95 latency** exceeds **300ms** or **p99 latency** exceeds **500ms** for 3 consecutive minutes.
  - **Error Rates**:
    - Trigger when error rate exceeds **0.5%** for 3 consecutive minutes.
  - **Resource Limits**:
    - Trigger when resource usage exceeds defined thresholds (e.g., CPU > 90%).

---

#### 3. **Integrate with Incident Management**
- **Incident System**: Use PagerDuty, Opsgenie, or Jira Service Management for Sev2 incident tracking.
- **Configuration**:
  - Create a mapping between alarms and incident creation rules.
  - Set alarm actions to trigger Sev2 incidents in the incident management system.
- **Notification Path**:
  - Notify on-call engineers within 1 minute of alarm detection.
  - Escalate if unresolved within 5 minutes.

---

#### 4. **Define Alarm Actions**
- **Immediate Action**:
  - Send notification to on-call engineers via email, Slack, or PagerDuty.
  - Log the alarm in the monitoring system.
- **Incident Creation**:
  - Automatically generate a Sev2 incident with:
    - **Incident Title**: Include the application and impacted component.
    - **Description**: Provide alarm details, including triggered metric, threshold, and duration.
    - **Recommended Actions**: Include links to relevant dashboards and runbooks.

---

### Example Alarm Setup

#### A. **AWS CloudWatch Alarm for API Latency**
- **Metric**: API Gateway Latency (p95).
- **Condition**: Latency > 300ms for 3 consecutive minutes.
- **Alarm Action**:
  - Trigger an SNS topic connected to PagerDuty.
  - Create a Sev2 incident with title: `[APIService] Latency p95 Exceeded`.

#### B. **Datadog Alarm for Dependency Availability**
- **Metric**: Dependency uptime percentage.
- **Condition**: Availability < 99.9% for 2 minutes.
- **Alarm Action**:
  - Notify Slack channel for on-call engineers.
  - Automatically open a Sev2 incident in Jira Service Management.

---

### Validation and Testing
- Simulate customer-impacting scenarios (e.g., latency spikes, dependency failures).
- Verify:
  - Alarm triggers within specified thresholds.
  - Incident is created in the incident management system within 5 minutes.
  - Notifications reach on-call engineers promptly.
- Conduct regular drills to ensure response readiness.

---

### Maintenance and Review
- **Quarterly Audits**:
  - Review customer-impacting alarms for completeness and accuracy.
  - Adjust thresholds based on evolving SLAs and system behavior.
- **Incident Reviews**:
  - Analyze Sev2 incidents to identify gaps or false positives.
  - Refine alarm configurations and documentation accordingly.

---

### Acceptance Criteria
- All customer-impacting alarms should trigger a Sev2 incident within 5 minutes.
- Alarm notifications should include application name, impacted metric, and actionable recommendations.
- Alarm actions should integrate seamlessly with incident management systems.
- Simulated tests should validate the end-to-end process.

---

### Gherkin

**Feature**: Customer-Impacting Alarm Escalation
**Scenario**: Trigger Sev2 for customer-impacting issues
- **Given** a customer-impacting event,
- **When** an alarm detects the issue,
- **Then** a Sev2 incident should be created within 5 minutes, and on-call engineers notified.

This implementation ensures rapid detection and response to customer-impacting issues, minimizing downtime and preserving customer satisfaction.
