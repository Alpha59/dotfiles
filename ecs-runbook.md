cdk-template
============
- Category: runbook
- Tags:
- Created: 2023-09-28T12:10:44-04:00

# Runbook for [Your Software Service] on AWS ECS

## Introduction

This runbook provides a comprehensive guide to managing and maintaining [Your Software Service], a containerized application deployed on AWS Elastic Container Service (ECS) using AWS CDK. It covers various aspects of the service's lifecycle, including deployment, monitoring, testing, and local development. This document assumes familiarity with AWS services and CDK.

### Architecture Overview

[Your Software Service] is deployed within an AWS Virtual Private Cloud (VPC) and utilizes AWS Fargate for container orchestration. The service includes networking components, load balancing, logging, IAM roles, and more to ensure a secure, scalable, and maintainable deployment.

## Viewing CloudWatch Information
   - **Objective**: Monitor service health and performance using CloudWatch metrics and logs.

To search CloudWatch Logs using the AWS CLI, you can use the `aws logs filter-log-events` command. Here's a basic command to search for log events:

```bash
aws logs filter-log-events --log-group-name <LogGroupName> --start-time <StartTime> --end-time <EndTime> --filter-pattern <FilterPattern>
```

Replace the placeholders with the following values:

- `<LogGroupName>`: The name of the CloudWatch Logs log group you want to search within.
- `<StartTime>`: The start time for the log event search in Unix timestamp format (e.g., `1632864000` for October 1, 2021).
- `<EndTime>`: The end time for the log event search in Unix timestamp format (e.g., `1632950399` for October 2, 2021).
- `<FilterPattern>`: The filter pattern to match log events. For example, to search for log events containing a specific string, you can use a filter pattern like `"ERROR"`.

Here's an example command that searches for log events in a log group named "MyLogGroup" for a specific time range and filter pattern:

```bash
aws logs filter-log-events --log-group-name MyLogGroup --start-time 1632864000 --end-time 1632950399 --filter-pattern "ERROR"
```

This command will return log events that match the specified filter pattern within the given time range. You can adjust the parameters to tailor the search to your specific requirements. Additionally, you can use various flags and options with this command to further refine your search and format the output as needed.

3. **Updating/Adjusting Alarms in CDK**
   - **Objective**: Manage CloudWatch Alarms using AWS CDK.

To search CloudWatch Logs using the AWS CLI, you can use the `aws logs filter-log-events` command. Here's a basic command to search for log events:

```bash
aws logs filter-log-events --log-group-name <LogGroupName> --start-time <StartTime> --end-time <EndTime> --filter-pattern <FilterPattern>
```

Replace the placeholders with the following values:

- `<LogGroupName>`: The name of the CloudWatch Logs log group you want to search within.
- `<StartTime>`: The start time for the log event search in Unix timestamp format (e.g., `1632864000` for October 1, 2021).
- `<EndTime>`: The end time for the log event search in Unix timestamp format (e.g., `1632950399` for October 2, 2021).
- `<FilterPattern>`: The filter pattern to match log events. For example, to search for log events containing a specific string, you can use a filter pattern like `"ERROR"`.

Here's an example command that searches for log events in a log group named "MyLogGroup" for a specific time range and filter pattern:

```bash
aws logs filter-log-events --log-group-name MyLogGroup --start-time 1632864000 --end-time 1632950399 --filter-pattern "ERROR"
```

This command will return log events that match the specified filter pattern within the given time range. You can adjust the parameters to tailor the search to your specific requirements. Additionally, you can use various flags and options with this command to further refine your search and format the output as needed.

### Alarm Settings and Reasons
   - **Settings Explanation**:
     - [Alarm Setting 1]: [Explanation]
     - [Alarm Setting 2]: [Explanation]
     - ...
   - **Reasons Explanation**:
     - [Reason 1]: [Explanation]
     - [Reason 2]: [Explanation]
     - ...

## Viewing and Querying Log Information in Kibana
   - **Objective**: Access and query logs using Kibana if applicable.

Use Kibana to explore data and harness the power of Elasticsearch Query Language for advanced searches and visualizations.

### Discover Data

