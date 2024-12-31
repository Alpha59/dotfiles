## Summary
**As a** DevOps engineer or cloud architect, **I want** to ensure that each **service component** has the required number of tasks or hosts per **Availability Zone (AZ)** based on the service type, with at least 3 instances, **so that** the services remain resilient, highly available, and capable of handling traffic even during AZ outages or failures.

Ensuring redundancy across multiple Availability Zones is a key practice in maintaining the resilience and high availability of services in AWS. By running at least 3 tasks or instances per AZ, you protect the service from failures in any one zone, improving both uptime and fault tolerance.

### Vision
By configuring at least 3 tasks/hosts per AZ for each service, the team will ensure that the application can sustain availability during outages or disruptions in a specific availability zone. This setup will distribute the load and make the service more resilient to infrastructure failures.

### Background
AWS offers high availability by distributing resources across multiple Availability Zones. For services like EC2, ECS, and RDS, deploying multiple instances or tasks across at least three AZs ensures redundancy, providing better fault tolerance and uptime. A minimum of 3 tasks/hosts per AZ ensures that even if one AZ goes down, the remaining zones will continue serving traffic.

### Purpose
The purpose of this story is to ensure that each service component has at least 3 tasks or hosts per AZ, maintaining high availability and resilience for critical production services. This configuration will provide automatic failover and protect the services from zonal outages.

## Details

### 1. **Configure EC2 Auto Scaling for at Least 3 Instances per AZ**
   - For EC2-based services, use **Auto Scaling Groups (ASG)** to ensure that at least 3 instances are running in each AZ.
   - Set up an ASG that spans across 3 or more AZs, and configure the **desired instance count** to ensure there are at least 3 instances in each zone.

   **Steps**:
   - Create an Auto Scaling Group across multiple AZs and configure the minimum, desired, and maximum number of instances.
   - Use **target tracking** or **scheduled scaling** to adjust capacity based on demand while ensuring the minimum number of instances is maintained.

   **Example Auto Scaling Group Configuration**:
   ```bash
   aws autoscaling create-auto-scaling-group \
     --auto-scaling-group-name my-asg \
     --launch-configuration-name my-launch-config \
     --min-size 9 --max-size 15 --desired-capacity 9 \
     --availability-zones "us-east-1a" "us-east-1b" "us-east-1c"
   ```

   - Ensure that the ASG automatically replaces unhealthy instances, maintaining 3 instances per AZ at all times.

### 2. **Ensure ECS Tasks are Distributed Across 3 AZs**
   - For ECS (Amazon Elastic Container Service) services, ensure that at least 3 tasks are running in each AZ within the cluster.
   - Configure the **task placement strategy** to distribute ECS tasks evenly across AZs, ensuring balanced availability.

   **Steps**:
   - Set a **task placement strategy** using `spread` across AZs to ensure that ECS tasks are evenly distributed.

   **Example ECS Service Task Definition**:
   ```json
   {
     "placementConstraints": [],
     "placementStrategy": [
       {
         "type": "spread",
         "field": "attribute:ecs.availability-zone"
       }
     ],
     "desiredCount": 9
   }
   ```

   - Set the **desired count** of tasks to at least 9, with 3 tasks running in each AZ across 3 zones. ECS will handle task placement across available AZs.

   **ECS CLI Example**:
   ```bash
   aws ecs update-service \
     --cluster my-cluster \
     --service my-service \
     --desired-count 9
   ```

### 3. **RDS Multi-AZ Setup for Database Redundancy**
   - For RDS databases, enable **Multi-AZ** deployment to automatically provision a standby instance in a different AZ. This ensures redundancy and failover capabilities for database services.
   - Ensure that the database remains available across multiple AZs by configuring it with at least 3 read replicas (if using Amazon Aurora) or a failover instance (for traditional RDS).

   **Steps**:
   - Enable Multi-AZ for your RDS instance to automatically create a standby in a different AZ.

   **Example AWS CLI for Enabling Multi-AZ on an RDS Instance**:
   ```bash
   aws rds modify-db-instance \
     --db-instance-identifier mydbinstance \
     --multi-az \
     --apply-immediately
   ```

   - For Aurora, configure at least 3 read replicas across different AZs to ensure high availability.

