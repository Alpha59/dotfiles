
# Document steps to debug AWS ECS service using AWS ECS CLI
### Summary
**As a** DevOps Engineer, **I want** to document the steps to debug an AWS ECS service using the AWS ECS CLI, **So That** teams can troubleshoot and resolve issues efficiently, ensuring minimal downtime and optimized service performance.

This runbook provides a clear guide on how to use the AWS ECS CLI to troubleshoot and debug issues with an ECS service, including reviewing service status, inspecting task logs, and interacting with containers directly.

### Vision
By documenting the debugging steps using the AWS ECS CLI, we provide teams with a streamlined process to diagnose and resolve issues with ECS services. This helps in quickly identifying and addressing problems, reducing the time needed to restore normal operations.

### Background
AWS Elastic Container Service (ECS) is a container orchestration service that allows you to run and manage Docker containers at scale. When issues arise in ECS services, the AWS ECS CLI is a powerful tool that allows developers to interact with ECS clusters, tasks, and containers directly for troubleshooting and debugging.

---

### Prerequisites
- **AWS CLI Installed**: Ensure that the AWS CLI is installed and configured with the necessary credentials and permissions.
  - [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- **AWS ECS CLI Installed**: Install the AWS ECS CLI, which provides additional functionality specific to ECS services.
  ```bash
  sudo curl -Lo /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
  sudo chmod +x /usr/local/bin/ecs-cli
  ```
  - [AWS ECS CLI Documentation](https://docs.aws.amazon.com/

- **IAM Permissions**: Ensure that your AWS IAM role or user has the necessary permissions to access ECS services, clusters, and tasks.

---

### Steps to Debug an ECS Service Using AWS ECS CLI

#### 1. **Identify the ECS Cluster and Service**

The first step is to identify the ECS cluster and service you want to debug. You can list all ECS clusters and services within a specific cluster using the AWS CLI.

```bash
# List ECS clusters
aws ecs list-clusters

# List services in a specific cluster
aws ecs list-services --cluster <cluster-name>
```

Identify the service that is experiencing issues and note down its **service name** and **cluster name**.

---

#### 2. **Check the Status of the ECS Service**

Use the ECS CLI to check the current status of the service, including task counts, desired counts, and health status.

```bash
# Describe the ECS service
aws ecs describe-services --cluster <cluster-name> --services <service-name>
```

This command will return details such as:
- **Running count**: Number of running tasks.
- **Desired count**: Number of tasks the service is configured to run.
- **Service health**: Information on the health of the service.

If there’s a mismatch between the running count and desired count, or if the health check is failing, this may indicate issues with the tasks or containers.

---

#### 3. **Inspect ECS Tasks**

List the tasks running for the service to check if any tasks have stopped or failed.

```bash
# List tasks for the ECS service
aws ecs list-tasks --cluster <cluster-name> --service-name <service-name>
```

If tasks have stopped, use the following command to get more details about why the tasks were stopped:

```bash
# Describe the stopped ECS task
aws ecs describe-tasks --cluster <cluster-name> --tasks <task-id>
```

In the output, check for:
- **StoppedReason**: Reason why the task stopped or failed.
- **LastStatus**: The status of the task (e.g., `STOPPED`, `PENDING`, `RUNNING`).

---

#### 4. **View Logs from ECS Tasks (CloudWatch Logs)**

If CloudWatch Logs are enabled for the ECS tasks, you can review logs for individual containers. This is useful to debug application-level issues such as errors or crashes within the container.

First, identify the log group associated with your ECS task. This can be configured in the ECS task definition.

```bash
# Check the ECS task definition for CloudWatch log configuration
aws ecs describe-task-definition --task-definition <task-definition-name>
```

The task definition will show the log group in the `logConfiguration` section. You can now retrieve logs using the AWS CLI or view them in the CloudWatch console.

```bash
# View logs for a specific ECS task
aws logs get-log-events --log-group-name <log-group-name> --log-stream-name <log-stream-name>
```

---

#### 5. **Interact with a Running Container**

If further debugging is required, you can use the ECS CLI to interact directly with a running container. This allows you to view logs, environment variables, or even execute commands within the container.

First, list the containers running in a specific task:

```bash
# List containers in a task
aws ecs describe-tasks --cluster <cluster-name> --tasks <task-id>
```

To execute a command inside the running container, use the ECS **Execute Command** feature:

```bash
# Run a command inside the ECS container
aws ecs execute-command     --cluster <cluster-name>     --task <task-id>     --container <container-name>     --interactive     --command '/bin/bash'
```

This will open an interactive shell session within the container, allowing you to run diagnostic commands such as checking log files or system resources.

---

#### 6. **Inspect the ECS Task Definition**

Review the ECS task definition for misconfigurations or outdated settings. The task definition includes details like the container image, environment variables, CPU/memory limits, and network configuration.

```bash
# Describe the ECS task definition
aws ecs describe-task-definition --task-definition <task-definition-name>
```

Pay special attention to:
- **Container image**: Ensure that the correct container image version is being used.
- **Resource limits**: Check if the task has sufficient CPU and memory allocated.
- **Environment variables**: Verify that all required environment variables are set correctly.

If changes are needed, update the task definition and deploy a new revision of the ECS service.

---

#### 7. **Check ECS Service Events**

Service events provide insights into what is happening with the service, such as tasks failing to start, scaling events, or task stopping reasons.

```bash
# Describe ECS service events
aws ecs describe-services --cluster <cluster-name> --services <service-name>
```

Look for recent service events that may indicate issues such as failed deployments, unhealthy tasks, or scaling issues.

---

#### 8. **Redeploy the ECS Service**

If the issue seems to be related to the ECS service or task definition, you can trigger a redeployment of the service.

```bash
# Update service to trigger a new deployment
aws ecs update-service --cluster <cluster-name> --service <service-name> --force-new-deployment
```

This command forces the ECS service to deploy a new set of tasks using the latest task definition, which can resolve issues with failed tasks or container misconfigurations.

---

#### 9. **Scaling and Resource Issues**

If the service is under-provisioned or over-provisioned, you may need to adjust the desired count of tasks or modify the task definition to increase CPU and memory allocations.

```bash
# Update ECS service to change the desired count
aws ecs update-service --cluster <cluster-name> --service <service-name> --desired-count <new-count>
```

To update resource limits (e.g., CPU, memory) or modify other configurations in the task definition, create a new revision of the task definition and redeploy the service.

---

### Common Issues and Troubleshooting

- **Task Failing to Start**: Check the task definition for misconfigurations and use CloudWatch logs for detailed error messages.
- **Container Crashing**: Review the container logs for errors and ensure the container image is correct and properly configured.
- **Service Not Scaling**: Verify that the ECS service is properly configured with scaling policies and that there are no resource constraints (CPU, memory).
- **Permission Issues**: Ensure the task execution role and any IAM roles associated with the ECS task have the correct permissions to access required AWS services.

---

### Supporting Documentation and Links

- **AWS ECS CLI Documentation**: [AWS ECS CLI User Guide](https://docs.aws.amazon.com/
- **AWS CloudWatch Logs**: [AWS CloudWatch Logs Documentation](https://docs.aws.amazon.com/
- **AWS ECS Task Definitions**: [AWS ECS Task Definition Documentation](https://docs.aws.amazon.com/
- **Troubleshooting AWS ECS**: [AWS ECS Troubleshooting Guide](https://docs.aws.amazon.com/

---

### Acceptance Criteria
- Should be able to use the AWS ECS CLI to inspect service and task status.
- Should be able to retrieve and analyze logs from CloudWatch.
- Should be able to interact directly with running containers using the AWS CLI.
- Should be able to redeploy the ECS service and update task definitions if needed.
- Should have verified and documented steps for troubleshooting common ECS issues.
