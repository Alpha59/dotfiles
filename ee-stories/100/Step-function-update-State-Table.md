
# Step function update  State Table
## Summary
**As a** Business Operations User **I want** Some functions, including Update  State to be built into my orchestration layer, **So that** I do not need to create a separate lambda for them

## Motivation
After nearly every operation, the device state table will need to be updated with the new state of the device. This should happen using a special lambda function, designed purely to update the DynamoDB  state.

## Acceptance Criteria

* Should be able to post an SQS message, or Call API Gateway with device state document (or a subset of device state document) to update  State Table
* Should use dynamo DB Update expression to update attributes that are present in the subdocument
* Should append to the history array the Calling Lambda function, and parameters
* Should not override attributes that were not updated by the previous method (method should pass in a path parameter with updated fields)
* Should update device state document timestamp and version
* Should update device state when a new state is added

## Details

You can update the document without reading first using the update expressions in DynamoDB:
https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Expressions.UpdateExpressions.html#Expressions.UpdateExpressions.SET

This includes updating a version `SET Version = Version + 1` or appending a history item to the list `SET #history = list_append(#history, :history)`

The Update  State Table should also post a message to DR.R's SQS with the updated document.

The history should be built out to appear as an array of single path step function executions:

```
[
{
    'StartAt': 'Get Document',
    'States': {
        'Get Document': {
                'Type': 'Task',
                'Resource': 'arn:aws:states:::dynamodb:getItem',
                'Parameters': {
                'TableName': '
                'Key': {
                    'ReturnEventId': // Return Event ID
                }
            },
            'ResultPath': '$.DynamoDB',
            'Result': //  State Document
            'Next': 'Get Guidance Rule'
        },
        'Get Guidance Rule': {
            'Type': 'Task',
            'Resource': 'arn:aws:states:::apigateway:invoke',
            'Parameters': {
                'ApiEndpoint': '/v1/fetch-guidance',
                'Method': 'POST',
                'AuthType': 'IAM_ROLE',
                'Data': //  State Document, Station Type
            },
            'Result': // Guidance Document
            'Next': 'Create New Inventory'
        },
        'Create New Inventory': {
            'Type': 'Task',
            'Resource': 'arn:aws:lambda:us-west-1:111122223333:function:CreateNewInventory',
            'Next': 'Move Inventory Item'
        },
        'Move Inventory Item': {
            'Type': 'Task',
            'Resource': 'arn:aws:lambda:us-west-1:111122223333:function:MoveInventoryItem',
            'Next': 'Report Result'
        },
        'Send To Hamlet': {
            'Type': 'Task',
            'Resource': 'arn:aws:states:::sqs:sendMessage',
            'Parameters': {
                'MessageBody.$': //  State Document
            },
            'End': true
        }
    }
},{
    'StartAt': 'Get Document',
    'States': {
        'Get Document': {
                'Type': 'Task',
                'Resource': 'arn:aws:states:::dynamodb:getItem',
                'Parameters': {
                'TableName': '
                'Key': {
                    'ReturnEventId': {'S.$': '$.List[0]'}
                }
            },
            'ResultPath': '$.DynamoDB',
            'Result': //  State Document
            'Next': 'Get Guidance Rule'
        },
        'Get Guidance Rule': {
            'Type': 'Task',
            'Resource': 'arn:aws:states:::apigateway:invoke',
            'Parameters': {
                'ApiEndpoint': '/v1/fetch-guidance',
                'Method': 'POST',
                'AuthType': 'IAM_ROLE',
                'Data': //  State Document, Station Type
            },
            'Result': // Guidance Document
            'Next': 'Create New Inventory'
        },
        'Update Screening Guidance': {
            'Type': 'Task',
            'Resource': 'arn:aws:lambda:us-west-1:111122223333:function:UpdateScreeningGuidance',
            'Next': 'Move Inventory Item'
        },
        'Remove Screening Guidance': {
            'Type': 'Task',
            'Resource': 'arn:aws:lambda:us-west-1:111122223333:function:RemoveScreeningGuidance',
            'Next': 'Report Result',
            'End': true
        }
    }
}
]
```
