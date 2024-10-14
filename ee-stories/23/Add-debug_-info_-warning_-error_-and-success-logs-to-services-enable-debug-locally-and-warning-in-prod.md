
# Add debug, info, warning, error, and success logs to services - enable debug locally and warning in prod
### Summary
**As a** DevOps Engineer, **I want** to add logging levels (debug, info, warning, error, and success) to all services, **So That** logs are categorized by severity and provide valuable insights for troubleshooting, monitoring, and system health. Additionally, **I want** to enable **debug-level logging locally** during development and restrict **warning-level logging** in production, ensuring appropriate visibility without overloading production systems with verbose logs.

This story focuses on implementing a structured logging system across all services, defining different log levels, and configuring environment-specific log settings to optimize log verbosity based on the environment (development vs. production).

### Vision
By implementing structured logging with various log levels, we can better manage and filter log data, allowing for efficient debugging, monitoring, and performance analysis. Restricting verbose logging (e.g., debug) in production ensures that critical logs are captured without overwhelming the system, while enabling detailed logs locally helps developers troubleshoot efficiently during development.

### Background
Logs are essential for monitoring application health, diagnosing issues, and gaining insights into the operation of a service. Different logging levels (e.g., debug, info, warning, error, success) help categorize logs based on severity, allowing teams to focus on what matters in each environment. In development, it's beneficial to enable verbose logging (e.g., debug), but in production, only higher-severity logs (e.g., warnings, errors) should be captured to avoid log overload and performance degradation.

### Purpose
The purpose of this story is to implement logging at different severity levels (debug, info, warning, error, success) in all services and configure environment-based log filtering, ensuring that debug logs are enabled locally for development, while only higher-severity logs (e.g., warning and above) are enabled in production.

## Details
### 1. Define Logging Levels
Each service should use the following standard logging levels:

- **DEBUG**: Detailed information, typically useful only when diagnosing problems. This level of logging should be enabled only during local development or troubleshooting sessions.
- **INFO**: General informational messages that highlight the progress of the application at a high level (e.g., starting a service, successful API calls).
- **WARNING**: Indications of possible issues or events that do not immediately impact the functionality but may need attention (e.g., deprecated API usage, retryable failures).
- **ERROR**: Error events that might allow the application to continue running but have a significant impact (e.g., failed API calls, exceptions).
- **SUCCESS**: Log entries that explicitly capture successful operations (e.g., data processed successfully, task completed).

#### Logging Levels Example in Python:
```python
import logging

# Set up logging
logger = logging.getLogger(__name__)

# Define log levels
logger.debug('This is a debug message')
logger.info('This is an info message')
logger.warning('This is a warning message')
logger.error('This is an error message')
logger.log(logging.INFO, 'This is a success message')
```

### 2. Implement Logging Across Services
Ensure that logs are added at appropriate locations in all services, categorized by the defined log levels.

#### 2.1 Where to Log Each Level
- **DEBUG**: Use for logging internal states, variable values, and flow of the application, especially in functions or complex logic.
- **INFO**: Log at service startup, API calls, or key points in the application's operation to track its general progress.
- **WARNING**: Log for recoverable issues (e.g., timeouts, retries, deprecated usage) that may not need immediate attention but should be tracked.
- **ERROR**: Log for critical issues that result in failure, exceptions, or significant problems in application execution.
- **SUCCESS**: Log for confirming that an operation (e.g., task completion, API response, transaction processing) was successful.

#### 2.2 Example of Logging in Service (Python):
```python
import logging

logger = logging.getLogger('my-service')
logger.setLevel(logging.DEBUG)

def process_data(data):
    try:
        logger.debug(f'Processing data: {data}')
        # Process the data...
        result = perform_operation(data)
        if result:
            logger.log(logging.INFO, 'Data processed successfully')  # Success log
        else:
            logger.warning('Data processing returned unexpected result')
    except Exception as e:
        logger.error(f'Error processing data: {e}')
        raise

def perform_operation(data):
    # Simulate operation
    if not data:
        logger.warning('Received empty data')
        return False
    # Simulate successful operation
    return True
```

### 3. Environment-Specific Log Levels
Configure different log levels based on the environment (e.g., local development vs. production). In local environments, **debug-level logs** should be enabled to facilitate troubleshooting, while in production, only **warning-level and higher logs** should be captured to reduce noise and improve performance.

#### 3.1 Configure Logging for Local Development
In local environments, enable **debug-level logging** to capture detailed logs for troubleshooting.

##### Example Logging Configuration in Python:
```python
import os
import logging

def setup_logging():
    log_level = logging.DEBUG if os.getenv('ENV') == 'local' else logging.WARNING
    logging.basicConfig(level=log_level)
```

