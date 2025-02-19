# Nanoservice

A Nano-service is just a tiny Micro-service. Just Kidding.

A Nano-service is a term that is loosely defined, but growing in popularity as a subset of the micro-service genre. Very little strict definition exists, but it is generally considered to be a function level service. Nano-service grew from the growing popularity of AWS Lambda, which was the first Function as a Service provider. This new, completely server-less function execution technology gave rise to the idea that a service would no longer need to encompass all of the related domain logic, but could instead, service only a single functional operation.

In general, nano-services can not provide enough functionality on their own - but are instead, composed together into a series of nano-services which comprise a micro-service. One of the key aspects that separates a nano and micro services, is that nano-services are expected to be functional (same input will always lead to the same output), self-contained (they do not require additional domain logic outside of their inputs), portable (the function can be used through a variety of different caller patterns), and single responsibility (only does one thing). Micro-services on the other hand, are defined as only separated by domain logic, and are not restricted by the same definitions.

Since it is easy to see how the Nano vs Micro service debate is going to break down into a very repetitive conversation about size, let’s all agree that the more important distinction is the usage.

* Micro-services are meant to be used as a full back-end solution to a website or mobile application, offering domain specific logic - often paired with other micro-services to create specific functionality based on their domain.
* Nano-services are meant to be a deployable, re-usable, and useful function that contains the logical information on how to perform one specific action within the domain.

It is easy to see, that a micro-service could easily be comprised primarily (if not entirely) by nano-services, but a nano-service is not able to be built from a micro-service.

Nano-services work to remove the need for scaffolding around the deployment of a unit of business or domain logic. Much like a library, a Nano-service functions only to perform a specific action, which can then be used in numerous other applications. A Nano-service is designed primarily to reduce code duplication, not only across a team, but sometimes across a larger group who may share the same service platform. Since many of the operations that are performed on a regular basis (validation, registration, etc) are used by numerous micro-services, nano-services aim to pull that functionality into a more siloed execution state.

A nano-service is not the overall solution to every problem. Many solutions exist to solve similar problems, including libraries, abstract classes, etc. The design of any architecture needs to be a result of the designers previous design exposure, skill, creativity, and interpretation of requirements. The best architecture is rarely the one that just ticks the boxes in the BRD, but is instead one that uses creative methodology to optimize the solution to ticking all the boxes. Nano-services provide an additional toolset for an architect to consider when designing an application solution.

## Functions as a Service

AWS Lambda kicked off an entirely new form of programming, known as Functions as a Service - which completely abstracted the hardware, server, and everything else, away from the execution of code. Functions can be executed in a wide variety of ways, and were intended to run with as little overhead as possible.

### SAR

The newest innovation in Nano-services is AWS Serverless Application Repository (SAR), which aims to take basic function tasks and distribute them to a wider audience (or internally to a company) to reduce the amount of repeated work.  Some examples of applications already deployed in SAR are:


* Alexa Trivia Skills
* API Gateway to DynamoDB
* S3 Uploader
* Microsoft Office Document Generator

And thousands more. SAR facilitates the wide spread re-usage of logical components that can be used to build a micro-service.

### Cost

Any manager worth their salt will immediately ask the question “Is it cheaper”, which in many cases the answer is “Yes”. In most cases though, the answer will be a resounding... “Ok, so that depends on like 18 unknown factors”. Using functions as a service should not be a cost analysis question, but should be boiled down to making the correct choice for running the technology. Costs within a Function as a service can be significantly reduced by utilizing tips and tricks that minimize execution time, or pre-pay for capacity. So, if a manager asks “Is it cheaper”, the correct answer is


>“By composing this as a function on lambda, we are able to validate that the code is working without worrying about the hardware or provisioning. Once we have determined the efficacy of the solution, it is a two way door to move towards a cheaper technology stack - if that is the best solution for our team”.


If that answer doesn’t work, then you are going to have to run a cost analysis.

### When to use FaaS

