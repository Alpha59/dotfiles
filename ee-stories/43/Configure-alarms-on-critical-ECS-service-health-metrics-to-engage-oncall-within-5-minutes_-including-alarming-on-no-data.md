
# Configure alarms on critical ECS service health metrics to engage oncall within 5 minutes, including alarming on no data
### Summary
**As a** DevOps Engineer, **I want** to configure alarms on critical ECS service health metrics to engage on-call within 5 minutes, including alarming on no data, **So That** the on-call team is notified promptly of potential issues, including when there is a loss of data reporting from monitoring systems.

This story focuses on setting up AWS CloudWatch alarms for key ECS service health metrics, ensuring that the on-call team is notified immediately when thresholds are breached or when monitoring data is not being reported (indicative of potential service or monitoring failures). This allows for quick detection and response to ECS service health issues, minimizing downtime.

### Vision
By configuring these alarms, we ensure that the on-call team is notified within 5 minutes of any critical issues affecting ECS services, such as service failures, resource exhaustion, or loss of monitoring data. This proactive monitoring reduces the time it takes to detect and resolve incidents, improving system reliability.

### Background
 ECS (Elastic Container Service) allows you to run containerized applications at scale. Monitoring critical ECS metrics, such as CPU and memory utilization, task health, and network availability, is crucial for ensuring the health and performance of the services. Additionally, alarming on no data ensures that if the monitoring system itself fails, on-call teams are made aware of the potential issue.

---

### Steps to Configure Alarms for ECS Service Health

#### 1. **Identify Critical ECS Service Health Metrics**

To effectively monitor ECS services, we will set up alarms on the following key metrics:

- **CPUUtilization**: Measures the percentage of CPU used by ECS tasks. Alarming on high CPU usage ensures that tasks have enough compute resources to operate.
- **MemoryUtilization**: Measures the percentage of memory used by ECS tasks. High memory utilization could lead to tasks being terminated.
- **Task Count**: The number of running or desired tasks. Alarms can be set to detect when fewer tasks are running than desired.
- **Task Failures**: Alarms for failed ECS tasks to detect tasks that stop unexpectedly.
- **No Data**: Alarming when metrics like CPU or memory are not reporting, which could indicate issues with the ECS service or the monitoring system itself.

---

#### 2. **Configure CloudWatch Alarms for ECS Service Metrics**

##### Step 1: Create a CloudWatch Alarm for **CPUUtilization**

An alarm on CPU utilization ensures that the ECS service has enough processing power and alerts the on-call team if CPU usage exceeds a defined threshold.

```bash
aws cloudwatch put-metric-alarm --alarm-name 'ECS-HighCPU'   --metric-name CPUUtilization --namespace AWS/ECS   --statistic Average --period 300 --threshold 80   --comparison-operator GreaterThanThreshold   --evaluation-periods 1 --alarm-actions <SNS-Topic-ARN>   --dimensions Name=ClusterName,Value=<cluster-name> Name=ServiceName,Value=<service-name>
```

- **Threshold**: This alarm will trigger when CPU utilization exceeds 80% for a sustained period of 5 minutes (300 seconds).
- **Alarm Actions**: The on-call team will be notified through an SNS topic that sends alerts to PagerDuty, OpsGenie, or email/SMS.

##### Step 2: Create a CloudWatch Alarm for **MemoryUtilization**

Similar to CPU alarms, you need to monitor memory usage to ensure tasks are not running out of memory.

```bash
aws cloudwatch put-metric-alarm --alarm-name 'ECS-HighMemory'   --metric-name MemoryUtilization --namespace AWS/ECS   --statistic Average --period 300 --threshold 80   --comparison-operator GreaterThanThreshold   --evaluation-periods 1 --alarm-actions <SNS-Topic-ARN>   --dimensions Name=ClusterName,Value=<cluster-name> Name=ServiceName,Value=<service-name>
```

- **Threshold**: This alarm will trigger when memory utilization exceeds 80% for a sustained period of 5 minutes.

##### Step 3: Create a CloudWatch Alarm for **Running Task Count**

Alarming on the running task count ensures that all desired tasks are running. If the number of running tasks is lower than expected, this indicates a problem.

```bash
aws cloudwatch put-metric-alarm --alarm-name 'ECS-TaskCount'   --metric-name RunningTaskCount --namespace AWS/ECS   --statistic Minimum --period 300 --threshold 1   --comparison-operator LessThanThreshold   --evaluation-periods 1 --alarm-actions <SNS-Topic-ARN>   --dimensions Name=ClusterName,Value=<cluster-name> Name=ServiceName,Value=<service-name>
```

- **Threshold**: This alarm will trigger if fewer than 1 task is running for the ECS service, indicating a potential failure or scaling issue.

