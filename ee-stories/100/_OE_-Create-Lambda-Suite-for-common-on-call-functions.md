
# [OE] Create Lambda Suite for common on-call functions
## Summary
[//]:# (This summary frames the development of an AWS Lambda function to automate handling basic on-call tickets through the AutoSIM tool. The function will address common on-call issues, improving efficiency and reducing manual ticket handling.)

**AS a** on-call team member,
**I WANT** an AWS Lambda function that automates responses and actions for common on-call tickets,
**SO THAT** we can streamline the handling of routine issues and improve response times for these tickets.

**AS a** on-call team member,
**I WANT** a CDK package to create and configure an AWS Lambda function for AutoSIM,
**SO THAT** the automated handling of on-call tickets can be efficiently activated and maintained.

## Additional Context
[//]:# ()

The new Lambda function will integrate with the existing AutoSIM system, utilizing a script to invoke specific actions based on the type of on-call ticket. This automation will handle tasks such as changing device priorities, managing warranty service requests, mapping defect codes, and managing peak scaling requests.

This AWS Lambda function will significantly reduce the manual effort required for these routine tasks, allowing the support team to focus on more complex issues.

Here is an example AutoSim Script to run a lambda function:

```
// Invoke lambda
let lambda = await lambdaFactory.createLambda(
    'arn:aws:iam::<lambda-account>:role/<lambda-name>',
    'us-west-2');

const payload = {
    'issue': issue
}

const response = await lambda.invokeFunction({
  FunctionName: '<function-name>',
  Payload: {
      'resource': '/',
      'path': '/',
      'httpMethod': 'POST',
      'body': JSON.stringify(payload)
  },
});


    let thread = await sim.createThread({
        conversation: {
            message: response.body,
            contentType:'text/amz-markdown-sim'
        },
        email: false,
        name: 'Announcements',
        owningIssue:issue.id
    }).promise();
    await issue.edit({path: '/stickyThreadId', editAction: 'PUT', data: thread.id});
```

These criteria will ensure that the Lambda function is not only created but also properly configured and ready for integration with the AutoSIM system to automate the handling of routine on-call tickets.

The CDK package will facilitate the setup, deployment, and configuration of the Lambda function, ensuring it is optimized for integration with AutoSIM. This setup includes defining the necessary roles, permissions, and environment settings to allow the function to execute based on specific ticket triggers within AutoSIM.

## Acceptance Criteria
[//]:# (These criteria specify the requirements the completed function must meet, ensuring all actions are automated correctly and are triggered by the appropriate ticket types.)

- Should have created an AWS Lambda function using AWS CDK that encapsulates the logic for handling specific on-call ticket types.
- Should have configured the Lambda function with the necessary IAM roles and policies to interact securely with other AWS services and the AutoSIM system.
- Should have defined environment variables and other configurations essential for the Lambda function’s operation within the CDK script.
- Should have deployed the Lambda function to the correct AWS region and ensured it is accessible by the AutoSIM system.
- Should have verified that the Lambda function can be triggered by AutoSIM when specified on-call tickets are received.
- Should have implemented logging and monitoring capabilities within the Lambda function to track its execution and performance.
- Should have created a feedback mechanism so that the AutoSIM can comment on the ticekt
- Should have configured lambda to run different functions based on ticket type.
