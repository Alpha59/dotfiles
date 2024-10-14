
# Enable CloudWatch logs to send to Kibana
## Summary:
As a developer I want the ability to search through all of my logs in a single location, including logs created by AWS lambda functions, and API gateway. Currently, our AWS Accounts have CloudWatch enabled to view the logs within the amazon console, but it would be nice if the ` accounts were searchable within krl-elk-prod.corp.amazon.com.

## Purpose:
This story will help us ensure a smooth deprecation of M5, by allowing us to much more quickly determine common sources of problems from a single log source.

## Background:
Our Kibana instances are hosted on  Elastic Search Service, and Streaming logs into AESS is already supported in  AWS, so this should be possible using primarily external resources.

## Details:
This story does not have any business rules, nor should there by any code changes. There is a possibility that a new IAM role will need to be added, which should be configured in the CloudFormation Template in the  repo.

## Acceptance Criteria:
This story is completed when Logs for both AWS API Gateway and Lambda are available through Kibana for

## Testing:
Running functional tests against Beta should generate logs.

## External Links:
https://eksworkshop.com/logging/configurecwl/

## Pointing Notes:
`This section should be filled in during points poker with any additional questions/notes that are brought up by the members of the team`

