## Summary
**As a** systems architect, **I want** to describe the measures included in our architectural design for the Service Dashboard **so that** the blast radius of failures is minimized, ensuring localized issues do not escalate into widespread disruptions.

### Vision
The vision behind incorporating these measures is to enhance the reliability and availability of the Service Dashboard by designing a system that can isolate and contain failures effectively. This approach aims to protect critical components and functionalities from cascading failures.

### Background
Previous experiences have highlighted the vulnerability of our Service Dashboard to cascading failures, where an issue in one component could impact multiple other components, leading to significant service degradation or outages.

### Purpose
The purpose of detailing these architectural measures is to provide transparency into how the Service Dashboard is engineered to manage and contain failures. This will help in maintaining trust with our users and stakeholders, assuring them of the robustness of our service.

## Architectural Measures to Reduce Blast Radius

### 1. **Microservices Architecture**
   - **Description**: The Service Dashboard is built using a microservices architecture, where each service operates independently with its own database and resources. This separation ensures that failures in one service do not directly affect others.
   - **Impact**: Limits the impact of a failure to the service directly affected, preventing it from affecting the entire system.

### 2. **Fault Isolation Zones**
   - **Description**: Deployment of services across multiple fault isolation zones (e.g., different data centers or cloud regions). This geographic distribution helps in isolating failures to a specific zone.
   - **Impact**: A failure in one zone, such as a data center outage, will not impact the service availability in other zones.

### 3. **Circuit Breakers**
   - **Description**: Implementation of circuit breakers in the service interactions. These circuit breakers prevent failures from cascading by cutting off requests to a failing service and allowing it to recover.
   - **Impact**: Reduces the risk of a failing service impacting other services that depend on it.

### 4. **Rate Limiting and Load Shedding**
   - **Description**: Use of rate limiting and load shedding to manage the traffic and load on the servers effectively. During peak loads or when a service starts to fail, excess requests are shed or limited.
   - **Impact**: Prevents the system from being overwhelmed, which can cause widespread failures.

### 5. **Redundancy and Replication**
   - **Description**: Critical components and data are redundantly configured and replicated across multiple systems and locations.
   - **Impact**: Ensures that the failure of a single component or location can be compensated by its redundant counterpart, minimizing service disruption.

### 6. **Automated Rollbacks and Canary Deployments**
   - **Description**: Automated deployment strategies like canary releases and the ability to perform automated rollbacks to previous stable versions in case of a detected failure.
   - **Impact**: Quick recovery from deployment-related failures and reduced impact on users by limiting the exposure to a small percentage initially.

### 7. **Comprehensive Monitoring and Alerting**
   - **Description**: An extensive monitoring and alerting system is in place to quickly detect and respond to failures across services and infrastructure components.
   - **Impact**: Early detection of anomalies and potential failures allows for swift mitigation actions, reducing the potential spread and impact of failures.

### Testing
- **Simulation of Failures**: Regular drills and chaos engineering practices to simulate failures and test the resilience of the system.
- **Continuous Improvement**: Ongoing evaluation of failure responses and adaptation of strategies based on lessons learned.

## Acceptance Criteria
- Should have all services deployed across multiple fault isolation zones.
- Should have circuit breakers and rate limiting configured for all critical service interactions.
- Should have redundancy in place for all critical components.
- Should have a monitoring system that detects and alerts on failure incidents promptly.

By incorporating these architectural measures, the Service Dashboard is designed to effectively manage failures, minimizing their impact and ensuring high levels of service availability and reliability.
