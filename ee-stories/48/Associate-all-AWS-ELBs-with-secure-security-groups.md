
# Associate all AWS ELBs with secure security groups
### Summary
**As a** DevOps Engineer, **I want** to associate all AWS Elastic Load Balancers (ELBs) with secure security groups **So That** I can ensure that only authorized traffic is allowed to flow through the load balancer, thereby improving the security posture of the infrastructure.

This story focuses on associating secure security groups with all ELBs (Classic Load Balancers, Application Load Balancers (ALB), and Network Load Balancers (NLB)) in the AWS environment. Security groups act as virtual firewalls, controlling both inbound and outbound traffic to the ELBs. Ensuring that the ELBs are configured with appropriate security groups helps reduce the attack surface and ensures that only allowed traffic can reach the underlying services.

### Vision
By associating all ELBs with secure security groups, we restrict access to load balancers, allowing only trusted IP ranges, protocols, and ports, thereby improving the overall security of the system. This will help prevent unauthorized access to applications and services, while also enabling logging and monitoring of traffic.

### Background
AWS ELBs distribute incoming traffic across multiple targets, such as EC2 instances, containers, or Lambda functions. While they are essential for load distribution and high availability, they also expose an entry point to the internet or internal network. Without secure security groups, ELBs could potentially allow unauthorized traffic, leading to security risks. Properly configured security groups enforce rules for inbound and outbound traffic, ensuring only legitimate requests are allowed.

---

### Steps to Associate AWS ELBs with Secure Security Groups

#### 1. **Create or Identify Secure Security Groups**

First, ensure you have security groups that are configured with rules allowing only secure and authorized traffic. These security groups should restrict access based on the following factors:

- **Inbound Traffic**: Define rules for allowed IP addresses, protocols, and ports (e.g., HTTPS on port 443 for internet-facing ALBs).
- **Outbound Traffic**: Define the allowed outbound destinations and protocols.
- **Least Privilege**: Ensure that only necessary traffic is permitted to limit the exposure of services behind the ELBs.

Example security group configuration for an internet-facing Application Load Balancer:

- **Inbound Rules**:
  - Allow HTTPS (port 443) from trusted IP ranges (e.g., corporate IPs or CIDR blocks).
  - Allow HTTP (port 80) only if necessary for redirecting to HTTPS.
- **Outbound Rules**:
  - Allow traffic to the instances behind the ELB on the required application ports (e.g., port 80 or 443).
  - Optionally, allow egress traffic to trusted services or APIs.

Example security group setup via AWS CLI:

```bash
aws ec2 create-security-group --group-name MyELBSecurityGroup   --description 'Security group for ELB allowing HTTPS from trusted IP ranges'
# Inbound rule to allow HTTPS traffic from specific IP range
aws ec2 authorize-security-group-ingress --group-id <security-group-id>   --protocol tcp --port 443 --cidr <trusted-cidr-block>

# Outbound rule to allow traffic to instances on port 80
aws ec2 authorize-security-group-egress --group-id <security-group-id>   --protocol tcp --port 80 --cidr <trusted-instance-cidr-block>
```

---

#### 2. **Associate Security Groups with Application Load Balancer (ALB)**

For **Application Load Balancers (ALB)**, you can associate security groups using the AWS CDK, CLI, or Console. The following example shows how to associate a security group using AWS CDK in TypeScript:

```typescript
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import * as elbv2 from 'aws-cdk-lib/aws-elasticloadbalancingv2';
import { Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';

export class SecureALBStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    // Define an existing or new VPC
    const vpc = ec2.Vpc.fromLookup(this, 'MyVPC', { isDefault: true });

    // Create or look up the security group
    const secureSG = ec2.SecurityGroup.fromSecurityGroupId(this, 'ELBSecurityGroup', '<sg-id>');

    // Define an Application Load Balancer
    const alb = new elbv2.ApplicationLoadBalancer(this, 'MyALB', {
      vpc,
      internetFacing: true,
      securityGroup: secureSG,
    });

    // Add listeners and target groups as needed
    alb.addListener('Listener', {
      port: 443,
      open: true,
    });
  }
}
```