In this example, the log level is set to `DEBUG` in local environments (controlled by an `ENV` environment variable), and `WARNING` in production.

#### 3.2 Configure Logging for Production
In production environments, set the logging level to **WARNING** to capture higher-severity events only (warnings, errors, and critical issues).

##### Example Logging Configuration in Node.js:
```javascript
const winston = require('winston');

const logger = winston.createLogger({
    level: process.env.NODE_ENV === 'production' ? 'warn' : 'debug',
    transports: [
        new winston.transports.Console({
            format: winston.format.simple(),
        }),
    ],
});

// Usage
logger.debug('Debug log message');
logger.info('Info log message');
logger.warn('Warning log message');
logger.error('Error log message');
```

### 4. Configure Logging in AWS CloudWatch
Ensure that logs from services running in AWS (e.g., Lambda, ECS) are captured in ** CloudWatch** based on the environment-specific log levels. In local environments, logs should be captured at the `DEBUG` level, while in production, they should be filtered at the `WARNING` level.

#### Steps to Configure Logging for Lambda:
1. Ensure that CloudWatch Logs permissions are attached to the Lambda execution role:
   ```json
   {
     'Effect': 'Allow',
     'Action': [
       'logs:CreateLogGroup',
       'logs:CreateLogStream',
       'logs:PutLogEvents'
     ],
     'Resource': '*'
   }
   ```

2. Set environment variables in the Lambda function to control log verbosity:
   ```bash
   ENV=production
   ```

### 5. Configure Logging in Containers (ECS, Kubernetes)
For containerized environments (e.g., ECS, Kubernetes), configure the logging drivers to capture logs at the appropriate level for each environment.

#### Steps for ECS Task Definitions:
1. Define a logging configuration that forwards logs to CloudWatch, adjusting the log level based on the environment:
   ```json
   'logConfiguration': {
     'logDriver': 'awslogs',
     'options': {
       'awslogs-group': '/ecs/my-service',
       'awslogs-region': 'us-east-1',
       'awslogs-stream-prefix': 'ecs',
       'awslogs-create-group': 'true'
     },
     'env': ['LOG_LEVEL']
   }
   ```

2. Set the `LOG_LEVEL` environment variable in the ECS task definition to `DEBUG` in development and `WARNING` in production.

### 6. Monitor Logs in Kibana
Ensure that all logs are forwarded to **Kibana** for easy querying and visualization. Logs should be searchable and categorized by severity level (e.g., debug, info, warning, error).

#### Example of Setting Up Kibana Log Filters:
1. Create log filters in **Kibana** to separate logs based on their severity level.
2. Define dashboards that visualize log trends and error rates, with severity breakdowns.

### Testing
- **Local Environment Testing**: Verify that `DEBUG` logs are visible in local environments and provide detailed information for troubleshooting.
- **Production Environment Testing**: Ensure that only `WARNING`-level and higher logs are visible in production environments.
- **Log Categorization Test**: Confirm that logs are categorized correctly (e.g., debug, info, warning, error, success) and contain meaningful messages.
- **Kibana Log Search Test**: Ensure that logs can be searched and filtered by severity in Kibana, and relevant dashboards display log data effectively.

### External Dependencies
- ** CloudWatch**: For capturing logs from AWS-hosted services (Lambda, ECS).
- **Kibana/Elasticsearch**: For log search, filtering, and visualization.
- **Logging Libraries**: Use logging libraries such as Python `logging`, Node.js `winston`, or Java `log4j` to implement log levels.

## Acceptance Criteria
- Should have added `debug`, `info`, `warning`, `error`, and `success` logs to all services.
- Should have enabled `DEBUG` logging locally and restricted logging to `WARNING` and above in production.
- Should have verified that environment-specific logging works as expected.
- Should have configured CloudWatch and Kibana to capture and display logs by severity level.

### Gherkin
#### Scenario: Logging in Local Development
Given I am running the service locally,
When the environment is set to `local`,
Then `DEBUG`-level logs should be enabled,
And detailed logs should be available for troubleshooting.

#### Scenario: Logging in Production Environment
Given the service is running in production,
When the environment is set to `production`,
Then only `WARNING`-level and higher logs should be captured,
And verbose logs should be disabled.

#### Scenario: Log Categorization in Kibana
Given logs are forwarded to Kibana,
When I query the logs,
Then I should be able to filter by log levels (`debug`, `info`, `warning`, `error`, `success`).

## External Links
- [Python Logging Documentation](https://docs.python.org/3/library/logging.html)
- [Winston Logging for Node.js](https://github.com/winstonjs/winston)
- [AWS CloudWatch Logs Documentation](https://docs.aws.amazon.com/
- [Kibana Documentation](https://www.elastic.co/guide/en/kibana/current/index.html)
