
# SPIKE: Research Creating Integrations in SNS/SQS for Asynchronous Processing
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)
 As a developer, I want to integrate SNS/SQS to enable asynchronous processing for specific tasks within the service.

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

This story involves setting up SNS/SQS topics and integrating them with Lambda functions for handling asynchronous events.
How to Implement:

1. Create SNS topics for event publishing.
2. Set up SQS queues for consuming events.
3. Configure Lambda functions to subscribe to SNS topics and process messages from SQS.

This must include all current SQS and SNS topics utilized by Pedigree Systems, including:

ReturnOrderCreated
ScreeningCompleted


ect.

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

- Should have SNS topics are configured for event publishing.
- Should have SQS queues are set up for handling asynchronous messages.
- Should have Lambda functions successfully process messages from SQS.
