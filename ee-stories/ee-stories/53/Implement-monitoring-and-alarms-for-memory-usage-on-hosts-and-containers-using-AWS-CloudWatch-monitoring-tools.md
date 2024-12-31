## Summary
**As a** cloud infrastructure engineer, **I want** to implement monitoring and alarms for memory usage on hosts and containers using AWS CloudWatch monitoring tools, **so that** I can proactively monitor resource utilization, detect memory-related performance issues, and ensure that systems remain healthy and scalable.

Monitoring memory usage on both hosts and containers is critical for ensuring optimal performance and stability of applications. By setting up detailed monitoring and alerts, we can track memory utilization trends, prevent resource exhaustion, and respond to potential performance bottlenecks before they lead to service disruptions.

### Vision
By implementing memory usage monitoring and alarms, we can ensure the system remains performant and that resources are adequately allocated to avoid service interruptions. AWS CloudWatch will allow us to track memory usage trends in real-time and trigger alarms when memory consumption exceeds critical thresholds, giving the team the ability to take corrective action quickly.

### Background
Currently, memory usage may not be actively monitored on all hosts and containers, leading to potential issues with resource exhaustion. Without real-time monitoring and alerts, memory leaks or excessive memory usage can go unnoticed, eventually causing performance degradation or system crashes. Implementing memory usage monitoring using AWS CloudWatch will improve visibility into system health and ensure that resource constraints are managed effectively.

### Purpose
The purpose of this story is to set up AWS CloudWatch monitoring for memory usage on both hosts (EC2 instances) and containers (running in ECS or EKS), configure alarms for high memory usage, and ensure the system remains stable under varying loads.

## Details

### 1. **Enable CloudWatch Monitoring for EC2 Instances**
   - **Install CloudWatch Agent**:
     - Install and configure the CloudWatch Agent on all EC2 instances to collect memory usage metrics, as memory metrics are not collected by default in CloudWatch for EC2 instances.
     - Use the following configurations in the CloudWatch Agent configuration file:
       ```json
       {
         "metrics": {
           "append_dimensions": {
             "AutoScalingGroupName": "${aws:AutoScalingGroupName}",
             "InstanceId": "${aws:InstanceId}"
           },
           "metrics_collected": {
             "mem": {
               "measurement": [
                 "mem_used_percent"
               ],
               "metrics_collection_interval": 60
             }
           }
         }
       }
       ```
     - This configuration collects memory usage metrics every 60 seconds and tracks the percentage of memory used on the instance.

   - **Send Memory Usage Metrics to CloudWatch**:
     - Configure the agent to send memory metrics (e.g., `mem_used_percent`) to CloudWatch for real-time monitoring and historical analysis.

### 2. **Enable CloudWatch Monitoring for Containers**
   - **For ECS**:
     - Enable CloudWatch Container Insights for Amazon ECS clusters to collect memory usage metrics for individual containers.
     - Ensure that memory metrics such as `MemoryUtilized` and `MemoryReserved` are available for each container.
     - The following ECS CloudWatch metrics should be monitored:
       - `MemoryUtilized`: The amount of memory being used by a container.
       - `MemoryReserved`: The amount of memory reserved for a container.

   - **For EKS**:
     - Enable CloudWatch Container Insights for Amazon EKS clusters to collect memory usage metrics for Kubernetes pods and containers.
     - Monitor memory metrics like `container_memory_working_set_bytes`, which reflects the memory used by a container without including memory caches.

### 3. **Set Up CloudWatch Alarms for Memory Usage**
   - **Define Alarm Thresholds**:
     - Set thresholds for high memory usage to trigger alarms. Example:
       - **Warning Alarm**: Trigger if memory usage exceeds 75% for more than 5 minutes.
       - **Critical Alarm**: Trigger if memory usage exceeds 90% for more than 3 minutes.
     - Thresholds can vary depending on the instance type and container workload.

   - **Create CloudWatch Alarms**:
     - For EC2 Instances:
       - Set up CloudWatch alarms to monitor the `mem_used_percent` metric. Example configuration:
         ```gherkin
         Given the memory usage exceeds 75% on an EC2 instance
         When the memory usage remains above 75% for 5 minutes
         Then trigger a warning alarm and notify the team.
         ```
     - For ECS Containers:
       - Create alarms for the `MemoryUtilized` metric in ECS clusters, ensuring each container has a monitoring policy based on its memory limits.
       - Example: Trigger an alarm if a container uses more than 85% of its allocated memory.

     - For EKS Containers:
       - Create alarms for `container_memory_working_set_bytes` or other Kubernetes memory metrics in EKS.

   - **Alarm Notifications**:
     - Configure notifications using AWS SNS to alert the team when memory usage exceeds defined thresholds.
     - Use Slack, email, or SMS notifications to ensure timely responses to memory issues.

### 4. **Visualize Memory Metrics in CloudWatch Dashboards**
   - Create CloudWatch dashboards to visualize memory usage trends across hosts and containers in real-time.
   - Add widgets that show memory usage across:
     - **EC2 instances**: Track `mem_used_percent` for all EC2 instances in the dashboard.
     - **ECS containers**: Display memory utilization for each service and task within ECS.
     - **EKS containers**: Visualize memory usage across Kubernetes pods and containers.
   - Include alarms on the dashboard for quick visibility into any memory-related incidents.

### 5. **Monitoring and Remediation**
   - **Monitoring**:
     - Set up continuous monitoring for memory usage trends to identify any patterns of high usage, potential memory leaks, or inefficient resource allocation.

   - **Automated Remediation**:
     - Consider implementing automated remediation actions using AWS Systems Manager to restart instances or containers if they reach critical memory usage thresholds.
     - Implement scaling policies to scale EC2 instances or containers when memory usage consistently reaches high thresholds.

### 6. **Documentation**
   - Document the setup for CloudWatch memory monitoring, including steps for installing the CloudWatch Agent, configuring ECS/EKS monitoring, and setting up alarms.
   - Provide guidelines for adjusting memory thresholds and alarms based on workload patterns.
   - Include instructions for adding new hosts or containers to the monitoring setup as the system scales.

### Testing
- **Test Alarm Thresholds**:
   - Simulate high memory usage by running memory-intensive tasks on EC2 instances or containers to ensure that alarms are triggered at the correct thresholds.

- **Test Notifications**:
   - Verify that alerts are sent via the configured notification channels (e.g., SNS, Slack) when memory usage exceeds the defined limits.

- **Monitor Dashboard Performance**:
   - Check that CloudWatch dashboards update memory metrics in real-time and provide clear visibility into resource usage.

### External Dependencies
- AWS CloudWatch Agent installed on all EC2 instances.
- AWS CloudWatch Container Insights enabled for ECS and EKS clusters.
- SNS setup for sending notifications to the team.

## Acceptance Criteria
- Should have memory usage monitoring enabled for all EC2 instances, ECS, and EKS containers using AWS CloudWatch.
- Should have CloudWatch alarms set up for high memory usage with defined thresholds and notification channels.
- Should have CloudWatch dashboards displaying real-time memory metrics for both hosts and containers.
- Should have automated remediation policies considered for scaling or restarting services when memory usage exceeds critical limits.

### Gherkin
```gherkin
Given an EC2 instance or container is running
When memory usage exceeds 75% for more than 5 minutes
Then CloudWatch should trigger a warning alarm
And notify the team via the configured notification channels.
```

## API
N/A

## External Links
- [AWS CloudWatch Agent Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Install-CloudWatch-Agent.html)
- [AWS ECS CloudWatch Monitoring](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html)
- [AWS EKS CloudWatch Container Insights](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContainerInsights.html)
