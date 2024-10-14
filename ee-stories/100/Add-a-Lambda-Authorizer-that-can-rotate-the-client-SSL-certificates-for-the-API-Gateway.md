
# Add a Lambda Authorizer that can rotate the client SSL certificates for the API Gateway
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

As a backend developer, I want a Lambda Authorizer to rotate client SSL certificates for the API Gateway so that we can regularly update and enhance the security of our application.

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

Implement a Lambda Authorizer function responsible for rotating client SSL certificates associated with the API Gateway. This function should be triggered periodically or in response to specific events. The Lambda Authorizer will authenticate the request, ensuring that only authorized and authenticated clients can update SSL certificates.


## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

* Should have a Lambda Authorizer function created as a Custom CDK Resource that is triggered on a scheduled basis or in response to specific events.
* Should have the ability to authenticate and authorize requests to update SSL certificates for the API Gateway.
* Should have logic to rotate client SSL certificates associated with the API Gateway.
* Should have appropriate error handling and logging mechanisms.

