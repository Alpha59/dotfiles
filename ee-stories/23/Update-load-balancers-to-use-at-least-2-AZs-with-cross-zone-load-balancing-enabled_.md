
# Update load balancers to use at least 2 AZs with cross zone load balancing enabled.
### Summary
**As a** DevOps Engineer, **I want** to update the load balancers to use at least two Availability Zones (AZs) with Cross-Zone Load Balancing enabled, **So That** the load balancers distribute traffic more efficiently, ensuring high availability, fault tolerance, and better utilization of backend resources.

This story focuses on updating the configuration of existing load balancers to ensure they are using at least two AZs and have cross-zone load balancing enabled. This will allow traffic to be distributed evenly across all instances in multiple AZs, even if some AZs have fewer instances, providing a more reliable and resilient infrastructure.

### Vision
By updating the load balancers to use multiple Availability Zones and enabling cross-zone load balancing, we ensure that traffic is evenly distributed across backend resources, reducing the risk of overloading instances in a specific AZ and improving the overall fault tolerance of the system.

### Background
Cross-zone load balancing allows a load balancer to distribute traffic evenly across all registered instances in all AZs, even when some AZs have fewer instances. Without cross-zone load balancing, each load balancer node will only route traffic to instances in the same AZ, which can lead to imbalances if some AZs have more instances than others. To ensure fault tolerance and prevent single points of failure, load balancers should be configured to use at least two AZs.

### Purpose
The purpose of this story is to update existing load balancers to use at least two AZs and enable cross-zone load balancing. This will ensure high availability, better resource utilization, and improved performance in case of failures or uneven traffic distribution.

## Details
### 1. Identify Load Balancers to be Updated
Identify all existing load balancers (both Application Load Balancers (ALBs) and Classic Load Balancers (ELBs)) that need to be updated with at least two AZs and cross-zone load balancing enabled.

1. **Application Load Balancers (ALBs)**: Check the number of AZs used and whether cross-zone load balancing is enabled.
2. **Classic Load Balancers (ELBs)**: Verify that at least two AZs are used and that cross-zone load balancing is enabled.

### 2. Configure Load Balancers to Use Multiple AZs
Ensure that each load balancer is associated with at least two Availability Zones (AZs) to provide fault tolerance.

#### Steps for Configuring AZs in ALBs (via AWS Console):
1. Navigate to the **EC2 Console**.
2. In the **Load Balancers** section, select the load balancer you want to update.
3. Go to the **Availability Zones** tab.
4. Select at least two AZs (preferably in different regions) and associate subnets with the load balancer for each AZ.
5. Click **Save** to apply the changes.

#### AWS CLI Command to Enable Multiple AZs for ALB:
```bash
aws elbv2 set-subnets     --load-balancer-arn arn:aws:elasticloadbalancing:region:account-id:loadbalancer/app/my-alb/1234567890abcdef     --subnets subnet-11111111 subnet-22222222
```

#### Steps for Configuring AZs in ELBs (via AWS Console):
1. Navigate to the **EC2 Console**.
2. In the **Load Balancers** section, select the ELB you want to update.
3. Go to the **Description** tab and click **Edit Availability Zones**.
4. Select at least two AZs and associate the corresponding subnets with the ELB.
5. Click **Save** to apply the changes.

#### AWS CLI Command to Enable Multiple AZs for ELB:
```bash
aws elb enable-availability-zones-for-load-balancer     --load-balancer-name my-elb     --availability-zones us-east-1a us-east-1b
```

### 3. Enable Cross-Zone Load Balancing
After configuring multiple AZs, enable cross-zone load balancing to ensure that traffic is distributed evenly across all registered instances in all AZs.

#### Steps for Enabling Cross-Zone Load Balancing in ALBs (via AWS Console):
1. Navigate to the **EC2 Console**.
2. In the **Load Balancers** section, select the ALB you want to update.
3. Go to the **Attributes** tab.
4. Toggle **Cross-Zone Load Balancing** to **Enabled**.
5. Click **Save** to apply the changes.