FaaS provides a number of benefits, but at the cost of some minor downsides. One downside is of course, the inability to manage the servers, or access server specific functionality. This may include GPU calculations, or random value generation based on the CPU temperature. Lambda’s other downsides include the inability to manage your own security, cold start times, additional expenses in some cases. Understanding the times when it is appropriate to use Functions as a Service can be difficult, but in general:


* Event based execution (SQS message, time)
* Re-usable execution logic (Workflows, nano-services)
* Cold start times (300-500 additional ms average) are acceptable
* No need to manage physical hardware
* Low request volume
* Short running functions (sub 1 second, although limit is up to 15 minutes)

These are all good indicators that FaaS is the best option. There is not a test, or a simple answer to the question. FaaS vs provisioned will ultimately depend on a case-by-case basis.

## Lambda

AWS Lambda is a computing service that allows you to run code without the provisioning, management, or scaling of servers. Lambda executes the code that you have specified based on the trigger set-up, and scales automatically to consume as many, or few, requests as required. Since there is no provisioned server capacity, there is no need to manage resources, memory, CPU, or an event processor; all of these are provided and managed by lambda. Additionally, charges are based on the amount of compute time used - not the amount of idle time. this means that as your application scales, your cost model with scale in direct proportion.

With AWS Lambda, all functions are run in response to “Events”. These events can be almost anything, including an SQS message, a request to API Gateway, a DynamoDB update, or an Alexa trigger. At a high level function is a resource, that processes the event, and the runtime that passes the request and response between Lambda and the Function Code. The Function Code is the specific code written and provided by the developer or development team.

Lambdas are version-able through a system of Qualifiers - which specify an immutable snapshot of the function code to be executed by the trigger. These qualifiers can either be numerical representations of the version, or a named tag which can be used for A/B testing, or specific functionality rollout.

The Lambda Runtime is the language interpreter being utilized by the Lambda to run the Lambda Code. Although there are a number of supported languages, AWS Lambda leans heavily on the preference of interpreted languages. Using an interpreted language can reduce cold start time by more than half, and reduces execution time by a third - when compared to compiled languages on the platform. In a similar vein, the total execution package size is important, as a smaller package is directly proportional to the cold start execution time. Only 3.4% of AWS Lambda applications are run using Java. Compare that to 26.4% of Lambda Applications are running Python, and a whopping 67.6% of Lambda applications are running Node.js.

A Lambda runtime will take in the event data from the trigger, and convert it to an object for processing. The Trigger for a Lambda function is any resource or configuration that causes the Lambda Function to run. Triggers can either be another AWS service configured to invoke the function, or an application that was developed to trigger the function. The most common Lambda triggers, in order are:


* API Gateway - 57.6%
* SNS - 11.8%
* CloudWatch Events - 10.1%
* SQS - 4.2%

DynamoDB and Alexa Skills can also be used to execute a lambda, but are less popular options due to low use volume.

### Programming Model

Although each runtime language has slightly different syntax, each one follows the same pattern. The Handler is the code the is executed, and is a single function. This can be thought of as the main method in many languages. The runtime passes into the handler only two parameters, the Event Object, and the Context Object.

Once a handler has finished executing, Lambda will keep the execution code in memory, and any initialization code can be re-used between executions. After a five minute period with no executions, the memory and initialization code is released. In order to optimize Lambda code, t is best to put any large reusable resources, or static methods into the initialization code of the lambda, so that access to various items (like database connections) can be re-used between executions.

Initialization is however billed as part of the first execution, based on the time it takes to initialize the function. When two processes are being executed in parallel, a second instance is created to handle the second event. This will create it’s own initialization, and work off of the resources created for that instance. Lambda does not provide a way to control which execution is performed on what instance, but does allow the configuration of the number of parallel instances that can be running at any time. This can be particularly useful when time is not a constraint in processing, and you would like all code to be executed using only a single initialization.

Any output from the lambda will be captured and logged into the AWS CloudWatch logs.

Lambda will always scale your functions be running additional instances as the demand increases, or by shutting down instances as the demand decreases. Lambda executions do not guarantee order, so a request may not be processed in the order in which it is received.