Kibana's Discover feature allows you to explore and search your data effectively. Follow these steps:

1. Click on "Discover" in the left sidebar of Kibana.
2. On the left, you'll see a list of fields from your selected index pattern. In the central area, build and execute queries.
3. To perform a simple search, enter your query in the search bar (e.g., `response_code: 404`). This query finds documents where the "response_code" field is 404.
4. Press "Enter" to execute the query, and the matching documents will be displayed in the results table.
5. Refine your search further by adding more query terms or filters using the available options.

### Simple Queries
Querying data in Kibana using the search bar is a fundamental task when working with Elasticsearch indices. Kibana provides a powerful query language that allows you to search, filter, and analyze your data effectively. Below are some common queries and examples of how to use the Kibana search bar:

#### Simple Text Search:

To perform a basic text search, enter a keyword or phrase in the search bar. Kibana will match documents containing that keyword or phrase.

Example:
```
error
```

This query will return all documents that contain the word "error."

#### Wildcard Search:

You can use wildcards to match partial terms. The asterisk (*) represents any number of characters, while the question mark (?) represents a single character.

Example:
```
appl*
```

This query will match terms like "apple," "application," etc.

#### Boolean Operators:

Kibana supports Boolean operators to create complex queries. You can use `AND`, `OR`, and `NOT` to combine multiple conditions.

Example:
```
error AND server
```

This query will return documents containing both "error" and "server."

#### Phrase Search:

To search for an exact phrase, enclose it in double quotes.

Example:
```
"server error"
```

This query will find documents containing the exact phrase "server error."

#### Range Queries:

You can use range queries to filter documents within a specified numeric or date range.

Example (numeric range):
```
response_time:[100 TO 200]
```

This query will return documents with a "response_time" field between 100 and 200.

Example (date range):
```
@timestamp:[2023-01-01 TO 2023-12-31]
```

This query will return documents with a timestamp within the specified date range.

#### Field-Level Queries:

You can specify a field to search within a specific field.

Example:
```
status:404
```

This query will return documents where the "status" field is equal to 404.

#### Regular Expressions:

Kibana allows you to use regular expressions to perform advanced pattern matching.

Example:
```
message:/error\d{3}/
```

This query will match documents where the "message" field contains a three-digit error code.

#### Combining Queries:

You can combine multiple queries and conditions using parentheses and Boolean operators.

Example:
```
(status:200 OR status:201) AND request_method:POST
```

This query will return documents with a "status" of either 200 or 201 and a "request_method" of POST.

#### Aggregation Queries:

Kibana also supports aggregation queries to perform calculations and aggregations on your data.

Example:
```
GET /_search
{
  "aggs": {
    "avg_response_time": {
      "avg": {
        "field": "response_time"
      }
    }
  }
}
```

This Elasticsearch query calculates the average response time.

These are some common examples of how to use the Kibana search bar to query your data. Kibana's search capabilities are extensive, and you can create highly customized queries to analyze and visualize your Elasticsearch data effectively.

### Mastering Elasticsearch Query Language

Elasticsearch Query Language (EQL) empowers you to perform advanced searches. Here are key query examples:

#### Match Query

The match query finds documents where a field contains a specific term.

```json
{
  "query": {
    "match": {
      "message": "error"
    }
  }
}
```

#### Term Query

The term query looks for documents where a field matches exactly.

```json
{
  "query": {
    "term": {
      "status_code": 200
    }
  }
}
```

#### Range Query

A range query allows you to find documents within a specified range.

```json
{
  "query": {
    "range": {
      "timestamp": {
        "gte": "2023-01-01",
        "lte": "2023-12-31"
      }
    }
  }
}
```

#### Boolean Query

Combine multiple conditions using boolean queries (AND, OR, NOT).

```json
{
  "query": {
    "bool": {
      "must": [
        { "match": { "message": "error" } },
        { "range": { "timestamp": { "gte": "2023-01-01" } } }
      ],
      "must_not": { "term": { "status_code": 404 } }
    }
  }
}
```

### Visualize Data

Kibana provides powerful visualization tools to understand your data better. Here's a basic guide:

