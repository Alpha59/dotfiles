## Summary
**As a** DevOps engineer or pipeline owner, **I want** to set up **notifications (alarms/tickets) for blocked pipelines**, **so that** the team is alerted when a pipeline is stalled, blocked, or fails, ensuring timely resolution and minimizing delays in the deployment process.

Blocked or failed pipelines can lead to significant delays in releasing software. By configuring automated notifications and tickets, the team can quickly address issues and keep the CI/CD process running smoothly, reducing downtime and bottlenecks in the development lifecycle.

### Vision
By setting up automated notifications (via alarms or tickets), the team will be able to respond to pipeline blockages or failures immediately. This will improve pipeline efficiency, reduce downtime, and ensure that blockers are resolved promptly to keep the release cycle on track.

### Background
CI/CD pipelines can become blocked or fail due to various issues, such as test failures, misconfigurations, or resource limitations. Blocked pipelines can slow down the deployment process and increase the time it takes to deliver new features or fixes. By setting up notifications and creating tickets for pipeline failures, teams can ensure that these issues are addressed quickly.

### Purpose
The purpose of this story is to configure notifications (alarms or tickets) for blocked pipelines, enabling the team to take prompt action when a pipeline is stalled or fails, minimizing delays in the software release process.

## Details

### 1. **Set Up Monitoring for Pipeline Stages**
   - Use pipeline tools like **Jenkins**, **GitLab CI**, **GitHub Actions**, or **AWS CodePipeline** to monitor the status of each pipeline stage.
   - Ensure that the pipeline tool tracks:
     - **Pipeline failures** (e.g., build or test failures).
     - **Pipeline stalls** (e.g., waiting for approval, missing resources).
     - **Pipeline timeouts** (e.g., step exceeds predefined time limits).

   **Example: GitLab CI Timeout Settings**:
   ```yaml
   job_name:
     script:
       - run-build
     timeout: 20m
   ```

### 2. **Configure Alarms for Blocked Pipelines**
   - Set up alarms for pipeline failures or stalls using tools like **CloudWatch**, **Datadog**, or **Prometheus**.
   - Configure alarms to trigger based on:
     - Pipeline failures or stages failing.
     - Pipeline steps taking too long (time-based alarms).

   **Example AWS CloudWatch Alarm for Pipeline Failure**:
   ```bash
   aws cloudwatch put-metric-alarm --alarm-name "PipelineFailureAlarm" \
   --metric-name "FailedPipelineExecutions" --namespace "CodePipeline" \
   --threshold 1 --comparison-operator GreaterThanThreshold --evaluation-periods 1 \
   --alarm-actions arn:aws:sns:region:account-id:MySNSTopic
   ```

### 3. **Set Up Notifications**
   - Use **SNS**, **Slack**, **PagerDuty**, or **email** to notify the team of pipeline blockages or failures.
   - Configure the notification to include relevant details, such as the pipeline name, stage, and error message, to help the team quickly identify and resolve the issue.

   **Example GitHub Action for Slack Notification on Failure**:
   ```yaml
   name: Notify on Pipeline Failure
   on:
     workflow_run:
       workflows: ["CI Pipeline"]
       types:
         - completed
   jobs:
     send_notification:
       if: failure()
       runs-on: ubuntu-latest
       steps:
         - name: Notify via Slack
           uses: slackapi/slack-github-action@v1.18.0
           with:
             channel-id: 'CHANNEL_ID'
             slack-message: 'Pipeline failed for ${{ github.repository }}'
             token: ${{ secrets.SLACK_TOKEN }}
   ```

### 4. **Create Automated Tickets for Blocked Pipelines**
   - Integrate with tools like **Jira** or **ServiceNow** to automatically create tickets when a pipeline is blocked or fails.
   - Include key information in the ticket, such as the pipeline name, failure reason, and logs for the failed stage, allowing the assigned team member to take quick action.

   **Example using Jira API to Create Tickets**:
   ```bash
   curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer YOUR_JIRA_API_TOKEN" \
   -d '{
     "fields": {
       "project": { "key": "PROJ" },
       "summary": "Pipeline Blocked: Build Failure",
       "description": "Pipeline ABC failed at step X due to a test failure.",
       "issuetype": { "name": "Bug" }
     }
   }' https://your-jira-instance/rest/api/2/issue
   ```

### 5. **Set Up Monitoring for Pipeline Health**
   - Use dashboards in **Grafana**, **Datadog**, or **CloudWatch** to monitor pipeline health metrics, such as the number of successful, failed, and blocked pipelines.
   - Set thresholds and alarms for pipeline health (e.g., if the failure rate exceeds a certain percentage over a period).

### Testing
- Simulate blocked or failed pipelines to test if alarms and notifications are triggered.
- Ensure that notifications include all relevant information for debugging the issue.
- Validate that tickets are automatically created when the pipeline is blocked or failed, containing appropriate details.

## Acceptance Criteria
- Should set up notifications for pipeline failures, stalls, and timeouts.
- Should configure alarms that trigger when a pipeline is blocked or fails.
- Should ensure that notifications include relevant details and are sent via Slack, email, or other channels.
- Should automate ticket creation in Jira or ServiceNow for blocked pipelines.

### External Links
- [AWS CloudWatch Pipeline Monitoring](https://docs.aws.amazon.com/codepipeline/latest/userguide/monitor-pipelines-cloudwatch.html)
- [GitLab CI Monitoring](https://docs.gitlab.com/ee/ci/pipelines/pipeline_monitoring.html)
- [Jenkins Pipeline Status and Notifications](https://www.jenkins.io/doc/book/pipeline/syntax/#post)