It is important to never store Application state in the Lambda, as the state will be eliminated once the instance has been released. Other AWS resources are designed to hold application, or unit state. Local storage and class level objects do exist in the lambda runtime environment, but should not be relied on for consistency of state between executions. Using local storage or class level objects is generally considered an anti-pattern within Lambda, but could have viable use-cases for caching calculated data, or other performance hacks.

For most development teams, understanding the scaling properties of AWS should be completely opaque. Lambda manages the infrastructure, runs the code, scales automatically in response to incoming events, and when needed - Lambda scales vertically and horizontally to allow seamless code execution. If these scaling techniques are not enough to satisfy the needs of your application, it is very possible that AWS Lambda is not the solution that should be utilized.

Batch processing is also supported through the use of Event Source Mappings. This allows Lambda to execute hundreds, or thousands of executions once a large number of events have been collected. The most common use case for this type of processing is with Amazon Kinesis Data Streams, which simplifies the process of sending data to a reporting database or team.

In order to improve developer speed, AWS Server-less Application Repository proves a number of Node.js and Python “Blueprints” that contain example code and configurations for popular lambda actions.

In order for a lambda to access other resources, it will need a properly configured Lambda Execution role. This Lambda execution role will need access to any other AWS services that the Lambda needs to access during code execution.

### Concurrency

As mentioned, Lambda will scale automatically. There are however two additional mechanisms that can be used to control a lambda’s scaling capabilities.


* Reserved Concurrency, prevents a single function from taking over too many resources at once
* Provisioned Concurrency, allows the creation of pre-initialized instances to run the function at all times.

The use of provisioned or reserved concurrency may indicate that an “Always on” solution, such as ECS or EC2 are better fit for an application. The use of both reserved and provisioned concurrency changes the cost model of AWS Lambda, and can decrease performance if improperly configured.

Provisioned concurrency can be paired with AWS AutoScaling, to provide a range of autoscaling supported provisioned concurrency stacks based on the current and predicted utilization of the Lambda invocation model. This allows you to replicate the functionality of autoscaling groups for ECS and EC2, while still working within the nano-programming framework.

### Synchronicity

Lambda functions can be executed as either Asynchronous, or Synchronous events. As expected, Synchronous events require a response to be returned, and asynchronous you do not. For Asynchronous events, Lambda automatically handles the use of retries if the function returns an error, or is throttled. This retry logic can be configured based on requirements, including sending failed requests to a dead letter queue (DLQ).

## API Gateway

AWS API Gateway is the “front door” into your AWS account for accessing public information, or private information exposed through the APIs. API Gateway supports REST, HTTP, and WebSocket APIs at any scale. API Gateway can be configured to work with a number of AWS services, including EC2, Lambda, and ECS. An API, or Application Programming Interface (as API Gateway’s name would suggest that it provides........) gives callers and applications a consistent and integrated experience for building applications that can scale rapidly and efficiently - particularly when paired with any of the AWS Serverless technologies.

API Gateways primary purpose is to handle the accepting, processing, and distribution of up to hundreds of thousands of concurrent API calls. This includes Traffic management, Authorization, access Control, Monitoring, and Version Management. API Gateway can be used in conjunction with either stateless (HTTP), or stateful (WebSocket) APIs. The authentication methods, including AWS Identity, and Access Management policies, Lambda Authorizer Functions, and Amazon Cognito Pool, all provide a secure entry point to the AWS Account.

Features like Canary Releases (a OneBox replacement), CloudWatch (automatic logging of execution), and integrations with AWS Web Application Firewalls, all add to the robust nature of API Gateway. API Gateway works to replace more common WebServers for highly scalable projects.

API Gateway supports three main access types, each with their own benefits.


* REST API
    * A defined HTTP pattern typically used to expose and modify data
* HTTP
    * A general purpose access method that can be used for any API
* WebSocket
    * An open connection that can be used to pass continual data information for near instantaneous real time connections
    * Unlike traditional WebSocket integrations, which maintain a connection to the running code - API Gateway will only invoke an integration when a relevant request is received.

Mock integrations are also available, which do not connect to any backend AWS service, but instead, return pre-defined results based on the inputs to a request.

