## Ensuring High Availability with 3 Hosts per Availability Zone (AZ) and 3 AZs per Region in AWS

### Purpose
This document outlines how the team ensures high availability (HA) and fault tolerance by configuring **3 hosts per AZ** and **3 AZs per region** in AWS. Additionally, it specifies the need for health checks and automatic failover mechanisms to ensure that applications remain available and resilient to failures across AWS accounts.

---

### 1. **Infrastructure Setup: 3 Hosts per AZ, 3 AZs per Region**

#### **Why 3 Hosts per AZ and 3 AZs per Region?**
- **High Availability**: Distributing hosts across multiple AZs ensures that even if one AZ experiences a failure, the application can continue operating in other AZs without disruption.
- **Fault Tolerance**: Having 3 hosts per AZ provides redundancy within each AZ to avoid a single point of failure. This increases the availability and reliability of the services.
- **Scalability**: Distributing resources across multiple AZs ensures that the application can scale horizontally and handle high traffic loads efficiently.

#### **Implementation Steps**:

1. **3 Hosts per AZ**:
   - In each AZ, launch **at least 3 EC2 instances** or containers (if using ECS or EKS) to ensure that if one host fails, others are available to handle the traffic.
   - For EC2 instances, ensure they are evenly distributed across the AZ to avoid resource contention or bottlenecks.
   - Utilize **Auto Scaling Groups (ASG)** to automatically scale the number of instances up or down based on demand.

2. **3 Availability Zones per Region**:
   - Choose **AWS regions** that support multiple Availability Zones (e.g., US-East-1, EU-West-1).
   - Ensure that your VPC spans at least 3 AZs and that resources like EC2 instances, RDS databases, and Lambda functions are distributed across all 3 AZs.

3. **Multi-AZ Deployment**:
   - For services like **Amazon RDS**, **Amazon ElastiCache**, and **Amazon Aurora**, enable **Multi-AZ** deployments. This ensures automatic replication to a standby instance in a different AZ, improving failover and availability.
   - Use **AWS Global Accelerator** or **Route 53** for routing traffic across AZs and regions.

#### **Example Setup in AWS EC2**:
- Create an Auto Scaling Group with 3 EC2 instances per AZ.
- Spread instances across 3 different AZs within a region:
  ```bash
  aws ec2 create-auto-scaling-group \
    --auto-scaling-group-name my-app-auto-scaling-group \
    --launch-configuration-name my-app-launch-config \
    --min-size 3 \
    --max-size 6 \
    --desired-capacity 3 \
    --vpc-zone-identifier subnet-abc123,subnet-def456,subnet-ghi789
  ```

---

### 2. **Health Checks and Automatic Failover**

#### **Health Checks**:
Health checks monitor the availability of instances and services to detect failures early and take corrective action. These checks are critical for enabling automatic failover and ensuring high availability.

1. **EC2 Instance Health Checks**:
   - **Elastic Load Balancer (ELB)** health checks: Use ELB to automatically monitor the health of EC2 instances and route traffic to healthy instances. Configure ELB health checks for HTTP, HTTPS, or TCP traffic.
   - **Auto Scaling**: If an EC2 instance fails the health check, Auto Scaling automatically terminates the unhealthy instance and launches a new one in a different AZ.

2. **RDS Instance Health Checks**:
   - Enable **Multi-AZ** deployment for Amazon RDS to automatically fail over to a standby instance in a different AZ when the primary instance fails.
   - Use **Amazon RDS Enhanced Monitoring** to keep track of instance health and performance metrics.

3. **Application Health Checks**:
   - Use **AWS CloudWatch Alarms** to set thresholds for application performance, such as latency, error rates, or downtime.
   - Integrate with **AWS Lambda** to automate remediation or notification in case of failures.

4. **Route 53 Health Checks**:
   - **Route 53** can be used to route traffic to healthy endpoints. Configure health checks for your endpoints (e.g., EC2 instances or load balancers) so that Route 53 only routes traffic to healthy resources.
   - Enable **failover routing policy** in Route 53 to automatically redirect traffic to healthy resources across AZs or regions in case of failure.