1. Click on "Visualize" in the left sidebar.
2. Select a visualization type (e.g., "Vertical Bar Chart").
3. Choose an index pattern and configure the X and Y axes based on your data. For instance, create a bar chart to visualize the count of documents over time.
4. Customize your visualization with additional buckets, metrics, and filters.
5. Click "Save" to store the visualization, and add it to a Kibana dashboard for comprehensive data monitoring.

With Kibana and Elasticsearch Query Language, you can efficiently explore, query, and visualize your data, gaining valuable insights into your datasets. To dig deeper, delve into advanced queries, aggregations, and refer to Elasticsearch documentation for further mastery.

6. **Running the Service Locally**
   - **Objective**: Run the service on a local development environment.
   - **Example Command**:
     ```shell
     docker-compose up
     ```

## Docker and Docker Commands

Docker is a popular platform for developing, shipping, and running applications in containers. Containers are lightweight, isolated environments that package applications and their dependencies, making it easy to deploy and manage software consistently across different environments. In this tutorial, you'll learn the basics of Docker and essential Docker commands.

### Prerequisites

Before you begin, ensure you have Docker installed on your system. You can download and install Docker from the official website: [Docker](https://www.docker.com/products/docker-desktop)

### Verify Docker Installation

To ensure that Docker is correctly installed, open your terminal or command prompt and run the following command:

```bash
docker --version
```

You should see the Docker version information displayed, confirming that Docker is installed and available.

### Running a Docker Container

You can create and run a Docker container from an image using the `docker run` command. For example, to run a basic Ubuntu container:

```bash
docker run -it ubuntu:latest
```

- `-it`: This flag stands for interactive mode, which allows you to interact with the container's shell.
- `ubuntu:latest`: This specifies the image to use for the container.

You'll be dropped into a shell inside the Ubuntu container. You can execute commands within the container's environment.

### Managing Containers

Docker provides various commands to manage containers:

- List running containers:
  ```bash
  docker ps
  ```

- List all containers (including stopped ones):
  ```bash
  docker ps -a
  ```

- Stop a running container:
  ```bash
  docker stop <container_id>
  ```

- Remove a stopped container:
  ```bash
  docker rm <container_id>
  ```

### The Dockerfile

A Dockerfile is a script that defines the instructions for building a Docker image. You can create a Dockerfile in your project directory to customize and package your application. Here's a simple example for a Node.js application:

```Dockerfile
# Use the standard Amazon Linux base, provided by ECR/KaOS
# This is a placeholder, replaced by the `DockerFileBuild` build system.
# It will point to the standard shared Amazon Linux image, with a versioned tag.
FROM AMAZON_LINUX

# Runs the standard setup for a docker image.
# This line is replaced by the build system, to install common things (things we know need during setup for AplloShim)
# See the README in this package for more details and why it is necessary.
RUN NADE_SETUP

# Run each of the following copies, and give the run-as user perms to call that stuff.
# Doing the --chown as part of the copies is faster than COPYing, and then chown-ing.

# Copy the Apollo Shim file to the expected runtime locations
COPY --chown=ecs-user:amazon aws_code_deploy/apollo-shim.json /opt/amazon/

# Does nothing important by default, but will pick up your apollo-shim-static-replacements file if you place it
# in the service package's configuration/aws_code_deploy directory.  It needs to end up in /opt for it to be recognized.
COPY --chown=ecs-user:amazon aws_code_deploy/* /opt/

# Copy our application code to the container, with run-as user permissions
COPY --chown=ecs-user:amazon . /opt/amazon/

# Installs /apollo/sbin/envroot
COPY apollo-client/sbin/envroot /apollo/sbin/envroot

# Give the run-as user perms to execute
RUN chmod +x /opt/amazon/bin/entry_point.sh
RUN chown -R ecs-user:amazon /opt/amazon/

# Give permissions
RUN chmod +x /opt/amazon/bin/preserve-env-vars.sh
RUN chown -R ecs-user:amazon /opt/amazon/bin/preserve-env-vars.sh

# Allow dir to be made available as volume to other containers
VOLUME ["/apollo"]

# Make sure we expose our ports
EXPOSE 8080
EXPOSE 8443

# Run your entry point
CMD /opt/amazon/bin/entry_point.sh
```

### Building a Docker Image

To build a Docker image from a Dockerfile, navigate to the directory containing the Dockerfile and run:

```bash
docker build -t my-node-app .
```

- `-t my-node-app`: This tags the image with a name (`my-node-app`) that you can use to reference it.
- `.`: This specifies the build context, which is the current directory containing the Dockerfile.

### Running a Container from Your Custom Image

Once you've built your custom Docker image, you can run a container from it using the same `docker run` command:

```bash
docker run -it my-node-app
```

You now have a container running your application.

## Curling the Service When Running Locally
   - **Objective**: Send HTTP requests to the locally running service for testing.

### Retrieve the Load Balancer DNS Name

You need to obtain the DNS name of the Application Load Balancer (ALB) associated with your ECS service. You can retrieve it using the AWS CLI:

```bash
aws elbv2 describe-load-balancers --load-balancer-names <your-alb-name> --query "LoadBalancers[0].DNSName" --output text
```

Replace `<your-alb-name>` with the name of your ALB.

### Query the ECS Service Using `curl`

With the ALB DNS name in hand, you can use `curl` to query your ECS service. Here's a basic example:

```bash
curl http://<your-alb-dns-name>:<port>/<endpoint>
```

Replace `<your-alb-dns-name>`, `<port>`, and `<endpoint>` with your specific values. For example:

```bash
curl http://my-ecs-service-alb-1234567890.us-west-2.elb.amazonaws.com:8080/api
```

This command sends an HTTP GET request to the specified endpoint on your ECS service.

## Deploying via CDK to a Personal AWS Account
   - **Objective**: Deploy the service to your personal AWS account using AWS CDK.
   - **Example Command**:
     ```shell
     bb cdk deploy --app [Path to CDK App] --profile [Your AWS Profile]
     ```
## Functional Tests

### Running Functional Tests Locally
    - **Objective**: Run functional tests for the service on your local development environment.
    - **Example Command**:
      ```shell
      ```

### Running Functional Tests Against Local
    - **Objective**: Execute functional tests against the locally running service.
    - **Example Command**:
      ```shell
      ```

### Running Functional Tests Against Your Personal AWS Account
    - **Objective**: Run functional tests against the service deployed in your personal AWS account.
    - **Example Command**:
      ```shell
      ```

### Running the FTs Against the Beta Environment
    - **Objective**: Execute functional tests against the Beta environment.
    - **Example Command**:
      ```shell
      ```

## ECS Management

These can be used when there is an active Sev2 related to the service or service infrastructure

Make sure to replace the placeholders with your actual values in each script. Also, ensure that you have the AWS CLI properly configured with the necessary permissions to perform these actions.

You can use the AWS CLI to gather information about an ECS (Elastic Container Service) fleet, including cluster name, service name, tasks, task definitions, revisions, and EC2 instance IPs. Below is a Bash script to achieve this:

```bash
#!/bin/bash

# Specify your ECS cluster name and service name
cluster_name="<cluster-name>"
service_name="<service-name>"

# Get cluster ARN from cluster name
cluster_arn=$(aws ecs describe-clusters --cluster $cluster_name --query "clusters[0].clusterArn" --output text)

# Get service ARN from service name and cluster ARN
service_arn=$(aws ecs list-services --cluster $cluster_name --query "serviceArns[?contains(@, '$service_name')]" --output text)

# Get list of task ARNs for the service
task_arns=$(aws ecs list-tasks --cluster $cluster_name --service-name $service_name --query "taskArns" --output text)

# Get list of task definitions used by the service
task_definitions=()
for task_arn in $task_arns; do
    task_definition=$(aws ecs describe-tasks --cluster $cluster_name --tasks $task_arn --query "tasks[0].taskDefinitionArn" --output text)
    task_definitions+=("$task_definition")
done

# Get revisions for each task definition
task_definition_revisions=()
for task_definition in "${task_definitions[@]}"; do
    revision=$(aws ecs describe-task-definition --task-definition $task_definition --query "taskDefinition.revision" --output text)
    task_definition_revisions+=("$revision")
done

# Get EC2 instance IPs for the cluster/fleet
instance_ips=$(aws ecs list-container-instances --cluster $cluster_name --query "containerInstanceArns" --output text | xargs -n1 aws ecs describe-container-instances --cluster $cluster_name --container-instances | jq -r '.containerInstances[].ec2InstanceId')

# Print the gathered information
echo "Cluster Name: $cluster_name"
echo "Service Name: $service_name"
echo "Task ARNs:"
echo "$task_arns"
echo "Task Definitions:"
echo "${task_definitions[@]}"
echo "Task Definition Revisions:"
echo "${task_definition_revisions[@]}"
echo "EC2 Instance IPs:"
echo "$instance_ips"
```

Make sure to replace `<cluster-name>` and `<service-name>` with your actual ECS cluster and service names. The script retrieves the cluster ARN, service ARN, task ARNs, task definitions, revisions, and EC2 instance IPs for the specified cluster and service and prints the information.

### Upscale the CDK Application

```bash
#!/bin/bash

# Specify your ECS cluster name, service name, and desired count
cluster_name="<cluster-name>"
service_name="<service-name>"
desired_count="<desired-count>"

aws ecs update-service --cluster $cluster_name --service $service_name --desired-count $desired_count
```

### Restart a Specific Container

```bash
#!/bin/bash

# Specify your ECS cluster name and task ID
cluster_name="<cluster-name>"
task_id="<task-id>"

aws ecs stop-task --cluster $cluster_name --task $task_id
```

### Rollback to a Previous Version of the Service

```bash
#!/bin/bash

# Specify your ECS cluster name, service name, task definition, and revision
cluster_name="<cluster-name>"
service_name="<service-name>"
task_definition="<task-definition>"
revision="<revision>"

aws ecs update-service --cluster $cluster_name --service $service_name --task-definition $task_definition:$revision
```

### Run a CDK Hotswap on the Containers

This task usually involves updating the task definition with the new container image. Use the AWS CLI to create a new task definition version with the updated image tag.

### Replace the Entire Fleet

There isn't a direct AWS CLI command for this task. You can use the `update-service` command with the `force-new-deployment` option as mentioned previously.

### SSH into a Container in the Fleet

The following script demonstrates how to SSH into an EC2 instance in your ECS cluster and then access a specific container using `docker exec`.

```bash
#!/bin/bash

# Specify your EC2 instance public IP, SSH key pair, and container ID
instance_ip="<instance-public-ip>"
key_pair="<your-key-pair.pem>"
container_id="<container-id>"

# SSH into the EC2 instance
ssh -i $key_pair ec2-user@$instance_ip << EOF

# Use docker exec to access the container
docker exec -it $container_id /bin/bash
```

## Information from the CDK Construct

The CDK construct used for [Your Software Service] includes the following key components and configurations:

- **VPC and Networking**: Creates an isolated VPC with security group rules and necessary connections.

- **Fargate Service**: Deploys the service using AWS Fargate with specified resource allocations.

- **Load Balancing**: Sets up a Network Load Balancer (NLB) for routing traffic to service instances.

- **Logging**: Configures FireLens for log routing, creating different log groups in Amazon CloudWatch Logs.

- **IAM Roles and Policies**: Defines IAM roles for ECS tasks with managed policies.

- **DNS and Route 53**: Manages DNS records using Route 53, creating A records for service discovery.

- **Additional Resources**: Sets up resources for integration testing (Hydra), SuperNova provisioning, and monitoring.

- **FireLens Log Routing**: Configures FluentBit-based FireLens for log processing and routing.

- **VPC Endpoint Service**: Creates a VPC endpoint service for private connectivity.

- **SSL/TLS**: Upgrades the listener protocol to TLS/SSL for secure communication.

- **CloudAuth**: Manages CloudAuth access and permissions for the service.

- **Monitoring**: Configures monitoring resources for CloudWatch metrics and alarms.

Please note that these configurations are managed and applied using AWS CDK and do not require manual commands. You should refer to the AWS CDK scripts and constructs for more details on specific configurations.

This runbook provides guidance on interacting with and managing [Your Software Service] throughout its lifecycle. Be sure to adapt the commands and instructions to your specific deployment and development environment.
