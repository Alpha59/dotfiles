## Adding Alarm Thresholds to Dashboard Graphs

### Purpose
To enhance the operational dashboards by adding visual indicators for alarm thresholds directly to the graphs. This provides a clear, real-time representation of when metrics approach or breach defined thresholds, ensuring quicker response and better context for on-call engineers.

---

### Implementation Plan

#### 1. **Identify Relevant Metrics and Thresholds**
- Determine the key metrics to display on the dashboard, such as:
  - CPU usage.
  - RAM usage.
  - Disk space usage.
  - Latency.
  - Error rate.
  - Throughput.
- Define thresholds for each metric:
  - Warning and critical thresholds.

| **Metric**       | **Threshold Type** | **Threshold Value** | **Purpose**                  |
|-------------------|--------------------|---------------------|------------------------------|
| CPU Usage         | Warning            | 75%                 | Indicates high utilization.  |
|                   | Critical           | 90%                 | Signals potential overload.  |
| RAM Usage         | Warning            | 75%                 | Indicates high usage.        |
|                   | Critical           | 90%                 | Signals risk of memory issues.|
| Disk Space Usage  | Warning            | 80%                 | Approaching capacity limit.  |
|                   | Critical           | 95%                 | Critical risk of no space.   |
| Latency (p95)     | Warning            | 300ms               | Acceptable but higher latency.|
|                   | Critical           | 500ms               | Poor performance.            |
| Error Rate        | Warning            | 0.3%                | Increased errors detected.   |
|                   | Critical           | 0.5%                | Unacceptable error rate.     |

---

#### 2. **Dashboard Updates**

##### A. **Graph Configuration**
1. **Tool Selection**:
   - Use monitoring tools like Grafana, AWS CloudWatch, Datadog, or similar.
2. **Overlay Threshold Lines**:
   - Add horizontal lines on graphs to represent thresholds.
   - Use color coding:
     - **Yellow** for warning thresholds.
     - **Red** for critical thresholds.
3. **Dynamic Annotations**:
   - Annotate graphs to show threshold values and their significance (e.g., “Warning: 75%”).
4. **Real-Time Indicators**:
   - Highlight graph points that exceed thresholds with a different marker style (e.g., dots or shapes in threshold colors).

##### B. **Customization per Metric**
1. **CPU Usage**:
   - Overlay lines for 75% and 90% usage.
   - Include rolling averages to smooth spikes.
2. **RAM Usage**:
   - Add a line for swap memory usage to correlate with RAM thresholds.
3. **Disk Space Usage**:
   - Use gradient shading to indicate usage zones (e.g., green to red).
4. **Latency and Error Rates**:
   - Display individual service latency with thresholds specific to each service.

---

#### 3. **Alerts and Annotations**
- **Real-Time Alerts**:
  - Integrate alerts with annotations on graphs to show when thresholds were breached.
  - Include timestamps for when the breach occurred.
- **Event Logs**:
  - Link alarms to detailed logs or incidents, accessible from the graph.

---

### Example Graph Enhancements

#### A. **CPU Usage Graph**
- **Axes**:
  - X-axis: Time.
  - Y-axis: CPU utilization (%).
- **Threshold Lines**:
  - Yellow line at 75%.
  - Red line at 90%.
- **Annotations**:
  - Mark spikes exceeding thresholds with alerts (e.g., “CPU critical: 92% at 10:15 AM”).

#### B. **Disk Space Usage Graph**
- **Axes**:
  - X-axis: Time.
  - Y-axis: Disk usage (%).
- **Threshold Lines**:
  - Yellow line at 80%.
  - Red line at 95%.
- **Additional Features**:
  - Include tooltip for exact usage values when hovering over the graph.

#### C. **Latency Graph**
- **Axes**:
  - X-axis: Time.
  - Y-axis: Latency (ms).
- **Threshold Lines**:
  - Yellow line at 300ms.
  - Red line at 500ms.
- **Annotations**:
  - Highlight periods where latency exceeds thresholds.

---

### Maintenance Plan
- **Quarterly Review**:
  - Validate thresholds against SLA changes or evolving system performance.
- **Feedback Collection**:
  - Gather input from engineers on the clarity and usefulness of the visualizations.
- **Automated Updates**:
  - Use configuration scripts (e.g., Terraform or Grafana API) to dynamically adjust thresholds.

---

### Acceptance Criteria
- Should add alarm thresholds as visually distinct lines on all relevant dashboard graphs.
- Should use clear color coding to differentiate warning and critical thresholds.
- Should annotate graphs with alerts and timestamps for breaches.
- Should ensure graphs are dynamically updated with real-time data.

---

### Gherkin

**Feature**: Alarm Thresholds on Dashboard Graphs
**Scenario**: Display alarm thresholds for resource usage metrics
- **Given** a monitoring dashboard,
- **When** thresholds are added to graphs,
- **Then** users should see clear visual indicators for warning and critical thresholds.

This enhancement ensures proactive monitoring and improves the team's ability to detect and respond to resource usage issues.