If you prefer to associate security groups using the AWS CLI, you can use the following command:

```bash
aws elbv2 modify-load-balancer-attributes   --load-balancer-arn <alb-arn>   --security-groups <sg-id>
```

This command associates the specified security group with the ALB.

---

#### 3. **Associate Security Groups with Classic Load Balancer (CLB)**

For **Classic Load Balancers (CLB)**, you can associate security groups using the AWS CLI or the AWS Console. The following command shows how to associate a security group with a CLB using the AWS CLI:

```bash
aws elb apply-security-groups-to-load-balancer   --load-balancer-name <clb-name>   --security-groups <sg-id>
```

This will associate the security group with the specified Classic Load Balancer.

---

#### 4. **Security Group Management for Network Load Balancer (NLB)**

**Network Load Balancers (NLB)** work differently from ALBs and CLBs because they do not use security groups directly. Instead, the security groups are associated with the **target EC2 instances** behind the NLB.

For NLB, you need to ensure that the EC2 instances or other resources behind the NLB have secure security groups configured. You can configure the security groups on the EC2 instances with rules that allow inbound traffic from the NLB's IP ranges on the required ports.

Example security group rule for instances behind an NLB:

```bash
# Allow inbound traffic from NLB IP range on port 80
aws ec2 authorize-security-group-ingress --group-id <instance-sg-id>   --protocol tcp --port 80 --cidr <nlb-ip-range>
```

You can obtain the NLB IP range dynamically using the following command:

```bash
aws elbv2 describe-load-balancers --load-balancer-arns <nlb-arn>
```

This will return details, including the NLB’s IP addresses, which can be used in the security group rules for the target instances.

---

#### 5. **Update Security Group Rules for Least Privilege**

To follow security best practices, always apply the principle of least privilege when configuring your security groups. Ensure that:

- **Inbound Traffic**: Only traffic from authorized IP ranges or CIDR blocks is allowed. For example, allow only trusted IPs to access HTTP or HTTPS ports.
- **Outbound Traffic**: Restrict outbound traffic to only necessary destinations. For example, allow traffic only to your application servers, databases, or external APIs that your application needs to communicate with.
- **Monitoring**: Enable logging (via **AWS CloudTrail** and **VPC Flow Logs**) to monitor traffic to and from your ELBs, which can help detect unauthorized access attempts.

---

#### 6. **Testing and Validation**

Once you have associated your ELBs with secure security groups, it's important to test and validate the configuration to ensure that:

- Only allowed traffic is reaching the ELB.
- Unnecessary or unauthorized traffic is blocked as expected.
- You can access your application through the ELB from authorized IPs or CIDR ranges.
- All logs for incoming and outgoing traffic are being captured.

You can test this using tools like **curl** or **Postman** to verify access from different IP ranges and ensure that the security group rules are being enforced.

---

#### 7. **Monitoring and Auditing Security Groups**

Ensure continuous monitoring and auditing of the security group configurations associated with ELBs. Use AWS tools like **AWS Config** and ** Inspector** to audit security group configurations and identify any overly permissive rules that could introduce vulnerabilities.

##### Step 1: Use AWS Config to Monitor Security Group Changes

AWS Config can be set up to monitor changes to security groups and alert you when rules are added or modified in a way that violates your security policies.

```bash
aws configservice put-config-rule   --config-rule '{'ConfigRuleName': 'restricted-sg-rules', 'Source': {'Owner': 'AWS', 'SourceIdentifier': 'RESTRICTED_INCOMING_TRAFFIC'}}'
```

##### Step 2: Use AWS CloudWatch to Set Alarms for Security Group Violations

Set up **CloudWatch Alarms** to monitor security group activity and alert you when there are any potential security risks or violations.

---

### Acceptance Criteria
- Should have all ELBs (ALB, CLB, and NLB) associated with secure security groups.
- Should restrict inbound and outbound traffic to only authorized IP ranges, protocols, and ports based on security best practices.
- Should validate that security group rules enforce proper traffic control and prevent unauthorized access.
- Should have continuous monitoring and auditing in place for security group changes to ensure ongoing security.
- Should ensure that security groups follow the principle of least privilege, allowing only necessary traffic.