#### AWS CLI Command to Enable Cross-Zone Load Balancing for ALBs:
```bash
aws elbv2 modify-load-balancer-attributes     --load-balancer-arn arn:aws:elasticloadbalancing:region:account-id:loadbalancer/app/my-alb/1234567890abcdef     --attributes Key=load_balancing.cross_zone.enabled,Value=true
```

#### Steps for Enabling Cross-Zone Load Balancing in ELBs (via AWS Console):
1. Navigate to the **EC2 Console**.
2. In the **Load Balancers** section, select the ELB you want to update.
3. Go to the **Description** tab and click **Edit Attributes**.
4. Check the box for **Cross-Zone Load Balancing**.
5. Click **Save** to apply the changes.

#### AWS CLI Command to Enable Cross-Zone Load Balancing for ELBs:
```bash
aws elb modify-load-balancer-attributes     --load-balancer-name my-elb     --load-balancer-attributes 'CrossZoneLoadBalancing={'Enabled':true}'
```

### 4. Verify Load Balancer Configuration
After updating the load balancers, verify that:
- The load balancer is associated with at least two AZs.
- Cross-Zone Load Balancing is enabled.
- Traffic is being evenly distributed across instances in multiple AZs.

#### AWS CLI Command to Verify ALB Configuration:
```bash
aws elbv2 describe-load-balancer-attributes     --load-balancer-arn arn:aws:elasticloadbalancing:region:account-id:loadbalancer/app/my-alb/1234567890abcdef
```

#### AWS CLI Command to Verify ELB Configuration:
```bash
aws elb describe-load-balancer-attributes     --load-balancer-name my-elb
```

### 5. Monitor Traffic Distribution and Performance
Use ** CloudWatch** to monitor the load balancers' traffic distribution and performance after enabling cross-zone load balancing. Look for metrics such as:
  - **HealthyHostCount**: Ensure that each AZ has healthy instances.
  - **RequestCount**: Verify that requests are being evenly distributed across AZs.
  - **Latency**: Check for any latency improvements after enabling cross-zone load balancing.

### Testing
- **Traffic Distribution Test**: Ensure that traffic is evenly distributed across all instances in multiple AZs.
- **Failover Test**: Test failover scenarios by simulating an outage in one AZ to ensure that traffic is routed to instances in the other AZ(s).
- **Cross-Zone Load Balancing Test**: Verify that cross-zone load balancing is functioning correctly by checking traffic distribution across instances in different AZs.

### External Dependencies
- ** EC2 Console**: For configuring ALBs and ELBs.
- **AWS CLI**: For updating load balancer attributes via command line.
- ** CloudWatch**: For monitoring traffic distribution and performance.

## Acceptance Criteria
- Should have updated all load balancers to use at least two Availability Zones.
- Should have enabled cross-zone load balancing for all load balancers.
- Should have verified that traffic is being evenly distributed across instances in multiple AZs.
- Should have monitored the performance and traffic distribution to ensure proper load balancing.

### Gherkin
#### Scenario: Updating ALB to Use Two AZs with Cross-Zone Load Balancing
Given an ALB is configured,
When I enable cross-zone load balancing and associate two AZs,
Then traffic should be distributed evenly across all instances in both AZs.

#### Scenario: Updating ELB to Use Two AZs with Cross-Zone Load Balancing
Given an ELB is configured,
When I enable cross-zone load balancing and associate two AZs,
Then traffic should be distributed evenly across all instances in both AZs.

#### Scenario: Verifying Load Balancer Configuration
Given the load balancers are updated,
When I verify the configuration,
Then it should show that cross-zone load balancing is enabled and multiple AZs are used.

## External Links
- [AWS Application Load Balancer Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html)
- [AWS Classic Load Balancer Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/introduction.html)
- [ CloudWatch Documentation](https://docs.aws.amazon.com/cloudwatch/index.html)
