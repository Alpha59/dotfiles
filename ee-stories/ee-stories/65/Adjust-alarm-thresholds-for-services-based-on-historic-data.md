## Summary
**As a** DevOps engineer or Site Reliability Engineer (SRE), **I want** to adjust alarm thresholds for services based on historic data, **so that** the monitoring system can better detect actual issues while minimizing false positives or missed alerts.

Alarm thresholds that are not tuned correctly can lead to excessive noise (too many false positives) or missed alerts (failing to detect real problems). By analyzing historical performance and usage data, thresholds can be adjusted to accurately reflect the system's normal and abnormal behavior, ensuring timely and actionable alerts.

### Vision
By adjusting alarm thresholds based on historic data, the monitoring system will be able to trigger alerts only when actual service degradation or issues are occurring. This will help the team focus on meaningful alerts, improve response time to critical incidents, and reduce alarm fatigue caused by excessive or unnecessary notifications.

### Background
Alarm thresholds are often set with a general idea of what constitutes a problem, but as systems evolve and usage patterns change, these thresholds may no longer be effective. Regular adjustments based on real-world data ensure that alarms are neither too sensitive nor too lenient. Using historical data allows for better accuracy in determining normal operating ranges and identifying potential issues.

### Purpose
The purpose of this story is to analyze historic data for key services, determine appropriate alarm thresholds, and update the monitoring system to reflect these new thresholds, ensuring that it accurately detects service issues without producing too many false positives.

## Details

### 1. **Identify Key Metrics to Monitor**

   - **Critical Service Metrics**:
     - Identify the most important metrics that need to be monitored for the service. These might include:
       - **CPU Utilization**: Percentage of CPU usage over time.
       - **Memory Usage**: Amount of memory being used by the service.
       - **Latency**: Average or percentile latency of service requests.
       - **Error Rates**: Rate of failed requests or error responses (e.g., HTTP 500 errors).
       - **Throughput**: Number of requests or transactions processed per second.
       - **Disk I/O**: Read/write operations on the disk.

   **Example Metrics**:
   - API latency (p95, p99)
   - Number of failed API requests
   - CPU usage per service
   - Memory usage and swap usage

### 2. **Analyze Historic Data**

   - **Collect Historical Data**:
     - Gather historical data for each metric using tools like **AWS CloudWatch**, **Datadog**, **Prometheus**, or other monitoring platforms. Ensure that the data spans enough time (e.g., the past 3 to 6 months) to capture typical and peak behaviors.
     - Export the historical data for the key metrics and analyze trends, spikes, and patterns.

   - **Analyze Trends**:
     - Look for trends in the data to understand normal operating ranges and identify when anomalies or spikes occur. You may find that certain metrics (e.g., CPU usage or latency) have recurring spikes at specific times (e.g., during peak traffic).

   - **Statistical Analysis**:
     - Calculate the **mean**, **standard deviation**, and **percentiles** (e.g., p95, p99) for each metric to understand the normal range and extreme values.
     - Example:
       - p95 CPU utilization: 70%
       - p99 API response time: 150ms
       - Average error rate: 0.05%

   - **Consider Anomalies**:
     - Review historical incidents or anomalies, such as service outages or performance degradations, to understand when current alarms may have triggered incorrectly or failed to trigger.

### 3. **Determine New Alarm Thresholds**

   - **Set Dynamic Thresholds**:
     - Use the historical data to determine appropriate thresholds for each metric. Aim for thresholds that trigger alerts only when the metric deviates significantly from its normal range.
     - For example:
       - Set the CPU utilization threshold at 85% if the p95 utilization is consistently below that level.
       - Set the API latency alarm to trigger when p99 latency exceeds 200ms, based on historical peaks during high load periods.

   - **Consider Multiple Alert Levels**:
     - Establish multiple alert levels for critical metrics (e.g., warning and critical) to allow for early detection of issues before they become critical.
     - Example:
       - **Warning**: CPU usage > 75% for 10 minutes.
       - **Critical**: CPU usage > 90% for 5 minutes.

   - **Adjust Based on Load Patterns**:
     - Adjust thresholds based on usage patterns (e.g., during peak traffic times) or expected spikes in load. Ensure that the system does not produce false alarms during known peak usage periods.

### 4. **Update Monitoring and Alarms**

   - **Configure New Alarms**:
     - Update your monitoring system (e.g., **AWS CloudWatch**, **Datadog**, **Prometheus**) with the new alarm thresholds. Use the calculated thresholds to configure alarms that trigger alerts when thresholds are breached.
     - Example for **AWS CloudWatch**:
       ```bash
       aws cloudwatch put-metric-alarm --alarm-name "HighCPUUtilization" \
         --metric-name CPUUtilization --namespace AWS/EC2 \
         --statistic Average --period 300 --threshold 85 \
         --comparison-operator GreaterThanOrEqualToThreshold --evaluation-periods 2 \
         --alarm-actions arn:aws:sns:us-east-1:123456789012:NotifyMe
       ```

   - **Deploy Alerting Mechanisms**:
     - Ensure that appropriate notification channels (e.g., email, Slack, PagerDuty) are configured to alert the right team members when an alarm is triggered.

   - **Test the New Thresholds**:
     - Simulate breaches to test the new alarm thresholds and ensure that the alarms trigger correctly and in a timely manner. Make sure that notifications are sent to the correct individuals or teams.

### 5. **Monitor and Fine-Tune Alarm Sensitivity**

   - **Monitor Alarm Performance**:
     - After deploying the new thresholds, monitor how often alarms are triggered and evaluate whether they are detecting real issues or producing false positives.

   - **Adjust Sensitivity**:
     - If the alarms are too sensitive (e.g., triggering too often), consider adjusting the thresholds higher or adding conditions (e.g., sustained high CPU for a certain period). If alarms are too lenient, consider lowering the thresholds.

### Testing

- **Historical Data Testing**:
   - Verify that the thresholds set for alarms are based on accurate historical data and that they reflect realistic usage patterns.

- **Alarm Testing**:
   - Test the newly set thresholds by triggering simulated breaches to ensure alarms behave as expected.

- **Notification Testing**:
   - Ensure that the alerting mechanisms (email, Slack, PagerDuty) notify the correct teams when an alarm is triggered.

### External Dependencies
- **Monitoring tools** (e.g., AWS CloudWatch, Datadog, Prometheus) for collecting historical data and setting alarms.
- **Notification tools** (e.g., Slack, PagerDuty, email) for sending alerts when thresholds are breached.

## Acceptance Criteria
- Should analyze historical data for key service metrics.
- Should adjust alarm thresholds based on the data to minimize false positives and ensure real issues are detected.
- Should update monitoring systems with the new thresholds and configure alerts accordingly.
- Should ensure the alarm and notification system is tested and working as expected.

### Gherkin
```gherkin
Given the historical data for service performance
When thresholds for critical metrics are analyzed
Then new thresholds should be set based on the data to ensure alarms are triggered appropriately.

Given the new alarm thresholds are deployed
When the system experiences a performance issue
Then the alarm should trigger only if the threshold is breached, and appropriate notifications should be sent to the team.
```
