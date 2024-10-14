
# Enable connection draining for AWS load balancers
### Summary
**As a** DevOps Engineer, **I want** to enable connection draining for AWS Load Balancers, **So That** existing in-flight connections to instances are gracefully terminated when the instance is deregistered or terminated, ensuring a smooth transition and minimal disruption to ongoing user requests.

This story focuses on configuring connection draining (also known as deregistration delay) for AWS Load Balancers to allow active connections to complete before terminating or deregistering instances during scaling events or deployments. This reduces the risk of dropped connections or service disruptions, especially during instances of scaling down or rolling updates.

### Vision
Enabling connection draining ensures that active client requests to backend instances are gracefully handled during load balancer events such as instance deregistration or termination. This mechanism provides a better user experience by allowing ongoing requests to complete while preventing new requests from being routed to the affected instances.

### Background
When instances behind an AWS Load Balancer are terminated or deregistered (for example, during auto-scaling or deployment events), existing client connections may be abruptly dropped if connection draining is not enabled. By enabling connection draining, AWS Load Balancers allow ongoing requests to finish processing before removing instances from the load balancer's target group or backend pool.

### Purpose
The purpose of this story is to enable and configure connection draining (deregistration delay) on AWS Load Balancers (either Classic Load Balancers or Application Load Balancers), ensuring that active connections are gracefully drained before instances are deregistered or terminated.

## Details
### 1. Determine the Type of AWS Load Balancer
- Identify the type of AWS Load Balancer in use:
  - **Classic Load Balancer (CLB)**: Primarily used in legacy setups, supporting connection draining.
  - **Application Load Balancer (ALB)**: Modern HTTP/HTTPS-based load balancers.
  - **Network Load Balancer (NLB)**: High-performance load balancers for TCP traffic.

### 2. Enable Connection Draining for Classic Load Balancers (CLB)
For Classic Load Balancers, connection draining allows active connections to finish before the instance is removed from the load balancer. The **Connection Draining Timeout** defines how long the load balancer waits for in-flight requests to complete before forcibly terminating connections.

#### CLI Command to Enable Connection Draining for CLB:
```bash
aws elb modify-load-balancer-attributes   --load-balancer-name <load-balancer-name>   --load-balancer-attributes '{\'ConnectionDraining\':{\'Enabled\':true,\'Timeout\':300}}'
```
- **`Enabled`:** Set to `true` to enable connection draining.
- **`Timeout`:** The maximum time (in seconds) to wait for active connections to close. The default is 300 seconds (5 minutes), but you can adjust this based on your application’s needs.

### 3. Enable Deregistration Delay for Application Load Balancers (ALB)
For Application Load Balancers (ALB), the equivalent feature is called **Deregistration Delay**. This setting determines how long the load balancer waits before removing deregistered targets from the target group, allowing in-flight requests to complete.

#### CLI Command to Enable Deregistration Delay for ALB:
```bash
aws elbv2 modify-target-group-attributes   --target-group-arn <target-group-arn>   --attributes Key=deregistration_delay.timeout_seconds,Value=300
```
- **`deregistration_delay.timeout_seconds`:** Specifies how long the ALB waits before completing deregistration, allowing active connections to complete. The default value is 300 seconds (5 minutes).

### 4. Enable Deregistration Delay for Network Load Balancers (NLB)
For Network Load Balancers (NLB), you can also configure **Deregistration Delay** to allow for graceful termination of connections.

#### CLI Command to Enable Deregistration Delay for NLB:
```bash
aws elbv2 modify-target-group-attributes   --target-group-arn <target-group-arn>   --attributes Key=deregistration_delay.timeout_seconds,Value=300
```
- Similar to ALB, this attribute defines the time (in seconds) that the load balancer will wait before deregistering targets.

### 5. Configure Auto Scaling and ECS to Respect Connection Draining
- If the load balancer is integrated with **Auto Scaling Groups** or **ECS services**, ensure that the auto-scaling or service termination logic respects the connection draining settings. AWS will honor the deregistration delay or connection draining timeout before terminating instances.

#### For Auto Scaling Groups:
- Ensure that the **Health Check Grace Period** is configured to respect the connection draining timeout, preventing instances from being terminated prematurely.

#### For ECS Services:
- When updating ECS services, ensure that the service waits for ongoing tasks to finish within the deregistration delay period before terminating containers.

### 6. Verify Connection Draining Settings
- After enabling connection draining or deregistration delay, monitor the behavior of the load balancer during instance deregistration or termination events to ensure that active connections are being handled gracefully.
- **CloudWatch Logs**: Check CloudWatch metrics for load balancers (such as **HealthyHostCount** and **RequestCount**) to verify that requests are properly drained during instance deregistration.

#### CloudWatch Metric for Monitoring Connection Draining:
- **RequestCount**: Monitors the total number of requests handled by the load balancer. You can track a drop in this metric during connection draining events.
- **TargetDeregistration**: For ALB and NLB, check CloudWatch metrics for target group deregistration events to ensure they respect the timeout period.

### 7. Monitor and Adjust the Timeout Period
- The connection draining timeout or deregistration delay should be adjusted based on the average time taken by your application to process requests. For example:
  - Short-lived requests (e.g., simple web page loads) may require a shorter timeout (e.g., 60-120 seconds).
  - Long-running requests (e.g., large file uploads, complex API calls) may require a longer timeout (e.g., 300-600 seconds).

### Testing
- **Instance Deregistration Test**: Deregister an instance or container from the load balancer (e.g., via Auto Scaling, ECS service update) and observe whether active connections are gracefully handled.
- **Timeout Test**: Simulate long-running requests (e.g., file uploads, streaming) and verify that the load balancer allows the requests to complete within the configured connection draining timeout or deregistration delay period.

### External Dependencies
- Integration with AWS Load Balancers (Classic, Application, or Network Load Balancers) and AWS Auto Scaling or ECS services for handling instance scaling events.
- Use of AWS CloudWatch for monitoring load balancer performance and connection draining behavior.

## Acceptance Criteria
- Should have enabled connection draining for all applicable AWS load balancers (Classic, Application, and Network Load Balancers).
- Should have tested the connection draining feature by deregistering instances and observing that in-flight requests are handled gracefully.
- Should have adjusted the connection draining timeout or deregistration delay based on the average request processing time for the application.
- Should have verified that Auto Scaling and ECS services respect the connection draining timeout when terminating instances or containers.
- Should have documented the configuration process and provided monitoring guidelines for connection draining events.

### Gherkin
#### Scenario: Enabling Connection Draining for Classic Load Balancer
Given an AWS Classic Load Balancer,
When connection draining is enabled,
Then active client connections should be allowed to complete within the specified timeout before instances are deregistered.

#### Scenario: Enabling Deregistration Delay for Application Load Balancer
Given an AWS Application Load Balancer,
When deregistration delay is enabled,
Then the load balancer should wait for the specified timeout period to allow in-flight requests to complete before deregistering the instance.

#### Scenario: Monitoring Connection Draining Behavior
Given an AWS Load Balancer with connection draining enabled,
When an instance is deregistered,
Then active connections should complete successfully, and the system should log the connection draining behavior in CloudWatch.

## External Links
- [AWS Classic Load Balancer Connection Draining Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/config-conn-drain.html)
- [AWS Application Load Balancer Deregistration Delay Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html#deregistration-delay)
