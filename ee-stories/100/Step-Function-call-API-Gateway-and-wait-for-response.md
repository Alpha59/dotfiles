
# Step Function call API Gateway and wait for response
## Summary
**As a** developer **I want** to confirm that my actions are working properly before deploying more **So that** I do not need to make changes in the future.

## Motivation
This is essentially an end-to-end bug bash of adding and executing a single Step function action that queries an API Gateway endpoint

## Acceptance Criteria/Details

* Should be able to create a  Step function Step in the CDK package that defines Calling the an API Gateway Endpoint Lambda with the Entire  State Document, workstation information, and additional information relevant to the endpoint defined in DROP
* Should see the  CDK Package deploy through the pipeline, and create the  Step Function Action via API Call in the packaging stage.
* Should be able to Assign Step Function action through DROP To a  and associate a label type to the Step Function Action
* Should be able to run a (fake) device through the assigned workflow and get a response from API Gateway.
