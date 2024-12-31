### Summary
**As a** DevOps Engineer, **I want** to document alarm resolutions and denote which alarms should be removed from existing infrastructure **So That** we can ensure that only relevant, actionable alarms remain in place, reducing noise from outdated or redundant alarms, and improving our ability to respond effectively to critical incidents.

This story focuses on reviewing, documenting, and categorizing existing alarms in the system, identifying alarms that need to be updated or removed, and clarifying the resolution processes for each active alarm. By keeping the alarm system up to date and streamlined, we minimize false positives and ensure the on-call team can focus on resolving actual issues.

### Vision
By documenting alarm resolutions and removing unnecessary alarms, we reduce alert fatigue and ensure that every alarm serves a purpose. The documentation will include the steps required to resolve each alarm and a clear indication of which alarms are no longer needed. This will help the on-call team act quickly when alarms are triggered, ensuring system health and uptime.

### Background
Alarms are crucial for monitoring the health of services, but over time, as infrastructure changes and services evolve, some alarms can become outdated or irrelevant. Keeping outdated alarms active can lead to unnecessary alerts, increasing the chances of real issues being missed due to alert fatigue. Additionally, properly documented resolution steps for each alarm ensure that the on-call team can address incidents efficiently and effectively.

---

### Steps to Document Alarm Resolutions and Remove Unnecessary Alarms

#### 1. **Inventory All Existing Alarms**

Start by taking an inventory of all active alarms in the system. This can be done using AWS CloudWatch or similar monitoring tools (e.g., Datadog, Prometheus).

##### Step 1: List All Alarms in AWS CloudWatch

Use the following AWS CLI command to list all CloudWatch alarms:

```bash
aws cloudwatch describe-alarms
```

This will return a list of all alarms, including their names, associated services, and status.

##### Step 2: Identify Relevant Alarms by Service

Group the alarms by service or resource type (e.g., EC2, RDS, Lambda) to make it easier to identify which alarms are still relevant to active services.

---

#### 2. **Document Alarm Resolutions**

For each alarm that is still relevant, document the steps required to resolve the issue when the alarm is triggered. This will help the on-call team respond quickly and correctly during incidents.

##### Step 1: Identify the Purpose of the Alarm

Document the following details for each alarm:

- **Alarm Name**: The name of the alarm.
- **Service**: The service or resource the alarm is monitoring (e.g., EC2 instance, API Gateway, S3 bucket).
- **Metric**: The specific metric being monitored (e.g., CPU Utilization, Latency, Error Rate).
- **Threshold**: The value that triggers the alarm (e.g., CPU > 80%, 5xx Errors > 10/min).
- **Resolution Steps**: The specific steps that need to be taken to resolve the issue when the alarm is triggered.

##### Example Alarm Documentation

| Alarm Name        | Service    | Metric                | Threshold         | Resolution Steps                                                                 |
|-------------------|------------|-----------------------|-------------------|----------------------------------------------------------------------------------|
| HighCPUAlarm      | EC2        | CPU Utilization        | > 80% for 5 mins  | 1. Check running processes on the EC2 instance. 2. Optimize or restart services.  |
| HighLatencyAlarm  | API Gateway| Latency                | > 2 seconds       | 1. Check for API bottlenecks. 2. Scale up resources or review request patterns.   |
| DatabaseErrorRate | RDS        | Error Rate             | > 5% error rate   | 1. Check database logs for errors. 2. Investigate queries and resolve errors.     |

---

#### 3. **Review and Remove Unnecessary Alarms**

After documenting all alarms, review which alarms are outdated, redundant, or no longer relevant to the current infrastructure.

##### Step 1: Identify Alarms to Remove

Criteria for removing alarms include:

- **Obsolete Alarms**: Alarms that monitor services or resources that no longer exist (e.g., old EC2 instances, deprecated APIs).
- **Redundant Alarms**: Alarms that overlap with others or are covered by more general, higher-level alarms.
- **Low-Value Alarms**: Alarms that do not provide actionable insights or consistently generate false positives without adding value.

##### Step 2: Remove Unnecessary Alarms

For AWS CloudWatch alarms, use the following command to remove obsolete or redundant alarms:

```bash
aws cloudwatch delete-alarms --alarm-names <alarm-name-1> <alarm-name-2>
```

This will remove the specified alarms from the system. Be sure to document which alarms were removed and the reason for their removal.

##### Example of Alarms to Remove

| Alarm Name         | Reason for Removal                                                             |
|--------------------|--------------------------------------------------------------------------------|
| OldEC2HighCPUAlarm | Monitors an EC2 instance that was decommissioned.                              |
| LegacyAPILatency   | Overlaps with a more general latency alarm for the new API Gateway service.     |
| TestDBErrorRate    | Alarm for a test database that is no longer used.                              |

---

#### 4. **Update Alarm Thresholds and Conditions (Optional)**

In some cases, alarms may be relevant but need to be updated to reflect current performance standards or system scaling. Review the thresholds and conditions for each alarm to ensure they are still appropriate.

##### Step 1: Update Alarm Thresholds

For alarms that need updated thresholds, use the following command to modify the alarm:

```bash
aws cloudwatch put-metric-alarm --alarm-name <alarm-name> \
  --metric-name <metric> --namespace <service-namespace> \
  --statistic Average --period 60 --threshold <new-threshold> \
  --comparison-operator GreaterThanThreshold --evaluation-periods 1 \
  --alarm-actions <SNS-Topic-ARN>
```

Ensure that thresholds reflect realistic and actionable values based on current system performance.

---

#### 5. **Notify the Team of Alarm Changes**

Once the documentation is complete, notify the team of any alarm changes, including which alarms were removed and which alarms were updated. This ensures that all team members are aware of the changes and can adjust their monitoring practices accordingly.

---

### Acceptance Criteria
- Should inventory all active alarms in the system and categorize them by service or resource.
- Should document the resolution process for all relevant alarms, including steps for troubleshooting and resolving issues.
- Should identify and remove obsolete or redundant alarms from the system.
- Should update alarm thresholds and conditions where necessary to reflect current performance standards.
- Should notify the team of any alarm removals or updates to ensure everyone is aware of the changes.
