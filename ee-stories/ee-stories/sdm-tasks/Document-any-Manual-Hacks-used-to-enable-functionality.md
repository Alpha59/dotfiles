## Summary
**As a** service owner, **I want** to document any "manual hacks" used to enable functionality **so that** I can ensure these workarounds are properly tracked, understood, and eventually replaced with robust solutions, minimizing technical debt and operational risk.

### Vision
The vision for this documentation is to provide a comprehensive record of manual hacks, their purpose, and their implementation details. This ensures that stakeholders understand the implications of these hacks and can prioritize their resolution or replacement with sustainable solutions.

### Background
Manual hacks are often introduced as temporary solutions to bypass limitations, address urgent issues, or enable functionality not yet supported natively. While useful in the short term, they can increase maintenance complexity, introduce vulnerabilities, and hinder scalability if left undocumented or unresolved.

### Purpose
The purpose of this documentation is to identify, describe, and assess manual hacks in the system, ensuring they are tracked, evaluated for risk, and prioritized for resolution.

## Manual Hack Documentation

### 1. **Manual Hack Inventory**
| **Hack Name**             | **Purpose**                            | **Scope**            | **Regions/Accounts Affected** | **Owner**            |
|---------------------------|----------------------------------------|----------------------|-------------------------------|----------------------|
| **Static API Key Override** | Temporarily bypass API rate limiting.  | API Gateway          | `us-east-1`, `prod`           | API Team             |
| **Hardcoded Configuration**| Quickly fix a broken feature toggle.   | Web Application      | `global`                      | Frontend Team        |
| **Database Hotfix**        | Manually modify data in production.    | Database             | `us-west-2`, `prod`           | Database Admin Team  |
| **Scripted Job Retry**     | Retry failed jobs with a manual script.| Asynchronous Workers | `eu-central-1`, `prod`        | Operations Team      |

### 2. **Details for Each Hack**
#### A. **Static API Key Override**
- **Description**: An API key with elevated permissions was hardcoded into the service to bypass rate-limiting restrictions for specific high-priority clients.
- **Reason for Implementation**: Critical client operations were being blocked due to rate-limiting policies.
- **Risks**:
  - Security vulnerabilities due to hardcoded sensitive information.
  - Risk of abuse if the key is leaked.
- **Resolution Plan**:
  - Implement a dynamic rate-limiting mechanism by Q2 2024.
  - Replace the hardcoded key with a secure, ephemeral solution.

#### B. **Hardcoded Configuration**
- **Description**: A feature toggle was hardcoded to "enabled" to bypass an issue with the configuration management system.
- **Reason for Implementation**: Critical feature needed to remain active during an outage in the configuration service.
- **Risks**:
  - Hardcoded values may lead to inconsistency across environments.
  - Increased effort to modify or rollback changes.
- **Resolution Plan**:
  - Restore dynamic configuration management once the issue is resolved by Q1 2024.

#### C. **Database Hotfix**
- **Description**: Manual SQL queries were run in production to resolve data inconsistencies caused by a bug in the application logic.
- **Reason for Implementation**: Immediate correction needed to avoid customer impact.
- **Risks**:
  - Risk of introducing additional inconsistencies or errors.
  - Lack of traceability for manual changes.
- **Resolution Plan**:
  - Automate data correction through a validated script by end of Q3 2024.
  - Implement monitoring to detect similar issues proactively.

#### D. **Scripted Job Retry**
- **Description**: Failed asynchronous jobs were manually retried using a script due to incomplete retry logic in the application.
- **Reason for Implementation**: Prevent loss of critical transactional data.
- **Risks**:
  - Increased operational overhead.
  - Potential for human error during manual execution.
- **Resolution Plan**:
  - Enhance retry logic in the application by Q2 2024.
  - Deprecate manual scripts post-implementation.

### 3. **Assessment and Prioritization**
#### Criteria for Assessment:
- **Impact**: Evaluate how the hack affects the system’s functionality and stakeholders.
- **Risk**: Assess security, operational, and scalability risks.
- **Effort to Resolve**: Estimate the time and resources required to replace the hack with a permanent solution.

#### Priority Table:
| **Hack Name**             | **Impact** | **Risk** | **Resolution Effort** | **Priority** |
|---------------------------|------------|----------|------------------------|--------------|
| Static API Key Override   | High       | High     | Medium                 | Critical     |
| Hardcoded Configuration   | Medium     | Medium   | Low                    | High         |
| Database Hotfix           | High       | Medium   | High                   | High         |
| Scripted Job Retry        | Medium     | Low      | Medium                 | Medium       |

### 4. **Monitoring and Updates**
- **Tracking**: Maintain a log of all manual hacks in a centralized repository.
- **Review Schedule**: Conduct quarterly reviews to update the status of each hack.
- **Resolution Progress**: Track progress in resolving each hack in the project management tool.

## Acceptance Criteria
- Should document all identified manual hacks with clear descriptions and risks.
- Should prioritize hacks based on impact, risk, and effort to resolve.
- Should provide actionable resolution plans with timelines.
- Should establish a process for monitoring and updating the status of hacks.

### Gherkin
Given a manual hack in the system,
When it is documented,
Then its risks, impact, and resolution plan should be clearly outlined, and progress tracked until resolution.

This documentation ensures visibility into manual hacks, reducing operational risks and enabling teams to address technical debt systematically.