#### **Example of ELB Health Check Configuration**:
```bash
aws elb configure-health-check \
  --load-balancer-name my-app-elb \
  --health-check target=HTTP:80/index.html,interval=30,timeout=5,unhealthy-threshold=2,healthy-threshold=10
```

---

### 3. **Automatic Failover Mechanisms**

#### **Why Automatic Failover?**
- **Minimize Downtime**: In case of failure (e.g., instance crash, network partition), automatic failover ensures that service is quickly restored without human intervention.
- **Maintain Service Continuity**: By failing over to another healthy instance or AZ, users experience minimal disruption during failures.

#### **Implementation of Failover**:
1. **Load Balancers**:
   - Configure **Application Load Balancers (ALB)** or **Network Load Balancers (NLB)** to distribute traffic across multiple healthy instances in different AZs. If an instance becomes unhealthy, the load balancer automatically stops sending traffic to it and routes traffic to healthy instances.

2. **RDS Multi-AZ Failover**:
   - Enable **Multi-AZ** for RDS databases so that in case of failure, RDS automatically switches to the standby instance in a different AZ without requiring manual intervention.

3. **Amazon Elasticache**:
   - Enable **Redis** or **Memcached** Multi-AZ deployments to ensure automatic failover in case of cache node failure.

4. **Route 53 Failover**:
   - Use **Route 53 health checks** and configure **failover routing** so that DNS queries are routed to healthy instances or regions automatically.

---

### 4. **Ensuring These Configurations Across All AWS Accounts**

To ensure that these configurations are consistently applied across all AWS accounts, implement the following practices:

1. **Infrastructure as Code (IaC)**:
   - Use **AWS CloudFormation**, **Terraform**, or **AWS CDK** to define and manage the infrastructure across all AWS accounts. These tools allow for reproducible, consistent infrastructure setups.

2. **Automated Deployment Pipelines**:
   - Ensure that **CI/CD pipelines** are set up with deployment strategies that include automatic failover and health check verification. These pipelines should automate the creation of resources and configurations across multiple environments (e.g., dev, staging, production).

3. **AWS Organizations and SCPs (Service Control Policies)**:
   - Use **AWS Organizations** to manage multiple AWS accounts and enforce consistent policies using **SCPs**. This can ensure that the same infrastructure setup (e.g., multi-AZ deployment, health checks) is applied across all accounts.

4. **Monitoring and Alerts**:
   - Set up **CloudWatch Alarms** and **AWS Config** to ensure compliance with infrastructure standards across accounts. Automatically notify administrators if any resource does not meet the configured standards for availability and failover.

---

### Example Terraform Configuration for Multi-AZ Setup
```hcl
resource "aws_instance" "example" {
  ami             = "ami-12345678"
  instance_type   = "t2.micro"
  availability_zone = "us-east-1a"
  count           = 3  # 3 instances across 3 AZs

  tags = {
    Name = "example-instance"
  }
}

resource "aws_lb" "example" {
  name               = "example-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups   = ["sg-12345678"]
  subnets            = ["subnet-abc123", "subnet-def456", "subnet-ghi789"]
}
```

---

### Acceptance Criteria

1. **3 Hosts per AZ and 3 AZs per Region**:
   - There should be a minimum of 3 EC2 instances or services distributed across 3 Availability Zones per region.

2. **Health Checks**:
   - Health checks should be configured for EC2 instances, RDS, and other critical resources to ensure early failure detection.

3. **Automatic Failover**:
   - Failover mechanisms should be in place for EC2, RDS, and load balancers, ensuring that traffic is routed to healthy instances in the event of failure.

4. **IaC and Consistency**:
   - Infrastructure for multi-AZ and failover configurations should be managed through Infrastructure as Code (IaC) and be applied consistently across all AWS accounts.

---

### Gherkin

**Feature**: Ensuring High Availability with 3 Hosts per AZ and 3 AZs per Region
**Scenario**: Configure and verify high availability across AWS regions and availability zones
- **Given** the team uses AWS to manage infrastructure,
- **When** resources are deployed across regions and AZs,
- **Then** there should be 3 hosts per AZ, with automatic health checks, failover mechanisms, and infrastructure defined as code.

By following these practices, the team ensures high availability and fault tolerance in production environments, minimizing downtime and providing a resilient application architecture.
