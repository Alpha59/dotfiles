## Summary
**As a** DevOps engineer, **I want** to implement the ability to **deploy changes to API throttle limits in API Gateway** without requiring a **full-service deployment** and document the process in the **runbook**, **so that** updates to API throttle configurations can be made quickly and efficiently without affecting the entire service.

Implementing the capability to adjust API throttle limits independently allows for rapid response to traffic spikes, changes in usage patterns, or incident resolution without deploying the entire service. Documenting the process ensures that team members can consistently and accurately perform these updates.

### Vision
By enabling independent deployment of changes to API throttle limits, the team will gain greater flexibility in managing API performance and usage control. The documentation in the runbook will provide a standard operating procedure, reducing the potential for configuration errors and ensuring consistency across deployments.

### Background
API Gateway throttling controls the rate at which clients can send requests to the API. Adjusting throttle limits may be necessary to prevent overloading backend services, handle increased traffic, or mitigate abuse. Typically, changing these limits would require a full redeployment of the service, which is time-consuming and may introduce risks. Allowing throttle limit adjustments without a full deployment optimizes the process and reduces downtime.

### Purpose
The purpose of this story is to implement a mechanism that allows the team to update API throttle limits in API Gateway independently of the full-service deployment and to document the steps in the runbook to ensure proper execution of the process.

## Details

### 1. **Enable Independent Throttle Limit Changes**
   - Implement the ability to update the throttle settings of an API in Amazon API Gateway without redeploying the entire service stack.

   **Steps to Update Throttle Limits**:
   - Use the **AWS Management Console**, **AWS CLI**, or **AWS SDKs** to modify throttle settings at the **stage level** or **API method level**.
   - Changes can be made to:
     - **Burst Limit**: Maximum number of requests allowed in a short period.
     - **Rate Limit**: Steady-state number of requests per second allowed.

   **Example AWS CLI Commands**:
   - Update the throttle settings for an API stage using the AWS CLI:
   ```bash
   aws apigateway update-stage \
     --rest-api-id <api-id> \
     --stage-name <stage-name> \
     --patch-operations op=replace,path=/methodSettings/*/*/throttling/rateLimit,value=<new-rate-limit>
   ```
   - Update burst limit:
   ```bash
   aws apigateway update-stage \
     --rest-api-id <api-id> \
     --stage-name <stage-name> \
     --patch-operations op=replace,path=/methodSettings/*/*/throttling/burstLimit,value=<new-burst-limit>
   ```

### 2. **Document the Process in the Runbook**
   - Add detailed instructions to the runbook for modifying API throttle limits in API Gateway. The documentation should cover:
     - **Identifying the API and stage** to update.
     - **Modifying throttle settings** via AWS Management Console, AWS CLI, or SDKs.
     - **Testing the new settings** to confirm the changes are applied correctly.
     - **Rollback procedures** in case of misconfiguration.

   **Runbook Example**:
   - **Step 1**: Identify the API and stage to update.
     - Use the API Gateway console or `aws apigateway get-rest-apis` to find the API ID.
   - **Step 2**: Update the throttle settings.
     - Use the CLI commands provided above to set the new rate and burst limits.
   - **Step 3**: Validate the changes.
     - Verify the new settings in the API Gateway console.
   - **Step 4**: Rollback if necessary.
     - Revert to the previous throttle limits using the same commands.

### 3. **Integrate Change Tracking for Throttle Updates**
   - Track changes to throttle limits in a version-controlled system or logging mechanism for auditing purposes.

   **Steps to Implement Change Tracking**:
   - Log all throttle limit changes to a monitoring tool (e.g., **CloudWatch Logs**, **Datadog**).
   - Record changes in a **change management system** (e.g., **ServiceNow**, **Jira**).
   - Optionally, use **AWS CloudTrail** to log API calls that modify API Gateway settings.

### 4. **Test the Throttle Change Process**
   - Perform tests to ensure that changes to throttle limits can be made without impacting other aspects of the service.
   - Validate that the new throttle settings work as expected under different load conditions.

   **Test Cases**:
   - Update the rate limit to handle a temporary increase in traffic.
   - Reduce burst limits to mitigate potential abuse or DoS attacks.
   - Simulate high traffic and observe if the new settings prevent overloading.

### 5. **Set Up Alerts for Throttling Events**
   - Configure **CloudWatch Alarms** to monitor for throttling-related metrics (e.g., **4xx and 5xx errors** due to rate limiting).
   - Notify the team when throttle limits are frequently exceeded, indicating the need for adjustment.

   **Example CloudWatch Alarm Configuration**:
   ```bash
   aws cloudwatch put-metric-alarm \
     --alarm-name "High-Throttling-Rate" \
     --metric-name "ThrottledRequests" \
     --namespace "AWS/ApiGateway" \
     --statistic "Sum" \
     --period 300 \
     --threshold 1000 \
     --comparison-operator "GreaterThanThreshold" \
     --evaluation-periods 1 \
     --alarm-actions arn:aws:sns:region:account-id:alert-topic
   ```

### Testing
- Test the ability to change throttle limits via the CLI and console.
- Validate that updates do not disrupt the existing service.
- Test alert notifications to ensure they trigger when thresholds are exceeded.

### Acceptance Criteria
- Should enable changes to API throttle limits without requiring a full-service deployment.
- Should document the steps for modifying throttle limits and include rollback procedures in the runbook.
- Should implement logging and change tracking for throttle limit updates.
- Should set up alerts to notify the team when throttle limits are exceeded or need adjustment.
- Should test the process to ensure it works as expected without impacting the service.

### External Links
- [AWS API Gateway Throttling](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-request-throttling.html)
- [AWS CLI API Gateway Update Stage](https://docs.aws.amazon.com/cli/latest/reference/apigateway/update-stage.html)
- [AWS CloudWatch Alarms for API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/monitoring-cloudwatch.html)
