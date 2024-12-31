## Documentation and Alarms for Fallback Paths in Graceful Failure Scenarios

### Purpose
To document fallback paths for handling failures gracefully, ensuring that critical operations continue with minimal disruption. Additionally, to configure alarms to monitor the activation and performance of fallback mechanisms, providing visibility into potential issues.

---

### Definitions

#### 1. **Fallback Path**
- **Definition**: An alternative operational path or mechanism used when the primary system or service fails.
- **Purpose**: To maintain partial functionality or reduce customer impact during failure scenarios.

#### 2. **Graceful Failure**
- **Definition**: A failure mode where the system degrades in a controlled and predictable manner, minimizing disruptions to users.
- **Purpose**: To avoid catastrophic failures and ensure system stability.

---

### Fallback Path Documentation

#### 1. **Identification of Critical Fallback Paths**
| **Primary Functionality**   | **Fallback Path**                          | **Trigger Condition**                    | **Scope**                 |
|-----------------------------|--------------------------------------------|------------------------------------------|---------------------------|
| **Database Read/Write**     | Switch to read-only replica.              | Primary database unresponsive or slow.   | Query and reporting features only. |
| **External API Dependency** | Use cached data for API responses.         | Third-party API unavailable or timeout.  | Limited feature functionality. |
| **Service Communication**   | Use asynchronous retries.                 | Synchronous calls fail.                  | All dependent services.    |
| **Data Processing**         | Queue requests for later processing.      | Backend processing unavailable.          | Non-critical batch tasks. |

---

#### 2. **Fallback Path Workflow Example**

- **Primary Functionality**: External API Integration
- **Fallback Path**: Serve responses from a Redis cache.
- **Steps**:
  1. Detect third-party API failure using health check responses or timeouts.
  2. Route requests to cached responses stored in Redis.
  3. Log the fallback activation and notify on-call engineers.
  4. Monitor cache hits and refresh stale data when the API is restored.

---

### Monitoring and Alarms for Fallback Scenarios

#### 1. **Metrics to Monitor**
| **Metric Name**          | **Definition**                                   | **Target Threshold**             |
|---------------------------|-------------------------------------------------|-----------------------------------|
| **Fallback Activation Count** | Number of times a fallback path is triggered. | < 1 activation/hour (normal state). |
| **Fallback Response Latency** | Time taken to serve responses via fallback.   | < 200ms.                         |
| **Primary Recovery Latency**  | Time taken to return to primary functionality.| < 5 minutes.                     |

---

#### 2. **Alarm Configuration**

##### A. **Fallback Activation Alarms**
- **Trigger Condition**: Fallback path activated more than 3 times in 10 minutes.
- **Tools**: AWS CloudWatch, Datadog, or Prometheus.
- **Alarm Settings**:
  - Metric: Fallback Activation Count.
  - Threshold: Activation > 3.
  - Period: Evaluate every 1 minute.
- **Actions**:
  - Notify on-call engineers (PagerDuty, Slack).
  - Log the activation for postmortem analysis.

##### B. **Fallback Latency Alarms**
- **Trigger Condition**: Fallback response latency exceeds 200ms.
- **Tools**: Application Performance Monitoring (APM) tools (e.g., New Relic).
- **Alarm Settings**:
  - Metric: Fallback Response Latency.
  - Threshold: Latency > 200ms.
  - Period: Evaluate every 5 minutes.
- **Actions**:
  - Escalate to SRE team for performance tuning.
  - Create a critical incident if persistent.

##### C. **Primary Recovery Alarms**
- **Trigger Condition**: System remains on fallback path for longer than 10 minutes.
- **Tools**: Monitoring systems integrated with fallback detection.
- **Alarm Settings**:
  - Metric: Time on Fallback Path.
  - Threshold: Duration > 10 minutes.
  - Period: Evaluate every 1 minute.
- **Actions**:
  - Notify service owners and escalate to leadership if unresolved.

---

### Customer Impact of Fallback Path Activation

#### 1. **Database Fallback**
- **Impact**: Limited to read-only operations; write operations fail.
- **Customer Perspective**: Delayed data updates; inability to submit new data.

#### 2. **API Dependency Fallback**
- **Impact**: Responses may be stale; real-time functionality reduced.
- **Customer Perspective**: Inconsistent or outdated information.

#### 3. **Asynchronous Retry Fallback**
- **Impact**: Increased latency for dependent services.
- **Customer Perspective**: Delayed service interactions.

#### 4. **Queue Processing Fallback**
- **Impact**: Non-critical tasks delayed for processing.
- **Customer Perspective**: Minimal direct impact unless backlogs accumulate.

---

### Post-Failure Actions

#### 1. **Root Cause Analysis (RCA)**
- Document why the fallback path was activated.
- Identify areas for improving primary system resilience.

#### 2. **Recovery Verification**
- Test fallback deactivation and verify return to primary operations.
- Monitor metrics post-recovery to ensure stability.

#### 3. **Documentation Updates**
- Update runbooks and playbooks based on the incident.
- Add new failure modes and fallback strategies if applicable.

---

### Acceptance Criteria
- Should document all fallback paths with trigger conditions and workflows.
- Should configure alarms for fallback activation, latency, and primary recovery.
- Should document customer impact for fallback scenarios.
- Should include post-failure processes for RCA and system recovery.

---

### Gherkin

**Feature**: Monitoring Fallback Paths
**Scenario**: Activating fallback paths during system failures
- **Given** a failure in the primary functionality,
- **When** the fallback path is triggered,
- **Then** alarms should activate, and metrics should track fallback performance.

This documentation ensures proactive monitoring and management of fallback paths, enabling graceful failure handling and minimizing customer impact.
