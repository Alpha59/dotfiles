
# Add Red/Green deployment for continuous delivery scenarios to the pipelines of ECS services
### Summary
**As a** DevOps Engineer, **I want** to add Red/Green deployment to the pipelines of ECS services for continuous delivery scenarios, **So That** we can ensure safe, automated deployments with minimal downtime and an easy rollback mechanism, improving the reliability and availability of the services during production updates.

This story focuses on integrating Red/Green deployment strategies into the existing ECS service pipelines. By doing so, we ensure that new versions of the service are deployed in parallel with the existing version, allowing seamless switching between versions with minimal impact on users. This setup also simplifies rollback in case of failures during the deployment.

### Vision
Integrating Red/Green deployment for ECS services ensures a safe and reliable continuous delivery process. With Red/Green deployments, both the current (Red) and new (Green) versions of the service are running simultaneously, and traffic can be switched from the old to the new version seamlessly. This reduces the risk of production outages, enables zero-downtime deployments, and provides a fast rollback option in case of issues with the new deployment.

### Background
Currently, ECS services may use simple deployment mechanisms that can lead to service disruptions, especially when updates involve significant changes or failures. Red/Green deployment provides an advanced deployment strategy that ensures minimal downtime and reduces the risk of failed deployments impacting production traffic. With this strategy, the current version of the service remains active while the new version is deployed and tested in parallel.

### Purpose
The purpose of this story is to integrate Red/Green deployment strategies into the pipelines of ECS services, ensuring that continuous delivery processes are optimized for safe, automated, and reliable production releases. This deployment strategy aims to reduce the risk of downtime, improve rollback capabilities, and increase the reliability of production deployments.

## Details
1. **Understand the Red/Green Deployment Concept**:
    - In a Red/Green deployment, two versions of the service (Red = current, Green = new) run simultaneously in separate ECS tasks.
    - Traffic is initially routed to the Red version. When the Green version is successfully deployed, traffic is switched to it.
    - If any issues arise with the Green version, the system can revert to the Red version quickly, providing a fast rollback mechanism.

2. **Identify ECS Services for Red/Green Deployment**:
    - Identify the ECS services that would benefit from Red/Green deployment, focusing on services where downtime is not acceptable or rollback processes need to be fast.
    - Ensure that the selected services already use ECS (Elastic Container Service) for container orchestration.

3. **Modify the ECS Pipelines for Red/Green Deployment**:
    - **Build and Test Pipeline**: Modify the existing continuous integration (CI) pipeline to build the new version of the service (Green) and run all necessary tests (unit tests, integration tests).
    - **Deploy Pipeline**:
      - Modify the deployment pipeline to create a parallel ECS task for the Green version, leaving the Red version untouched during the deployment.
      - Ensure that the Green ECS task is deployed and can run alongside the Red task without conflicting resource usage.
    - **Switch Traffic**: Use **AWS Application Load Balancer (ALB)** or **AWS Network Load Balancer (NLB)** to switch traffic from the Red task to the Green task once the new version passes all tests and health checks.

4. **Configure Load Balancing**:
    - Use AWS ALB to handle routing between the Red and Green versions. The ALB should:
      - Initially direct all traffic to the Red ECS tasks.
      - After deploying and testing the Green ECS tasks, gradually switch traffic to the Green ECS tasks using a weighted routing mechanism (e.g., start with 10% traffic to Green, and gradually increase to 100%).
      - Monitor the success of the Green deployment (e.g., through health checks and metrics).
      - If the Green deployment is successful, route 100% of the traffic to the Green tasks.
      - If the Green deployment fails, revert traffic back to the Red tasks.

5. **Set Up Health Checks and Monitoring**:
    - Configure health checks to monitor the performance and availability of both Red and Green versions:
      - ECS health checks can be configured to monitor the availability of the containers.
      - ALB health checks can monitor the availability and responsiveness of the service endpoints.
    - Set up CloudWatch alarms to track errors, high latency, or failed health checks during the deployment of the Green version.
    - In case of a failure, automatically trigger a rollback to the Red version by routing traffic back to the Red ECS tasks.

