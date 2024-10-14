
# Configure critical alarms to treat missing data point breaches
Summary

As a DevOps Engineer, I want to configure critical alarms to treat missing datapoints as breaches, So That we can detect potential failures in monitoring systems or services even when data is missing, ensuring that problems do not go unnoticed and are escalated for resolution.

Vision

By treating missing datapoints as breaches, we ensure that any gaps in metric reporting trigger an alert. This helps avoid situations where a service failure might go undetected due to missing monitoring data. This approach strengthens the reliability of the system by ensuring that the absence of data is treated with the same urgency as an actual failure.

Background

Typically, alarms are set to trigger based on thresholds being breached for specific metrics (e.g., latency, error rate). However, if no data is being reported—due to network issues, service outages, or monitoring failures—this absence of data might mask underlying issues. By treating missing data as a breach, we ensure that these silent failures are caught and addressed promptly.

Steps to Configure Critical Alarms to Treat Missing Datapoints as Breaches

1. Identify Critical Metrics

Determine which metrics are vital to system health, such as:

	•	Latency
	•	Error Rates (4xx/5xx)
	•	Availability
	•	Resource Utilization
If these metrics stop reporting, it could indicate a system issue.

2. Configure CloudWatch Alarms with Missing Data Handling

AWS CloudWatch allows alarms to treat missing data as breaches. Use the --treat-missing-data breaching option to ensure that alarms trigger when no data is received.

Example for high latency:

aws cloudwatch put-metric-alarm --alarm-name 'HighLatencyAlarm'   --metric-name Latency --namespace AWS/ApiGateway   --statistic Average --period 60 --threshold 2000   --comparison-operator GreaterThanThreshold --evaluation-periods 1   --alarm-actions <SNS-Topic-ARN>   --treat-missing-data breaching   --dimensions Name=ApiName,Value=<api-name>

For error rates:

aws cloudwatch put-metric-alarm --alarm-name 'HighErrorRateAlarm'   --metric-name 5xxErrorRate --namespace AWS/ApiGateway   --statistic Sum --period 60 --threshold 10   --comparison-operator GreaterThanThreshold --evaluation-periods 1   --alarm-actions <SNS-Topic-ARN>   --treat-missing-data breaching   --dimensions Name=ApiName,Value=<api-name>

3. Test and Validate the Alarms

Simulate missing data by stopping metric reporting (e.g., stopping services temporarily) and confirm that the alarms trigger correctly.

Best Practices

	•	Use for Critical Services Only: Apply missing-data-as-breach configurations only to metrics for critical services.
	•	Monitor False Positives: Ensure alarms don’t trigger unnecessarily by balancing the sensitivity with realistic thresholds.
	•	Set Up Alerts: Ensure notifications are configured through services like SNS, PagerDuty, or Slack for quick response.

Acceptance Criteria

	•	Should configure alarms for critical metrics (latency, error rates, availability) to treat missing datapoints as breaches.
	•	Should validate alarms by simulating missing data scenarios.
	•	Should ensure notifications are sent to the appropriate teams for fast response when alarms are triggered.
