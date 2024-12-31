### Summary
**As a** DevOps Engineer, **I want** to document the steps to move a service away from an Availability Zone (AZ) in the case of an AZ outage **So That** services can maintain availability and functionality even if a single AZ goes down, minimizing the impact on customers.

This document outlines the procedure for handling an AWS Availability Zone outage and ensuring that critical services continue to operate by redirecting traffic or migrating workloads to healthy AZs. This is essential for high-availability services and disaster recovery planning.

### Vision
By documenting the steps for AZ failover, we ensure that the team can act quickly in the event of an AZ failure, minimizing downtime and maintaining service availability for customers. This process should be well-defined, repeatable, and easily executable under pressure.

### Background
AWS operates multiple Availability Zones within a region, each physically separate and isolated. While highly unlikely, an AZ can experience outages due to hardware failure, network issues, or other disruptions. In such cases, it's essential to shift workloads and services to healthy AZs to maintain uptime. The following steps will guide the process of rerouting services and workloads from an affected AZ to functioning AZs.

---

### Steps to Move Service Away from an AZ During an Outage

#### 1. **Identify Impacted Services and Resources in the Affected AZ**

The first step in responding to an AZ outage is identifying the resources affected by the outage, including EC2 instances, databases, load balancers, and any other services running in the AZ.

##### Step 1: Use AWS CLI or Console to Identify Impacted Resources
Run the following AWS CLI command to list EC2 instances by availability zone:

```bash
aws ec2 describe-instances --filters "Name=availability-zone,Values=<affected-az>"
```

Identify other resources, such as RDS databases, EBS volumes, and ECS services running in the affected AZ.

---

#### 2. **Redirect Traffic from the Affected AZ**

If you're using services like Elastic Load Balancers (ELB) or Route 53, you can redirect traffic away from the affected AZ to healthy AZs.

##### Step 1: Adjust Load Balancer Traffic Distribution
If using an Elastic Load Balancer (ALB, NLB), remove the affected AZ from the load balancer's target group.

```bash
aws elbv2 modify-load-balancer-attributes --load-balancer-arn <elb-arn> \
  --availability-zones "<healthy-az-1>" "<healthy-az-2>"
```

This ensures that traffic is only routed to instances or services in healthy AZs.

##### Step 2: Update Route 53 DNS Records
If Route 53 is used, and DNS routing is configured with health checks or multi-AZ setups, ensure Route 53 directs traffic away from the impacted AZ.

- Verify health checks configured in Route 53 for any endpoints in the affected AZ.
- Failover policies in Route 53 can automatically reroute traffic to healthy endpoints in other AZs or regions.

---

#### 3. **Launch Replacement Resources in Healthy AZs**

If the affected AZ outage is likely to be prolonged, launch replacement resources in the healthy AZs.

##### Step 1: Spin Up New EC2 Instances in Healthy AZs
Use an Auto Scaling group to automatically launch new instances in healthy AZs or manually launch replacement instances.

```bash
aws autoscaling update-auto-scaling-group --auto-scaling-group-name <asg-name> \
  --availability-zones "<healthy-az-1>" "<healthy-az-2>"
```

Alternatively, launch instances manually in the healthy AZs:

```bash
aws ec2 run-instances --image-id <ami-id> --instance-type <instance-type> \
  --key-name <key-name> --subnet-id <subnet-id-for-healthy-az>
```

##### Step 2: Attach EBS Volumes in a Healthy AZ
If the workload requires specific data, and the EBS volumes are affected, create snapshots and restore them in a healthy AZ:

```bash
aws ec2 create-snapshot --volume-id <volume-id>
aws ec2 create-volume --snapshot-id <snapshot-id> --availability-zone <healthy-az>
```

##### Step 3: Update Database Replicas
For RDS or Aurora databases, ensure failover to replicas in other AZs is configured. If needed, create new replicas in healthy AZs to maintain database availability.

```bash
aws rds create-db-instance-read-replica --db-instance-identifier <new-replica-id> \
  --source-db-instance-identifier <primary-instance-id> --availability-zone <healthy-az>
```

---

#### 4. **Verify Service Stability in Healthy AZs**

Once the services are moved or new resources are launched in healthy AZs, monitor the health and performance of the services.

##### Step 1: Monitor CloudWatch Alarms
Check **CloudWatch Alarms** to ensure that the newly launched resources are stable and that there are no performance issues. Set alarms to detect any anomalies in latency, errors, or high CPU/memory usage.

##### Step 2: Test Failover Services
Verify that traffic is being routed correctly to the healthy AZs and that services are fully functional by running canary tests or simulating user interactions.

---

#### 5. **Restore Resources in the Affected AZ (Post-Outage)**

Once the AZ outage is resolved, restore services and resources in the affected AZ to balance the load and maintain redundancy.

##### Step 1: Relaunch Resources in the Affected AZ
If instances or resources were terminated or failed, relaunch them in the previously affected AZ:

```bash
aws ec2 run-instances --image-id <ami-id> --instance-type <instance-type> \
  --key-name <key-name> --subnet-id <subnet-id-for-affected-az>
```

##### Step 2: Re-Add AZ to Load Balancer
Reconfigure the Elastic Load Balancer to include the restored AZ and rebalance the traffic:

```bash
aws elbv2 modify-load-balancer-attributes --load-balancer-arn <elb-arn> \
  --availability-zones "<healthy-az-1>" "<healthy-az-2>" "<restored-az>"
```

---

### Acceptance Criteria
- Should identify all impacted services and resources in the affected AZ using AWS CLI or Console.
- Should update load balancer configurations to redirect traffic to healthy AZs during an outage.
- Should be able to launch replacement resources in healthy AZs if the outage persists.
- Should verify that services are fully operational in the healthy AZs after the failover.
- Should restore resources and reconfigure traffic routing to the affected AZ once the outage is resolved.
