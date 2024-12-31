## Documentation of AWS Services and Compute Platforms Used by Team-Owned Services and Applications

### Purpose
This document provides an overview of all AWS services and compute platforms used by the services or applications owned by the team. It helps in understanding resource usage, managing dependencies, and optimizing costs.

---

### AWS Services Used

#### 1. **Compute**
| **Service**           | **Purpose**                                                                                  | **Example Use Cases**                    |
|------------------------|----------------------------------------------------------------------------------------------|------------------------------------------|
| **Amazon EC2**         | Virtual server instances for scalable compute capacity.                                      | Hosting backend services, data pipelines. |
| **AWS Lambda**         | Serverless compute service for running code without provisioning servers.                    | Event-driven tasks, microservices.       |
| **AWS Elastic Beanstalk** | Platform-as-a-Service for deploying and managing applications.                                | Hosting web applications and APIs.       |
| **Amazon ECS (Fargate)** | Container orchestration for running Docker containers without managing servers.               | Deploying microservices in containers.   |

---

#### 2. **Storage**
| **Service**           | **Purpose**                                                                                  | **Example Use Cases**                    |
|------------------------|----------------------------------------------------------------------------------------------|------------------------------------------|
| **Amazon S3**          | Object storage service for data storage and retrieval.                                       | Storing logs, backups, and static assets.|
| **Amazon EFS**         | File storage service for EC2 instances.                                                     | Shared file storage for applications.    |
| **Amazon DynamoDB**    | Fully managed NoSQL database for high-performance applications.                              | Session management, key-value data.      |
| **Amazon RDS**         | Managed relational databases (MySQL, PostgreSQL, etc.).                                      | Storing structured data.                 |

---

#### 3. **Networking**
| **Service**           | **Purpose**                                                                                  | **Example Use Cases**                    |
|------------------------|----------------------------------------------------------------------------------------------|------------------------------------------|
| **Amazon VPC**         | Virtual Private Cloud for isolated networking.                                               | Hosting applications securely.           |
| **Elastic Load Balancer (ELB)** | Distributes traffic to backend resources.                                                  | Balancing load across EC2 instances or containers. |
| **Amazon API Gateway** | API management for exposing and securing APIs.                                               | Serving RESTful APIs to customers.       |

---

#### 4. **Monitoring and Observability**
| **Service**           | **Purpose**                                                                                  | **Example Use Cases**                    |
|------------------------|----------------------------------------------------------------------------------------------|------------------------------------------|
| **Amazon CloudWatch**  | Monitoring and logging service for applications.                                             | Collecting metrics and logs, setting alarms. |
| **AWS X-Ray**          | Distributed tracing for analyzing application performance.                                   | Debugging latency and performance issues. |

---

#### 5. **Security**
| **Service**           | **Purpose**                                                                                  | **Example Use Cases**                    |
|------------------------|----------------------------------------------------------------------------------------------|------------------------------------------|
| **AWS IAM**            | Identity and Access Management for controlling access to AWS resources.                      | Role-based access control for services.  |
| **AWS Secrets Manager**| Securely stores and manages sensitive information.                                           | Storing database credentials, API keys.  |
| **AWS Certificate Manager (ACM)** | Provisioning and managing SSL/TLS certificates.                                         | Securing public endpoints for applications. |

---

#### 6. **Data and Analytics**
| **Service**           | **Purpose**                                                                                  | **Example Use Cases**                    |
|------------------------|----------------------------------------------------------------------------------------------|------------------------------------------|
| **Amazon Kinesis**     | Real-time data streaming and processing.                                                     | Log processing, real-time analytics.     |
| **Amazon Redshift**    | Data warehousing service for analytical queries.                                             | Business intelligence and reporting.     |
| **Amazon Athena**      | Querying data in S3 using SQL.                                                               | Ad-hoc data exploration and analysis.    |

---

#### 7. **Developer Tools**
| **Service**           | **Purpose**                                                                                  | **Example Use Cases**                    |
|------------------------|----------------------------------------------------------------------------------------------|------------------------------------------|
| **AWS CodePipeline**   | Continuous integration and delivery service for automating deployments.                      | CI/CD pipelines for applications.        |
| **AWS CodeBuild**      | Managed build service for compiling and testing source code.                                 | Running tests during CI/CD workflows.    |
| **AWS CodeDeploy**     | Automating deployments to compute services.                                                  | Rolling updates for EC2 and ECS services.|

---

### Compute Platforms Summary

| **Platform**           | **Purpose**                                                                                  | **Example Use Cases**                    |
|------------------------|----------------------------------------------------------------------------------------------|------------------------------------------|
| **Virtual Machines (EC2)** | General-purpose computing with full control over the environment.                            | Hosting traditional applications.        |
| **Serverless (Lambda)** | Event-driven computing without server management.                                             | Background tasks, event processing.      |
| **Containers (ECS/Fargate)** | Portable and scalable application deployment.                                                 | Deploying microservices in containerized environments. |

---

### Maintenance and Review Plan

- **Quarterly Review**:
  - Audit AWS services and compute platforms to validate usage.
  - Identify unused or underutilized resources to optimize costs.
- **Documentation Updates**:
  - Update the list as new services or platforms are adopted.
  - Add deprecation notes for discontinued services.

---

### Acceptance Criteria
- Should document all AWS services and compute platforms used by team-owned services and applications.
- Should include the purpose and example use cases for each service.
- Should validate and update the document quarterly to ensure accuracy.

---

### Gherkin

**Feature**: AWS Services and Compute Platforms Documentation
**Scenario**: Document services and platforms used by the team
- **Given** the team's applications and services,
- **When** AWS services and compute platforms are identified,
- **Then** the documentation should include their purpose and example use cases.

This document ensures a comprehensive understanding of the team's AWS ecosystem, enabling better management and optimization of resources.
