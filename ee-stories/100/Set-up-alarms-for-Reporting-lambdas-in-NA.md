
# Set up alarms for Reporting lambdas in NA
Summary:
As I developer I want to be notified if our reporting lambdas Errors during the processing of any records, or if the age of the DynamoDB iterator has surpassed 100,000ms.

Purpose:
This story works to ensure that we have operation excellence across all of our platforms, and ensures that if reporting encounters errors, we are prepared to handle these errors as quickly as possible.

Background:
Currently in our system we have a DynamoDB stream which is processed by a Lambda on the  account. This Lambda takes records, and puts them into our redshift cluster for use by reporting.
When processing records, there is the possibility of a fault, which will cause the Lambda function to cease processing of the rest of the DynamoDB Records.

Details:
The following Wiki can be followed to set up these rules:
https://w.amazon.com/bin/view/KOMPAS/

We want to add rules to our Reporting Lambdas in  for StandardReturnEvents and Containers on both `iteratorAge` and `Errors`.
The `iteratorAge` should throw a Sev3, and any `Errors` should throw a Sev2.

Acceptance Criteria:
This story is completed when we have 4 Carnival Alarms created that cut tickets to our CTI when the CloudWatch alarms have been triggered.

Testing:
This story will need to be tested in production by creating a failed record.

External Links:
https://docs.aws.amazon.com/
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-cloudwatch-createalarm.html
https://w.amazon.com/index.php/Carnaval
https://www.bluematador.com/docs/troubleshooting/aws-lambda-iterator
https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Streams.Lambda.html

Original Ticket: https://issues.amazon.com/issues/KRL-3351

Pointing Notes:
`This section should be filled in during points poker with any additional questions/notes that are brought up by the members of the team`