### 4. **Load Balancing Across Multiple AZs**
   - Ensure that the load balancer (e.g., **AWS Elastic Load Balancer (ALB/ELB)**) is distributing traffic evenly across multiple AZs.
   - Enable **cross-zone load balancing** to ensure that traffic is balanced across all available AZs, even if one AZ becomes overloaded or fails.

   **Steps**:
   - For an ALB, ensure that the target group is configured with instances or tasks in multiple AZs.
   - Enable cross-zone load balancing to improve distribution.

   **Example Enabling Cross-Zone Load Balancing on ALB**:
   ```bash
   aws elbv2 modify-load-balancer-attributes \
     --load-balancer-arn my-load-balancer-arn \
     --attributes Key=load_balancing.cross_zone.enabled,Value=true
   ```

### 5. **Set Up Monitoring and Alarms for Instance/Task Count per AZ**
   - Use **CloudWatch** to monitor the number of instances or tasks running per AZ, ensuring that at least 3 are always available.
   - Set up alarms that notify the team if the number of running instances or tasks falls below the required threshold.

   **Steps**:
   - Monitor ECS tasks using CloudWatch metrics like `CPUUtilization`, `MemoryUtilization`, and `RunningTaskCount` per AZ.
   - For EC2 instances, use **Auto Scaling Group metrics** to track the number of healthy instances in each AZ.

   **Example CloudWatch Alarm for ECS Task Count**:
   ```bash
   aws cloudwatch put-metric-alarm \
     --alarm-name "ECS-Task-Count" \
     --metric-name "RunningTaskCount" \
     --namespace "AWS/ECS" \
     --statistic "Minimum" \
     --period 300 \
     --threshold 3 \
     --comparison-operator "LessThanThreshold" \
     --dimensions Name=ClusterName,Value=my-cluster \
     --evaluation-periods 1 \
     --alarm-actions arn:aws:sns:region:account-id:MySNSTopic
   ```

### 6. **Test High Availability and AZ Failover**
   - Simulate an AZ failure by stopping instances or tasks in a specific AZ and ensure that the service remains available through other AZs.
   - Test auto-scaling policies to verify that new tasks or instances are automatically launched in healthy AZs.

   **Steps**:
   - Manually stop tasks in one AZ and observe how ECS or the Auto Scaling Group responds by replacing them.
   - Test load balancer failover scenarios to verify that traffic is routed to healthy instances in other AZs.

### Testing
- Verify that the Auto Scaling Group maintains 3 instances per AZ across 3 AZs.
- Check that ECS services distribute tasks evenly across 3 AZs, maintaining at least 3 tasks per zone.
- Confirm that RDS or Aurora is configured for Multi-AZ deployment with automatic failover.
- Test load balancer behavior during an AZ failure to ensure traffic is routed to healthy zones.

### Acceptance Criteria
- Should configure EC2 Auto Scaling Groups to maintain at least 3 instances per AZ.
- Should configure ECS to run at least 3 tasks per AZ using placement strategies.
- Should ensure RDS is using Multi-AZ or Aurora is using 3 read replicas for redundancy.
- Should enable cross-zone load balancing for all load balancers.
- Should set up monitoring and alarms to track the number of tasks/instances per AZ.
- Should test failover and high-availability scenarios across AZs to ensure resilience.

### External Links
- [AWS EC2 Auto Scaling Documentation](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html)
- [Amazon ECS Task Placement](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement.html)
- [AWS RDS Multi-AZ Deployments](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html)
- [Elastic Load Balancing Cross-Zone Load Balancing](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cross-zone.html)