6. **Integrate Canary Testing (Optional)**:
    - Implement canary testing by routing a small percentage of traffic (e.g., 5-10%) to the Green version before fully switching over.
    - Monitor key metrics such as latency, error rates, and throughput during the canary phase to ensure the new version is stable before completing the deployment.
    - Use AWS Route 53 or ALB weighted routing to manage the gradual traffic shift between Red and Green tasks.

7. **Automated Rollback Mechanism**:
    - Automate rollback by monitoring health metrics and setting predefined failure thresholds (e.g., high error rates, failed health checks).
    - If a failure threshold is met, automatically redirect traffic back to the Red version and terminate the Green ECS tasks.
    - Ensure that the rollback mechanism is well-tested and triggers quickly in the event of an issue.

8. **Test the Red/Green Deployment Workflow**:
    - Test the modified ECS pipeline to ensure that the Red/Green deployment works as expected:
      - Deploy the new Green version in parallel with the Red version.
      - Verify that traffic can be switched from Red to Green and that rollback is smooth in case of failure.
      - Monitor the process to ensure that traffic switching happens without downtime.

9. **Document the Red/Green Deployment Process**:
    - Document the entire Red/Green deployment process, including:
      - How the deployment pipeline handles Red/Green deployments.
      - How to configure and manage ALB for traffic switching.
      - How to monitor the health of the Red and Green versions during deployment.
      - How to handle rollback if the Green deployment fails.
    - Ensure that the documentation is available to the development and operations teams for future reference.

10. **Integrate with CI/CD Pipelines**:
    - Ensure that the Red/Green deployment strategy is fully integrated into the CI/CD pipelines.
    - Automate the process so that every new version of the service is deployed using the Red/Green strategy without manual intervention.

### Testing
- **Functional Tests**:
  - Test the Red/Green deployment by deploying a new version (Green) while the current version (Red) is active.
  - Ensure that traffic is switched to the Green version after successful health checks.
  - Simulate failure scenarios to ensure the system can quickly rollback to the Red version.

- **Performance Tests**:
  - Run performance tests to ensure that traffic switching between the Red and Green versions does not cause downtime or performance degradation.
  - Test the rollback mechanism to verify that the system quickly reverts to the Red version in case of issues.

- **End-to-End Testing**:
  - Ensure that the entire Red/Green deployment process works seamlessly, from deploying the new version to routing traffic and handling rollback.

### External Dependencies
- Integration with AWS services such as ECS, ALB/NLB, CloudWatch, and Route 53 for managing deployments and traffic routing.
- Collaboration with the DevOps and operations teams to modify the ECS pipelines and ensure proper monitoring and alerting.

## Acceptance Criteria
- Should have implemented Red/Green deployment for all relevant ECS services.
- Should have modified ECS pipelines to deploy the new version (Green) alongside the current version (Red).
- Should have configured ALB to route traffic between the Red and Green versions and switch traffic smoothly.
- Should have set up health checks and monitoring to ensure that both Red and Green deployments are operating correctly.
- Should have tested the rollback mechanism to ensure that traffic can be reverted to the Red version in case of failure.
- Should have documented the Red/Green deployment process and integrated it into the CI/CD pipeline.

### Gherkin
#### Scenario: Red/Green Deployment for ECS Service
Given an ECS service with a current version (Red),
When a new version (Green) is deployed,
Then traffic should be gradually switched to the Green version once health checks pass,
And traffic should be reverted to the Red version in case of failure.

#### Scenario: Canary Testing During Red/Green Deployment
Given a new version (Green) is deployed alongside the current version (Red),
When the system routes a small percentage of traffic to the Green version,
Then the system should monitor the Green version's performance and gradually increase traffic to it if no issues are detected.

#### Scenario: Automatic Rollback During Red/Green Deployment
Given that the new version (Green) is deployed and has failed health checks,
When a failure threshold is reached,
Then traffic should automatically revert to the Red version and terminate the Green tasks.

## External Links
- [AWS ECS Blue/Green Deployments with CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployments-create-ecs.html)
- [Red/Green Deployment on AWS](https://aws.amazon.com/blogs/devops/implementing-red-green-deployments-on-aws/)
