
# Configure deep DSN and load balancer health checks in pipeline to test single-AZ and single host failures to ensure automatic rollover.
### Summary
**As a** DevOps Engineer, **I want** to configure deep DNS and load balancer health checks in the pipeline to test single-AZ and single-host failures, **So That** automatic rollover is triggered when an AZ or host becomes unhealthy, ensuring high availability and system resilience.

This story focuses on integrating deep DNS and load balancer health checks into the CI/CD pipeline, simulating single-AZ and single-host failures, and validating that automatic rollover to healthy resources occurs without manual intervention. This ensures that the system can handle localized failures, maintaining uptime and performance.

### Vision
By implementing and testing deep DNS and load balancer health checks, we enhance system reliability by ensuring that any failures within a single AZ or on a specific host trigger an automatic failover to healthy resources in other AZs or hosts. This improves system availability and reduces the potential for downtime.

### Background
To maintain high availability, it is critical that the system can detect and respond to failures at both the AZ and host level. Deep DNS health checks ensure that traffic is routed to healthy endpoints, while load balancer health checks validate the status of hosts within an AZ. Configuring these checks and validating them through pipeline tests ensures that failover mechanisms work as intended during real-world failures.

## Details

1. **Configure Deep DNS Health Checks**
   - Set up **Route 53** health checks to monitor the health of services across multiple AZs:
     - Define health checks that actively monitor critical resources (e.g., APIs, databases, or services) within each AZ.
     - Ensure health checks are performed at multiple layers (e.g., HTTP, HTTPS, TCP) to validate the availability of services.
     - Define health check thresholds (e.g., failure after X consecutive failed requests) and recovery parameters (e.g., resumption after Y successful checks).

2. **Set Up Load Balancer Health Checks**
   - Configure health checks for each load balancer (e.g., **ALB**, **NLB**):
     - Monitor the status of backend instances (hosts) in each AZ.
     - Use specific health check paths (e.g., `/health`) to verify that each instance is responding as expected.
     - Define failover conditions, such as instances becoming unhealthy after a specified number of failed checks (e.g., 2-5 failures).
     - Set up health checks to automatically trigger traffic routing to healthy instances or AZs when failures occur.

3. **Integrate Health Checks into CI/CD Pipeline**
   - Add the deep DNS and load balancer health checks into the CI/CD pipeline, automating the process of testing failovers:
     - Simulate single-AZ failures by temporarily disabling instances or services within one AZ.
     - Simulate single-host failures by stopping services or instances on a specific host while ensuring other hosts remain healthy.
     - Validate that the system automatically reroutes traffic to healthy resources in other AZs or hosts during the tests.

4. **Test and Validate Rollover Mechanisms**
   - Execute tests during the pipeline run to simulate both AZ and host failures, ensuring:
     - Route 53 detects the unhealthy AZ and reroutes traffic to healthy AZs.
     - Load balancer health checks mark failing instances as unhealthy and stop routing traffic to them.
     - The rollover occurs smoothly, with no noticeable downtime or service degradation for end users.

5. **Monitor and Log Failover Events**
   - Set up monitoring in **CloudWatch** (or other monitoring tools) to track the status of health checks, including:
     - Which AZ or host has failed and triggered the failover.
     - Metrics for DNS routing, load balancer health check results, and traffic rerouting.
   - Log all failover events for audit and review to ensure the system responds as expected.

6. **Documentation and Ongoing Maintenance**
   - Document the configuration for both deep DNS and load balancer health checks, including:
     - Health check intervals, paths, and thresholds.
     - Steps for testing and validating failover scenarios.
   - Regularly review and update health check configurations to ensure they align with evolving infrastructure and service requirements.

### Testing
- Simulate failures by disabling resources in a single AZ and validating that Route 53 reroutes traffic to other healthy AZs.
- Test single-host failures by stopping instances and ensuring the load balancer directs traffic away from the unhealthy host to available hosts.
- Monitor traffic and system behavior during tests to ensure smooth failover without service interruption.
- Verify that health checks are consistently monitoring and rerouting traffic as defined.

### Acceptance Criteria
- Should have deep DNS health checks configured and monitoring critical services across multiple AZs.
- Should have load balancer health checks in place to monitor backend instances and ensure automatic failover on failure.
- Should have integrated these health checks into the CI/CD pipeline and validated their effectiveness through simulated AZ and host failures.
- Should have tested and documented successful failover scenarios, ensuring no downtime during failover events.