API Gateway can be configured primarily with the use of OpenAPI (formerly Swagger) to define the input/output of an API definition.

## Herd

Internally to Amazon, a technology called “Herd” is used to orchestrate a series of nano-services together (Coral, ARest, Lambda, HoneyComb) and events (SQS, SNS) into workflows. Workflows are particularly useful when dealing with data that can easily be broken into multiple steps, each steps output becoming the input to the next step. Herd Supports Synchronous, Asynchronous, and Hybrid workflows. Herd aims to provide minimal execution latency to each request, but is still able to process complex “Graphs” or decision trees.

Will herd be replaced by step-functions? Yes. Currently herd has an active development team working through 2022 on adding features that allow N-AWS compliance for all teams. After 2022, Herd will move into a KTLO, but will not be deprecated in favor of Step functions or any other AWS service. Herd will be integrated by end of 2022 with the ORCA team, as well as other internal orchestration systems. Non-AWS Orchestration systems not owned by the ORCA team will be put onto a deprecation path.

Workflows in Herd are represented as Directed graphs, written in XML documents. Herd will sequentially execute each of the states, and action requests - moving the action response data to the next action request upon completion.

## Step Functions

Externally, and on N-AWS Step Functions are used to manage the orchestration of distributed applications. Another AWS technology known as Simple Workflow Service (AWS SWF) exists, and acts in a similar manner - but gives developers a higher amount of control over execution logic. Step functions, like Herd, are able to run at any scale as a server-less architecture, and require no additional work to function at Amazon Scale. Like Herd, Step functions are based on a state machine, which can move through various nano-service callers depending on the return from the previous execution. Just like herd, a number of hosting options are available, but Lambda is the most used. Unlike Herd, Step functions can be integrated with a large number of AWS Services directly from the graph (JSON not XML).

Step functions are broken into two categories. Express and Standard. Express workflows can run for a maximum of 5 minutes, and employ a “Run at least once” model - where executions may be run more than one time, but will always be run once. Standard workflows on the other hand, can run for up to one year, and operate on “exactly-once” execution models. Standard workflows will always run from beginning to end, and will not allow duplicate workflows to be started at the same time. Express workflows can be run multiple times concurrently, and do not validate that there is not a conflicting workflow. For this reason, all express workflow actions must be idempotent.

The state of an individual work item will determine which nano-service action needs to be taken. States are the elements in the state machine, and are referred to by their name, which can be any unique string (unique to the state machine). The state execution order in a step function state machine is defined by the JSON object, which utilizes the Amazon State Language (JSON Schema). A determination can be used inside the Amazon State language to define the input value for a function. This syntax is reflective of JQ’s JSON querying syntax. Similarly, the Results, and the next State Input (ResultPath, OutputPath) can be defined in the same way. This allows various functions to be re-used across various workflows, without needing to account for the larger object being passed through the workflow. It also allows functions to have limited data access, improving data security of the individual functions, and the overall workflow. Step functions can be integrated with a number of AWS Systems, including:


* Lambda
* AWS Batch
* DynamoDB
* Amazon ECS
* SNS
* SQS
* Glue
* SageMaker
* EMR
* CodeBuild
* Other Step functions

This is a powerful tool that extends the functionality of the orchestration layer, so that the composition of nano-services can be separated from the execution ordering.

## Conclusion

Nano-services are a growing trend which help build out more agile programming methodologies in a micro-service framework. They allow for a complete autonomy to be developed within a system, where individual actions (just like code functions) are broken into testable units which perform a single action. This methodology allows systems to be highly configurable, and reduce the amount of code change needed to alter functionality. At the same time, nano-services (if implemented correctly) can reduce costs, and increase stability of a system. In no way do nano-services replace the larger system, but are instead a lower level tool to be used as part of the larger architecture.

As new projects move forward, nano-services are an important addition to the developer toolkit, which should be considered as the smallest consumable unit. They will not always be the most appropriate unit, and do not work well as system orchestrators - but are an excellent tool for creating re-usable function blocks.
* * *

