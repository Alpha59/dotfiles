## Summary
**As a** DevOps engineer or software development team, **I want** to develop and deploy a source-controlled tool or script to query logs and determine customer impact during high-severity events, **so that** we can quickly assess the extent of customer-facing issues, improve response times, and take targeted action to resolve the incident.

During high-severity events (e.g., Sev1 or Sev2), understanding the scope and impact on customers is critical to implementing an effective response and communication strategy. Automating the process of querying logs and identifying customer impact provides real-time visibility into which users or systems are affected, reducing incident resolution times.

### Vision
By developing a source-controlled script or tool, the team will have an automated and standardized method for querying logs during high-severity events. This will allow the team to gather critical information on customer impact in real-time, enabling faster decision-making and targeted mitigation. The script will be part of the team’s version control system, ensuring it is easily accessible, auditable, and continuously improved.

### Background
During high-severity incidents, teams need to quickly understand which customers or services are impacted by the issue. Manually analyzing logs can be time-consuming, error-prone, and inefficient during such critical times. A source-controlled tool or script will allow the team to automate log analysis, providing faster and more accurate insights into the customer impact of high-severity events. The tool can query centralized logging systems (e.g., AWS CloudWatch, ELK Stack, Datadog) and summarize the number of affected customers, service outages, or performance degradations.

### Purpose
The purpose of this story is to develop a script or tool that can be deployed quickly during high-severity events to query logs from a centralized logging system and determine the customer impact. The tool will be integrated into the team’s source control system, ensuring versioning and auditability, and will provide clear output on affected customers, systems, or transactions.

## Details

### 1. **Identify Log Sources and Metrics**
   - **Log Sources**:
     - Determine the log sources that will be queried during high-severity events. These may include application logs, error logs, API logs, and other system logs stored in centralized logging solutions.
     - Example log sources:
       - **AWS CloudWatch Logs**
       - **Elastic Stack (ELK) Logs**
       - **Datadog Logs**
       - **Kibana**
       - **Splunk**

   - **Key Metrics to Track**:
     - Identify the key metrics to query in the logs to assess customer impact, such as:
       - Number of failed transactions (e.g., HTTP 5XX errors).
       - Number of affected customers (e.g., unique user IDs, customer IDs).
       - Frequency of specific error codes (e.g., timeout errors, connection failures).
       - Performance degradation metrics (e.g., increased latency, dropped connections).

### 2. **Define the Tool's Functional Requirements**
   - **Querying Capabilities**:
     - The tool should be able to query logs based on various criteria, such as timestamps, error types, impacted services, or customer identifiers. It should be flexible enough to handle different log formats and provide summarized output.
     - Example:
       - Query logs for HTTP 500 errors in the last 30 minutes and count affected customers.

   - **Output Format**:
     - The tool should provide a clear and actionable output, summarizing customer impact, such as:
       - Number of affected customers.
       - List of affected customer IDs or transactions.
       - Error type and frequency.
       - Time range of the incident.

   - **Error and Exception Handling**:
     - The tool should handle errors gracefully, such as failed log queries or unresponsive logging systems, and provide meaningful error messages to the operator.

   - **Scalability**:
     - The tool should be able to handle large-scale incidents involving significant log volumes and multiple services. It should efficiently process log queries even during high-traffic periods.

### 3. **Development Approach**
   - **Language and Framework**:
     - Choose an appropriate programming language and framework for developing the tool, considering the integration with existing infrastructure and centralized logging systems.
     - Example choices:
       - **Python**: Using the **Boto3** library to query AWS CloudWatch Logs, or **Elasticsearch-py** to query ELK logs.
       - **Shell Script**: Using **AWS CLI** or **curl** for quick log queries in environments where simplicity is key.

   - **Source Control Integration**:
     - The tool should be source-controlled using Git (e.g., GitHub, GitLab, Bitbucket) to ensure versioning, collaboration, and auditability. This allows the team to improve the tool over time, track changes, and ensure that the correct version is used during incidents.
     - Example Git commands:
       ```bash
       git init
       git add query_tool.py
       git commit -m "Initial commit of log query tool"
       git push origin main
       ```

   - **Modular Design**:
     - Design the tool in a modular fashion so that new log sources, error types, or query parameters can be added easily. This ensures flexibility and adaptability as the system evolves.

   - **CLI or Web-Based Interface**:
     - Decide whether the tool will be a command-line interface (CLI) or a web-based tool. A CLI is simple and quick to deploy, while a web interface could provide more usability for non-technical team members.
     - Example CLI usage:
       ```bash
       ./query_logs.py --start-time "2024-10-09T10:00:00Z" --end-time "2024-10-09T10:30:00Z" --error-type "HTTP500" --output "summary"
       ```

