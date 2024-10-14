
# Fix Cloudwatch alarms
## Summary:
As a developer, I would like to be able to monitor custom coral metrics in cloudwatch.

## Purpose:
In order to do this, we need to enable cloudwatch metrics for custom metrics, and ensure that our program execution can access these metrics.

## Background:
The current system is using lambdas to execute the code behind the API gateway, and custom coral metrics should already be set up. There appears to be a permissions issue that is preventing custom coral metrics from appearing.

## Details:
https://w.amazon.com/index.php/CloudWatchCoralMetricsReporter

## Acceptance Criteria:
This story is complete when:
Given that a lambda has run through a use case which logs metrics, then cloudwatch should display the custom metrics generated from the lambda code.

## Testing:
Testing will need to be performed by manually running the lambda functions

## Pointing Notes:
`This section should be filled in during points poker with any additional questions/notes that are brought up by the members of the team`