##### Step 4: Create a CloudWatch Alarm for **Task Failures**

An alarm on task failures alerts the on-call team if tasks stop unexpectedly.

```bash
aws cloudwatch put-metric-alarm --alarm-name 'ECS-TaskFailures'   --metric-name TaskFailureCount --namespace AWS/ECS   --statistic Sum --period 300 --threshold 1   --comparison-operator GreaterThanThreshold   --evaluation-periods 1 --alarm-actions <SNS-Topic-ARN>   --dimensions Name=ClusterName,Value=<cluster-name> Name=ServiceName,Value=<service-name>
```

- **Threshold**: This alarm will trigger if any tasks have failed within the last 5 minutes.

---

#### 3. **Configure Alarms for No Data**

To ensure that the on-call team is notified when monitoring data is missing (which could indicate a failure in the ECS service or the monitoring system), we will configure alarms for **no data**. This can be done by setting the `treat-missing-data` parameter.

##### Step 1: Alarm on Missing **CPUUtilization** Data

```bash
aws cloudwatch put-metric-alarm --alarm-name 'ECS-NoCPUData'   --metric-name CPUUtilization --namespace AWS/ECS   --statistic Average --period 300 --threshold 1   --comparison-operator GreaterThanThreshold   --evaluation-periods 1 --treat-missing-data missing   --alarm-actions <SNS-Topic-ARN>   --dimensions Name=ClusterName,Value=<cluster-name> Name=ServiceName,Value=<service-name>
```

- **treat-missing-data**: This option ensures that if no data is received for this metric, the alarm will trigger, notifying the on-call team that there may be a monitoring or service issue.

##### Step 2: Alarm on Missing **MemoryUtilization** Data

```bash
aws cloudwatch put-metric-alarm --alarm-name 'ECS-NoMemoryData'   --metric-name MemoryUtilization --namespace AWS/ECS   --statistic Average --period 300 --threshold 1   --comparison-operator GreaterThanThreshold   --evaluation-periods 1 --treat-missing-data missing   --alarm-actions <SNS-Topic-ARN>   --dimensions Name=ClusterName,Value=<cluster-name> Name=ServiceName,Value=<service-name>
```

- This will alarm if there is no memory utilization data reported within a 5-minute window.

##### Step 3: Alarm on Missing **RunningTaskCount** Data

```bash
aws cloudwatch put-metric-alarm --alarm-name 'ECS-NoTaskCountData'   --metric-name RunningTaskCount --namespace AWS/ECS   --statistic Minimum --period 300 --threshold 1   --comparison-operator LessThanThreshold   --evaluation-periods 1 --treat-missing-data missing   --alarm-actions <SNS-Topic-ARN>   --dimensions Name=ClusterName,Value=<cluster-name> Name=ServiceName,Value=<service-name>
```

- This ensures that if no task count data is reported, the on-call team is notified immediately.

---

#### 4. **Set Up SNS Topic and Alarm Actions**

You will need an **SNS (Simple Notification Service)** topic to send notifications to the on-call team. Ensure that the SNS topic is configured to send alerts to your on-call management system (PagerDuty, OpsGenie, email, or SMS).

##### Step 1: Create an SNS Topic

```bash
aws sns create-topic --name OnCallAlerts
```

##### Step 2: Subscribe On-Call Team to SNS Topic

```bash
aws sns subscribe --topic-arn <SNS-Topic-ARN> --protocol email --notification-endpoint oncall@example.com
```

You can use PagerDuty or OpsGenie integration to handle alerts and ensure they are escalated appropriately.

---

### 5. **Testing and Validation**

#### Step 1: Simulate Alarm Conditions

- **CPU Utilization**: Run a CPU-heavy task in ECS to simulate high CPU utilization and verify that the alarm is triggered.
- **Memory Utilization**: Simulate high memory usage by running memory-intensive tasks.
- **No Data**: Temporarily disable data reporting (e.g., by stopping tasks) to simulate 'no data' conditions and verify that the on-call team is notified.

#### Step 2: Check Alarm Trigger and On-Call Notifications

Ensure that the alarms are triggered within the expected 5-minute window and that the on-call team receives notifications via the configured SNS topic. Verify that escalation processes (e.g., through PagerDuty or OpsGenie) work as expected.

---

### Acceptance Criteria
- Should have CloudWatch alarms configured for critical ECS metrics (CPU, memory, task count, task failures) with appropriate thresholds.
- Should alarm within 5 minutes when thresholds are breached or when monitoring data is not available.
- Should have an SNS topic that notifies the on-call team through email, SMS, or an alerting system like PagerDuty.
- Should have tested and validated that alarms trigger correctly and notifications reach the on-call team promptly.
- Should ensure the system notifies the on-call team of both critical service failures and monitoring issues (no data).