### 4. **Tool Implementation**
   - **Querying Centralized Logs**:
     - Implement functions to query logs from centralized logging systems such as AWS CloudWatch, ELK, or Datadog. Use APIs or SDKs provided by these services to fetch logs based on specified filters (e.g., error type, time range).
     - Example for AWS CloudWatch (Python + Boto3):
       ```python
       import boto3
       import datetime

       def query_cloudwatch_logs(log_group_name, start_time, end_time):
           client = boto3.client('logs')
           response = client.filter_log_events(
               logGroupName=log_group_name,
               startTime=start_time,
               endTime=end_time,
               filterPattern='ERROR'
           )
           return response['events']
       ```

   - **Processing and Summarizing Logs**:
     - Parse the logs returned from the queries and extract relevant metrics such as the number of affected customers, error frequency, and any identifiable patterns. Summarize these findings into a concise report.
     - Example of summarizing log results:
       ```python
       def summarize_logs(logs):
           customer_ids = set()
           error_count = 0
           for log in logs:
               if "customerId" in log['message']:
                   customer_ids.add(log['message']['customerId'])
               error_count += 1
           return {"error_count": error_count, "affected_customers": len(customer_ids)}
       ```

   - **Output and Reporting**:
     - Provide the output in a structured format (e.g., JSON, CSV, or a plain-text summary). Ensure the output is easily interpretable and actionable, highlighting key statistics about the customer impact.
     - Example JSON output:
       ```json
       {
           "start_time": "2024-10-09T10:00:00Z",
           "end_time": "2024-10-09T10:30:00Z",
           "error_type": "HTTP500",
           "affected_customers": 145,
           "total_errors": 230
       }
       ```

### 5. **Testing and Validation**
   - **Unit Testing**:
     - Write unit tests for individual components of the tool, such as log querying, log parsing, and report generation. Ensure that the tool works as expected across various scenarios and log types.
     - Example of a unit test in Python (using **pytest**):
       ```python
       def test_summarize_logs():
           logs = [
               {"message": {"customerId": "123", "error": "500"}},
               {"message": {"customerId": "456", "error": "500"}}
           ]
           result = summarize_logs(logs)
           assert result['affected_customers'] == 2
           assert result['error_count'] == 2
       ```

   - **Integration Testing**:
     - Test the tool's integration with the actual log sources (e.g., CloudWatch, ELK) to ensure that it can query logs in real-time and produce accurate results during high-severity events.

   - **Load Testing**:
     - Simulate a high-volume incident and run the tool to ensure it can handle large-scale log queries and still provide timely output. Optimize performance where necessary to avoid timeouts or delays during critical incidents.

### 6. **Deployment and Documentation**
   - **Deploy the Tool**:
     - Ensure the tool is deployed in an environment that can be accessed during incidents, such as a shared development server, a CI/CD pipeline, or a serverless environment (e.g., AWS Lambda).
     - Example for deploying a Python tool:
       ```bash
       pip install -r requirements.txt
       python query_logs.py --start-time "2024-10-09T10:00:00Z" --end-time "2024-10-09T10:30:00Z" --error-type "HTTP500"


       ```

   - **Documentation**:
     - Document how to use the tool, including command-line options or configuration settings. Provide usage examples and instructions for troubleshooting or updating the tool in source control.
     - Example documentation snippet:
       ```markdown
       ## Log Query Tool Usage

       To query logs for HTTP 500 errors between specific timestamps:

       ```bash
       ./query_logs.py --start-time "2024-10-09T10:00:00Z" --end-time "2024-10-09T10:30:00Z" --error-type "HTTP500"
       ```

       ### Available Options
       - `--start-time`: Start time for log query (ISO8601 format).
       - `--end-time`: End time for log query (ISO8601 format).
       - `--error-type`: Type of error to query (e.g., HTTP500).
       ```

### Testing
- **Real-Time Incident Testing**:
   - Test the tool during a controlled or simulated high-severity event to ensure it queries logs correctly and outputs meaningful information regarding customer impact.

- **Performance Testing**:
   - Run performance tests to ensure the tool can handle querying logs in high-volume environments without delays or resource exhaustion.

### External Dependencies
- **Centralized logging platforms** (e.g., AWS CloudWatch, ELK Stack, Datadog) for querying logs during incidents.
- **Source control tools** (e.g., GitHub, GitLab) for versioning and collaboration on the script/tool development.
- **CI/CD tools** (optional) for automated deployments and updates.

## Acceptance Criteria
- Should query logs from centralized logging systems (e.g., AWS CloudWatch, ELK, Datadog) and summarize customer impact during high-severity events.
- Should be source-controlled and available in Git for versioning and collaboration.
- Should handle large-scale incidents and provide accurate, timely reports on customer impact.
- Should provide meaningful output, including the number of affected customers and error type/frequency.

### Gherkin
```gherkin
Given a high-severity incident occurs
When the tool is run with the appropriate time range and error type
Then the tool should query logs and summarize the customer impact
And the summary should include the number of affected customers and total errors.
```
```gherkin
Given the tool is source-controlled
When the development team needs to update the log query logic
Then the changes should be tracked in Git
And the team should be able to pull the latest version of the tool.
```

## API
N/A

## External Links
- [AWS CloudWatch Logs Insights Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html)
- [Elasticsearch Python Client](https://elasticsearch-py.readthedocs.io/en/v7.10.0/)
- [Datadog Log Management Documentation](https://docs.datadoghq.com/logs/)
