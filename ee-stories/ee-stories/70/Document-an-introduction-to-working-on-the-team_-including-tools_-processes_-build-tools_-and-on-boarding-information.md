## Introduction to Working on the Team

Welcome to the team! This document serves as an introduction to the key tools, processes, and practices that will help you get up to speed quickly. Our team uses a variety of tools for development, collaboration, and deployment, and this document outlines the essentials for effective onboarding and day-to-day work.

### Overview of the Team’s Workflow
Our team follows an agile methodology for software development, working in sprints and focusing on continuous improvement. We place a strong emphasis on collaboration, code quality, automated testing, and frequent communication. Below is a detailed overview of the tools and processes we use to maintain an efficient and productive workflow.

---

### Tools Overview

#### 1. **Version Control**
   - **Git**: We use Git for version control, with repositories hosted on **GitHub**.
   - **Git Workflow**: We follow a feature-branch model, using pull requests (PRs) for code review.
     - All changes should be made on a separate feature branch.
     - PRs must be reviewed and approved before merging into the main branch (typically named `main` or `master`).
     - Ensure that you pull the latest changes from the main branch before opening a PR.

#### 2. **Code Review**
   - **GitHub Pull Requests**: Code reviews are done via GitHub PRs.
     - Every PR must have at least one reviewer from the team.
     - Include unit and integration tests as part of your PR.
     - Provide a clear description and context for the changes.
     - Address all comments in the review before merging.

#### 3. **Collaboration Tools**
   - **Slack**: We use Slack for daily communication and collaboration. Channels are organized by topic (e.g., `#dev`, `#ops`, `#announcements`).
   - **Confluence**: All documentation, including technical designs and project notes, is stored in Confluence.
   - **Jira**: We use Jira to manage tasks, sprints, and issues. Work is organized into epics, stories, and tasks.

#### 4. **Project Management**
   - **Agile Process**: We operate in two-week sprints, with regular sprint planning, daily standups, and retrospectives.
   - **Sprint Planning**: During sprint planning, we prioritize work for the upcoming sprint, assign tasks, and estimate effort using story points.
   - **Standups**: We hold daily standup meetings (typically 15 minutes) where each team member discusses what they worked on, what they plan to do next, and any blockers.
   - **Retrospective**: At the end of each sprint, we reflect on what went well, what didn’t, and how we can improve in the next sprint.

#### 5. **CI/CD Pipeline**
   - **Jenkins/GitLab CI**: Our continuous integration (CI) system runs automated builds, tests, and deployments.
     - All code is automatically built and tested before it can be merged into the main branch.
     - Successful builds will automatically deploy to staging environments.
     - You can check build logs and deployment status on Jenkins or GitLab CI dashboard.
   - **Automated Testing**: Unit and integration tests are mandatory for all changes, ensuring high code quality and preventing regressions.

#### 6. **Build Tools**
   - **Node.js and NPM**: We use Node.js for our front-end projects, with NPM for package management.
     - To install dependencies, run:
       ```bash
       npm install
       ```
     - To run the local development environment, use:
       ```bash
       npm start
       ```
   - **Maven**: For backend services written in Java, we use Maven for dependency management and build automation.
     - To build the project, run:
       ```bash
       mvn clean install
       ```
   - **Docker**: Our applications are containerized using Docker. We use Docker for local development as well as production deployments.
     - Common Docker commands:
       - Build the Docker image:
         ```bash
         docker build -t myapp .
         ```
       - Run the Docker container:
         ```bash
         docker run -p 3000:3000 myapp
         ```

#### 7. **Cloud Infrastructure**
   - **AWS (Amazon Web Services)**: Our infrastructure is hosted on AWS. We use a variety of AWS services, including EC2, S3, Lambda, and RDS.
     - **AWS CLI**: The AWS CLI is used for managing infrastructure and resources directly from the command line.
     - **Terraform/CloudFormation**: Infrastructure is managed as code, using Terraform and AWS CloudFormation for provisioning and managing resources.

---

### Onboarding Process

#### 1. **Setup Development Environment**
   - **Access to Repositories**: Ensure that you have access to the appropriate GitHub repositories. Clone the relevant repos using:
     ```bash
     git clone https://github.com/company/repository-name.git
     ```
   - **Install Tools**: Ensure you have the necessary tools installed on your system:
     - **Node.js** (for frontend projects)
     - **Maven** (for Java projects)
     - **Docker** (for containerization)
     - **AWS CLI** (for cloud infrastructure interaction)

   - **SSH Setup**: Set up SSH keys for secure access to GitHub and internal services. Follow this [GitHub SSH Key Setup Guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

#### 2. **Get Access to Internal Tools**
   - **Slack**: Join the appropriate Slack channels for team communication.
   - **Jira**: Request access to Jira for task management.
   - **Confluence**: Get access to Confluence for team documentation.
   - **CI/CD Pipeline**: Ensure you have access to Jenkins or GitLab CI for monitoring build and deployment statuses.

#### 3. **Understand the Development Workflow**
   - **Feature Branches**: All development is done on feature branches. Create a new branch for your work using:
     ```bash
     git checkout -b feature/my-new-feature
     ```
   - **Pull Request Process**: Once your work is complete, open a pull request on GitHub, ensuring that:
     - Tests are included.
     - Code adheres to style guidelines.
     - The PR has a meaningful description of the changes.

#### 4. **Meet the Team**
   - Attend your first **team standup** meeting to introduce yourself and learn about what everyone is working on.
   - Get familiar with the team structure, who is responsible for what, and who to reach out to for help with specific questions.

---

### Best Practices

- **Write Tests**: All new code must be accompanied by unit tests and, where applicable, integration tests. Tests ensure that your code is reliable and can be maintained over time.
- **Code Style and Linting**: Follow the coding style guidelines for the team. Use the linters configured in the project (e.g., **ESLint** for JavaScript).
- **Continuous Learning**: Our team values continuous improvement, both in our processes and in our personal skills. Take the time to explore the tools and resources available, and feel free to suggest improvements to our workflows.
- **Ask for Help**: Don't hesitate to ask questions if you're unsure about anything. The team is here to help you succeed.

---

### Conclusion
This onboarding guide provides an overview of the key tools, processes, and expectations for working on the team. By following these guidelines and leveraging the tools and workflows we’ve set up, you'll be able to quickly integrate into the team and contribute to ongoing projects. Feel free to refer back to this document or ask team members if you need any clarification. Welcome aboard!
