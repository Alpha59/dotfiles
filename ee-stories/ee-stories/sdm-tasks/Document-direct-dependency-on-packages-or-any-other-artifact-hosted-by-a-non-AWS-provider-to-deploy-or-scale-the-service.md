## Summary
**As a** DevOps engineer, **I want** to document all direct dependencies on packages or artifacts hosted by non-AWS providers **so that** we can ensure transparency in our deployment pipeline and manage risks associated with external dependencies when deploying or scaling our service.

### Vision
The vision for this documentation is to provide a clear record of external dependencies, helping teams understand potential risks, such as availability issues or changes in external services that might affect our ability to deploy or scale efficiently.

### Background
Our service relies on certain external packages and artifacts for operation, many of which are hosted by providers other than AWS. This external hosting can introduce risks related to stability, security, and compliance.

### Purpose
The purpose of this documentation is to map out all external dependencies clearly, providing the necessary details to assess their impact on our service's deployment and scalability. This will aid in contingency planning, risk management, and ensuring high availability.

## Documented Dependencies

### Table of External Dependencies

| Dependency Name     | Provider            | Usage in Our Service                           | Impact on Deployment/Scaling             | Risk Mitigation Plan                    |
|---------------------|---------------------|------------------------------------------------|------------------------------------------|-----------------------------------------|
| **React.js**        | Content Delivery Network (CDN) | Frontend library used across web applications | Essential for UI rendering; risk if CDN is down | Mirror on AWS S3; use fallback CDN     |
| **PostgreSQL JDBC Driver** | PostgreSQL.org       | Database connectivity for Java applications    | Critical for database operations          | Host a copy internally; fallback to a secondary source |
| **Node.js**         | Node.js Foundation  | Runtime environment for our back-end services  | Required for service operation           | Use AWS Lambda as a fallback for runtime hosting |
| **Bootstrap CSS**   | Bootstrap CDN       | Stylesheet for front-end components            | Necessary for consistent UI appearance    | Cache on AWS CloudFront, update periodically |
| **Font Awesome**    | Font Awesome CDN    | Icon toolkit for UI enhancements               | Affects UI aesthetics if unavailable     | Cache assets and serve from internal servers |
| **NGINX**           | NGINX, Inc.         | Web server and reverse proxy                   | Essential for load balancing and routing | Pre-build NGINX containers and store in ECR (Elastic Container Registry) |
| **Elasticsearch**   | Elastic.co          | Search and analytics engine                    | Critical for log and data analysis       | Maintain an Elastic Cloud subscription as backup |
| **D3.js**           | D3.js CDN           | Data visualization library                     | Vital for generating dynamic charts/graphs | Local fallback version in our static assets |

### Risk Assessment
- **Availability**: Non-AWS hosted dependencies could face outages, affecting our deployment and scaling.
- **Performance**: Latency in accessing these dependencies might degrade during critical operations.
- **Security**: Externally hosted packages could introduce vulnerabilities or compliance issues.

### Monitoring and Alerting
- **Implementation**: Set up monitoring on the availability and response times of these dependencies.
- **Alerts**: Configure alerts for any downtime or performance degradation to take immediate action.

### External Dependencies Management Plan
- **Regular Updates**: Schedule regular reviews of dependency versions and their hosting conditions.
- **Vendor Communication**: Maintain open lines of communication with all non-AWS providers for timely updates on any changes that might affect their services.
- **Contingency Plans**: Develop and document contingency plans for each critical dependency to mitigate risks associated with external hosting.

## Acceptance Criteria
- Should have a detailed list of all non-AWS hosted dependencies, including their usage, impact, and risk mitigation strategies.
- Should have monitoring tools configured to track the availability and performance of these dependencies.
- Should have tested all fallback and mitigation strategies to ensure they function as expected under failure conditions.

### Gherkin
Given a non-AWS hosted dependency is down,
When our service attempts to deploy or scale,
Then the fallback or mitigation strategy should activate, ensuring minimal impact on service performance and availability.

This comprehensive documentation and management of non-AWS dependencies will enhance our deployment and scaling processes, ensuring high service reliability and performance even when external factors pose potential risks.
