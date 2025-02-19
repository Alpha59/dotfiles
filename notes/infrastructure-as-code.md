# Infrastructure As Code

Infrastructure as a code is any system or tool that is used to manage resources and provision computer through machine executable files, rather than physical configuration - or the use of interactive configuration tools. Infrastructure as code is often version controlled, and offers a number of benefits over alternative infrastructure management systems. Since infrastructure as code (IaC) requires the use of virtual machines and provision-able capacity, bare-metal servers can not be managed through IaC. For this reason, IaC is primarily associated with cloud computing service providers. For purpose of this document, the Amazon Web Services (AWS) Cloud Computing Service will be examined, although IaC exists for many major cloud computing services.

The 2006 launch of AWS Elastic Compute Cloud began the genesis of large scale web services being launched through smaller enterprises. Although CloudFormation (the original AWS IaC tool) would not be launched until February of 2011, IaC was born through a number of third party providers. These providers utilized the CLI and custom scripting tools to provision and manage resources in AWS or other cloud computing engines. After the release of CloudFormation, many of these providers moved towards utilizing CloudFormation “under the hood”, and worked to extend the CloudFormation feature set with a more scriptable interface. These tools (e.g. Chef, Puppet, TerraForm, Ansible) are known as Continuous Configuration Automation tools, and utilize traditional programming techniques (branch and loop logic) to create infrastructure.

Nearly a decade later, AWS released AWS CDK in July of 2019 - a native solution to the scripting of CloudFormation resources, which helped to improve the manageability of IaC, and reduce the average IaC overhead as much as possible. This is done by providing default values for many of the underlying resources, and providing simpler ways of connecting resources through traditional coding patterns.

## Why Keep IaC?

Many more traditional development groups have grown familiar with the tooling provided by various Cloud Computing resource providers to manage and deploy their infrastructure. These tools replaced older methodologies, and (at the time) were seen as a step forward. Understanding the benefit of IaC can often be difficult, if not impossible for these more traditional development teams. The value of IaC can be broken into three distinct categories though. Speed, Risk, and Cost.

Speed is achieved by reducing the amount of time required to reproduce an existing infrastructure stack. This can be utilized when re-creating an existing application in a new region or environment, or when creating a new application that utilizes familiar resources. Speed is seen when:

* Less time is spent managing resources
* Developers no longer need to provision resources according to undocumented procedures
* Developers no longer need to configure the same resource multiple times.

Risk is minimized when using IaC when developers are able to quickly create repeatable patterns, version their work, and create automated rules that are enforced by IaC opposed to manual auditing procedures.

* Version Control, Code Review, and Rollback capabilities
* Automatic Infrastructure rollbacks from alarms
* Predictable and repeatable
* Leverage AWS scalability tools
* CDK checks for security implications to changes

Cost reduction is achieved by allowing “sane” defaults to be utilized when creating applications, so that enterprise policies can reduce the number of mismanaged resources. Cost can also be seen when speed and risk are improved.

* No more dependency tracking
* Replicate across regions or environments rapidly
* No more resource tracking

## CloudFormation

AWS CloudFormation (CFN) is an AWS Service that allows you to model and set-up your AWS resources so that you can focus on your application that is running in AWS. You can create a template that describes all the AWS resource that you want, and the CFN service will take care of provisioning and configuring those resources to your specification. In a traditional set-up, you would need to use the AWS console to create and provision multiple AWS services - which would then need to be individually configured to work together with the other resources which have been created.  Using CFN you can create or modify an existing AWS CFN template to configure all of the resources you need.

CloudFormation works on two main concepts, Templates and Stacks. A template is a JSON or YAML file which defines all of the resources that will be deployed by the CFN service. Templates are used to describe all of the settings for a resource that will be provisioned. Anything that can be configured in AWS can be configured through the CFN template, and a static resource will be created that reflects the text based template configurations. A template is able to specify multiple resources, so that various pieces of information (e.g. Security Group, VPC) can be passed between these resources and used together.

A CFN template allows a number of input parameters to be passed in through the CFN console. These parameters are often represented by string or boolean variables that allow some simple configurations, such as the environment and stage. These parameters must be defined in the templates, but are not initiated until launch.

The Second concept is the Stack. A stack is the initiated version of a template. The Template (JSON/YAML file) defines what will be deployed in the AWS account - and the Stack is the deployed version. Stacks are the template being put to use. An AWS account may have multiple stack deployments, or a single stack deployment, although CFN limits templates to 200 resources per stack. Before deploying a stack, the CFN service will create a change set, which is the summary of what changes will happen between the previous stack deployment, and the new stack deployment. ChangeSets are useful tools to view and understand how certain changes will have hidden affects before deployment.

### The How behind the magic

Under the surface, AWS CFN makes calls to the underlying AWS service, using the same interface exposed through the CLI, in order to provision and configure the AWS Resources being deployed. CFN can only make changes, and perform actions that the deployer (user or IAM user) has permissions to perform. No additional information is passed through to the AWS service calls, unless it is defined in the CFN template - although, the underlying AWS Service calls may have default values set. These default values are often configured to be reflective of what is expected from bare metal provisioning (e.g. default to not use autoscaling), and it is generally considered a best practice in CFN to define all parameters in the template.

In order to deploy, CFN template files are traditionally uploaded to an S3 bucket in the account, and deployed through the console. Alternatively, a `.zip` file can be created and uploaded directly to the console - which will automatically create a deployment bucket to hold the unzipped Template files. Most enterprises or teams use custom AWS CLI scripting tools to manage deployments, although third party tools and services exist to pull committed  CFN changes and deploy them automatically. In a production environment, it is never recommended to manually modify or deploy changes by uploading them to the AWS Console. Each deployment region is given it’s own deployment S3 bucket - even though S3 is a globally available service. This is a side-effect of uploading a zipped file to the console.

After the first deployment, all other deployments are “ChangeSet” only deployments, meaning that the differences between the old and new CFN template is determined by the CFN service, and only changed deployments need to be made. This allows resources to be preserved (S3 bucket, EC2 instances, IAM users) if they have not been modified, preventing the loss of data or even local memory files.

Since a stack can only be executed with the permissions of the deploying IAM user, templates need to be deployed by an IAM user who has permissions for the stack that is being deployed. This user is often manually configured. If the permissions do not exist for the deployment user, then the stack deployment will fail with error - and may need to be manually rolled back.

All changes to AWS infrastructure are recoded in the AWS CloudTrail. This includes changes made through the Console, CFN, or CLI. The CloudTrail creates an automatic audit history for the account, on a per region basis, and allows in depth tracking of changes over time. Any changes made outside of the CFN ecosystem are recorded in the CloudTrial.

### Using CloudFormation

To get started with CFN, you can export an existing AWS account into a template, allowing you to take a previously configured AWS account - and use it as a baseline template file. Alternatively, for a new application, it is recommended that you use one of the existing template example files provided by AWS or community sources. These templates can give a starting point for many common infrastructure patterns.

The use of JSON or YAML in the template file is a matter of personal preference. Even across a single account, both markup languages can be used to create different stacks. It is considered best practice for only a single template file type be utilized across a single development team. This reduces the possibility to confusion, and allows better re-use of resources.

Only a single resources is needed to be considered a defined CFN template, although normally a single resource is not enough to build the entire application. Since template files (like all markup files) are simply a text file - any file extension can be used. Many organizations prefer the `.template` extension, or the `.cfn` extension to avoid confusion and clarify the purpose of the file. Within a template, any parameters need to be pre-defined. Although only the parameter name needs to be defined, it is best practice to define the type, length, and any other attributes at the time of declaration.

A CFN deployment does not allow users to specify the deployment order. CFN service will do its best to compile resources in a deployment order that reduces downtime by grouping immutable resources together in the most logical order. CFN does not however guarantee that deployments and deployment operations will have no downtime. As resource chains grow more complex, the possibility of downtime is increased. Since the CFN service is managing the deployment however, downtimes are significantly reduced compared to any other deployment strategy.

Any mutable resource will be modified through either the Update or Modify endpoint that is provided by the AWS service - however some AWS resources are not mutable, and will need to use the Delete/Create endpoints. These resources will need to drop or lose any memory that has been created, unless the memory is reserved in another place. A best practice when creating a mutable resource, is to understand that the memory may be erased during deployment - and should therefore be moved to a mutable resource. An example of this is to avoid using environment variables on an EC2 instance - as those environment variables will be lost when the instance is replaced. Alternatively, a mutable resource - like a database, will not lose its memory when being updated.

Development teams can decide how to organize their CFN templates and stacks - but the most common pattern is to utilize the lifecycle expectations, and the ownership to group resources. Another common pattern is to examine how often a resource will be updated, and to group based on the likely-hood that the resource, or dependent resources will need to be modified. Cross stack references can be used to access resources from other stacks in the same account, so it is unlikely that separating resources into multiple stacks will result in an isolated resource that can not be accessed. It should go without saying that the same template should be used to deploy across multiple regions and stages, so that each environment is identical to all other environments.

Since Templates are version controlled resources, credentials should never be embedded into a template. AWS provides a number of different credential services to manage the secret keys that may be needed to access various resources - but IAM roles should always be preferred. Other methodologies include using the AWS System Manager Parameter Store, or the AWS secrets manager to hold credentials. CFN-Gaurd allows you to create a security policy as code, and validate that your template is not in violation of that policy. This methodology is often used as a validation step at the enterprise level to determine if their are new or existing security risks that need to be addressed across a large number or managed resources.

### Protecting your resources

Resources are a precious commodity in the physical world. AWS resources should be considered an infinite well of cheap virtual resources. Once provisioned however, those resources become a precious commodity since they have become unique. This is the concept behind NFTs as well. In order to protect CFN resources, the use of CloudWatch alarms can be used to create configurable rollback triggers based on various thresholds. If a CloudWatch alarm is breached during, or immediately after a deployment, then that deployment can be automatically rolled back. In order to protect your NFT resources, you will need to invest millions of dollars into an NFT eco-system that will not go down because of an error during deployment, and eliminate the record of your NFT. Hopefully, the NFT eco-system you are invested in utilizes automatic rollback deployments through CloudWatch.

Using CloudTrail, you can view the history of the stack, and quickly view all of the resources being used and how they were deployed. This, in combination with CloudWatch, can provide valuable insights into your infrastructure - and help determine if any changes have been deployed without proper authorization.

Further tools are provided by the CLI to validate that a template will be deployable, and view the ChangeSet definition that will be used during the deployment. Some teams go so far as to attach the ChangeSet definition into the body of the Commit or Change Request description.

A StackSet may  be used to manage stacks across multiple accounts and regions with a single operation. StackSets must be deployed from an administrative account - and will need to establish a trust relationship with their target account. Using a single deployment account that managed no other resources is generally considered to be the best way to isolate changes and avoid conflicts between environments.

### Drift

Drifting in your 2005 Subaru is lame. Drifting in your AWS account is dangerous. Drift is the changes made to an account outside of the CFN template, which can include manual changes through the console, or changes made through a CLI or scripting tool. Drift leads to unpredictable behaviors in deployments that can not be properly validated, and will often cause deployment failures on mutable resources. Changes that do not lead to deployment failures, may lead to data loss, or other deployment issues.

Using stack policies is one way to protect against drift, which allows configuration of delete or modification rules - so that only certain IAM user roles are able to make changes. This is often a hinder in the eyes of developers who are used to following tutorials - and find it difficult to adapt to new technologies or technology methodologies.

Another best practice to avoid drift, is the use of a deployment pipeline to deploy resources - which will encourage developers to not manually modify resources in the stack. Some enterprise applications use other AWS services to limit access to only a select team through the AWS console, preventing unauthorized users from creating drift in their stacks.

Drift should be avoided, but can be detected automatically by CloudWatch at either the resource or Stack level. This detection can trigger an Alarm, so that Drifters can be apprehended. Just like Subaru drifters, CFN drifters are a menace to polite society.

## CDK

AWS Cloud Development Kit (CDK) is a software development kit that allows you to define infrastructure in code and deploy it through CFN. CDK supports TypeScript, JavaScript, Python, Java, and C#/.net to define and manage IaC. All TypeScript CDK libraries are generated programmatically from the available CFN templates, and are available immediately. Other supported languages are not automatically programmatically generated, and are implemented in a way that is reflective of the available language patterns - but are cross compiled into TypeScript (executed by Node.js) before being built into their CFN Template.

CDK allows the use of logical operators, and loops to create the CFN template, which provides powerful tools for configuration and development that can greatly reduce the amount of IaC that needs to be managed. This methodology allows the use of Object Oriented programming techniques, high level abstractions, logical module organization, and re-use of library modules to create IaC. CDK also offers unit testing, and as with CFN, can be managed through traditional version control methodologies - including Code Reviews, and version control history.

CDK applications must be written in one of the 5 supported languages, although community consensus due to availability and origin often dictate the use of TypeScript. Although it is logical to consider using a single language across both IaC and application code, TypeScript is the primary managed language of CDK, and all other languages are cross compiled into TypeScript.

### Application Construction

CDK uses the high level abstractions of Constructs to create a resource. Each Construct can be a single resource, or an entire application pattern, depending on the level of abstraction desired. Within the AWS ecosystem, there are a number of available libraries, which can be used to pull in required constructs and manage the type definitions being used.

As with CFN, CDK creates a series of Stacks upon deployment, but stacks are utilized inside the CDK as a way to group application Resources. A resource remains the same across CFN and CDK, referring to the underlying AWS resource or service being instantiated. TypeScript has strict type definitions, which allows various constructs to be utilized and combined, by passing resources by either Name or Reference.

Within various construct types, there are three different levels. Level 1 (L1) constructs are TypeScript constructs generated from the CFN definitions, with no default values assigned. Level 2 (L2) constructs are groupings of curated L1 constructs, with assigned default definitions. Each language outside of TypeScript implements their own L2 and higher constructs, but are always cross compiled into the lowest level (L1) TypeScript constructs. The final level, Level 3 (L3) are a combination of multiple L1 and L2 constructs, combined to create an entire stack definition. These stacks may be complete application patterns with all defaults configured - or a pre-created stack with only a few parameters pre-configured.

```
bucket = s3.Bucket(self, "MyBucket",
bucket_name=“my-bucket”, versioned=true,
website_redirect=s3.WebsiteRedirect(host_name=“[aws.amazon.com](http://aws.amazon.com/)))
```

The above code offers a simple idea of the type of definitions that may be present in an L2 construct. L1 constructs are identified by the prefix of CFN, and should be avoided in TypeScript when creating a stack. If an L1 construct needs to be utilized, a higher level L2 or L3 construct should be created around it. This will allow better re-use of the resource and application defaults when continuing to develop.

Just like any other TypeScript library, CDK code is compiled into Node.js and run through a Node.js interpreter. The JSII cross compiler that is used to convert other supported languages into TypeScript is also a Node.js application. This makes Node.js a requirement for writing, running, and testing CDK applications. Regardless of the language being used, application resources, constructs, and libraries are distributed through the language package management system (npm, pip) and need to be deployed through the package management system in order to be consumed by other applications. Since TypeScript is the primary language recommended for use by the AWS team, and the CDK community, the typescript, and javascript libraries are the most prevalent.

CDK is an open source tool that is managed by the AWS development team. This means that CDK resources may be modified directly by the community, but are curated by the AWS development team. Changes are of course encouraged when required for low level CDK application piping, but higher level library distribution is preferred for deploying Constructs.

When developing in CDK, the CLI `cdk diff` can be used to view a Change Set document between the previously deployed CFN application, and the current CFN application that will be compiled. This differs from Change Sets within CFN, which will examine the actual deployment (including drift) opposed to the locally deployed code compilation.

Just like with all AWS CLI tools, local credentials must be configured, either through environment variables, or the AWS credentials folder. More information on how to create and manage credentials can be seen in the public AWS documentation. CDK is unable to create a new AWS account, and an initial AWS account with corresponding IAM role/user will need to be created before CDK can be deployed.

### Concepts

Various concepts are used to create and manage CDK applications beyond just the L1-L3 level constructs. A CDK application is defined only by the existence of an App (unlike CFN which is defined by the existence of a resource). In order for the App to do anything, it will need to have at least one resource attached to it.

* Resources
    * Resources are the AWS level resources (SQS, Lambda, SNS)
    * Network Permissions are definable on the Resource Level
    * Removal Policies can be specified for resources with persistent data - like retaining information when removed.
        * Default in CDK is to retain data, default in CFN is to delete data
* Constructs
    * A single cloud Resource, which contains all information that CFN needs to create a component
    * A construct can also represent a higher level component consisting of multiple CDK resources
* Composition
    * Compositions are the combination of multiple constructs and can be used to define re-usable and shareable components
* Stack
    * Stack is the composition of resources being deployed to an AWS account
    * The deployment unit with all resources defined
    * Limited by CFN stack limitations (200 resources per stack)
    * Resources can be accessed across stacks, but must be in the same region/account
    * CFN Variables can be used in the generated stack, but are discouraged since they are only known at runtime
* App
    * Apps are the root element that can contain one or more stacks inside of them
    * All CDK programs must have a root App
* Environment
    * The Account and Region where a stack is deployed
    * Each stack needs to be associated with an env
* Metrics/Alarms
    * Resources provide specific defined metrics and alarms that can be automatically triggered into CloudWatch
    * SQS - Too many messages
    * EC2 - High CPU usage
    * API Gateway - High latency
    * These can be defined in CDK architecture
* Event Triggers
    * You can set up an event listener/trigger
    * Run Lambda when resource added to S3 bucket
* Identifiers
    * Created in CDK to define a resource location
    * These must be unique to the Stack, but will be transformed to a universally unique ID later
* Tokens
    * Tokens can be referenced within CDK, but are IDs that are not generated until an app is deployed
* Parameters
    * This is the preferred way to pass in variable data to CDK, and will be specified at application preparation
    * Parameters can be specified in the CLI at the deployment stage
* Assets
    * These are the local files/directories or docker images that can be bundled into a deployment
    * Assets may include handler code for Lambda Functions
    * Assets may include Docker images
    * Assets are initially deployed to S3 or ECR (Elastic Container Repository) and referenced from their handling resources
* Runtime Context
    * Context Values are constant key-value pairs that are defined outside of CDK.

### Life Cycle

Apps all go through a life cycle when being deployed through CDK. This lifecycle is automatically run each time a CDK application is deployed, either through the CLI or any other tooling.

1. Defined in CDK source code
2. Construction or Initialization
    1. This is the phase where application logic and code is executed to form final CDK executable
3. Preparation
    1. This behind the scenes operation creates the final state of all constructs in your Application
4. Validation
    1. Validation methods are run to verify that all resources are configured properly
    2. This stage can be modified to add additional Business Logic Validations
    3. Security validations can be enforced through CFN-Guard
5. Synthesis
    1. This stage creates the final CFN templates, pulls in AWS Lambda Bundles, and Docker Images
    2. These are known as Cloud Assemblies, and should not be modified
6. Deployment
    1. This is where assets are finally deployed to the AWS account and sent where they need to go within the AWS account
    2. Deployment stages can not be controlled in the CDK application
        1. CDK Can’t respond to deployment events
        2. CDK Can’t access variables that are created during deployment

In rare cases, the appropriate resource does not have a specified CDK parameter. In this case, it is possible to pass CFN configurations directly to a resource declaration. Since CDK L1 constructs are programmatically generated for CDK, this situation is only possible in non TypeScript languages.

### MonoCDK

MonoCDK is a library that compiles together all of the available CDK resources in TypeScript into a single import library. MonoCDK does not change any of the default values, but addresses a versioning problem that plagued initial CDK deployment stacks. As CDK evolved, the collection of available NPM modules grew to include a variety of changing, and sometimes incompatible library versions. In order to unify the versioning, MonoCDK condenses the available AWS NPM Library constructs into a single import module.

As of the MonoCDK initial deployment, there were over 150 modules deployed in NPM for AWS Constructs (one for each AWS service). A single module could be dependent on upwards of 50 other AWS owned modules, which all required careful versioning to understand the various dependencies. This means that when a CDK application upgraded a single dependency, the entire dependency tree needed to be managed and updated to the new versions. To avoid this, MonoCDK packages the latest version of all dependencies together.

Since AWS Modules are Type Dependent, even modules which are not being utilized need to be supported and imported, for instance, an S3 bucket with no permissions, still requires the KMS key type to be defined in the application code. This creates a tree of peer dependencies that extends beyond what a CDK user needs.

The major drawback of MonoCDK is the size of the deployment module, which needs to contain all of the available constructs and code.

### MoteCDK

MoteCDK is a secure by default construct library available internally at Amazon. MoteCDK migrated to MonoCDK so that it could be used interchangeably with existing CDK constructs, but implements some sensible defaults for the type construction. Not all AWS CDK constructs are available through MoteCDK, but because it can be used interchangeably with MonoCDK resources, non-implemented CDK constructs can be easily substituted for default constructs.

Mote aims to reduce the amount of CDK code which needs to be configured, and can often reduce CDK implementation down greatly. Most MoteCDK constructs can be used as drop in replacements for the default CDK configurations (`S3.Bucket` becomes `moteS3.SecureBucket`) without additional configuration needs. For every mote configuration, there is an “escape hatch” or override, to allow bypassing mote CDK defaults for personalized configuration.

## CodeBuild vs CodeDeploy vs CodePipeline

Deployment of code in AWS is through three different systems. These systems are not utilized by all applications, but are generally utilized within CDK to ensure the Continuous deployment and Continuous Integration principles are adhered to.

### Code Pipeline

AWS CodePipeline is a CD service used to model, visualize, and automate the steps required to release your software. CodePipeline, like any pipeline tool, automates the steps and rules used to deploy your software.

* Continuous Delivery (CD) is the practice of automated software releases. Software changes are built, tested, and deployed to production without (or with) human interaction.
* Continuous integration (CI) is the practice of using a version control system to frequently merge changes into a central branch or location.

Most teams use CD/CI already, through [pipelines.amazon.com](http://pipelines.amazon.com/) and [code.amazon.com](http://code.amazon.com/) . These practices are neither new, or novel.

A pipeline is composed stages, and actions. Each stage is comprised of one or more actions that are taken on the source code at the latest commit. A pipeline execution is the movement of the source code artifact as it moves through a pipeline. A single pipeline can process multiple executions at once, but each stage can only process a single execution at any time.

As with other pipeline tools, a standard execution path may look like:

* Build
* Verify CR
* Run Unit Tests
* Deploy to Beta
* Manual Approval
* Deploy to Staging
* Run Functional Tests
* Deploy to a single resource in Production
* Run Canary Tests
* Run Integration Tests
* Deploy to remaining Production Resources

Artifacts are the results of a stage execution, and in CodePipeline,  they are stored in a generated S3 bucket that is designated. Each artifact is generated from a stage, and acts as the input artifact for the next stage.

CodePipelines can also be used to deploy CloudFormation files to modify the existing stack or environment. Pipelines can also be specified as part of an AWS CloudFormation (or CDK) template. As a pre-requisite for using CloudFormation to create a codePipeline, you must have created a repository that source code can be pulled from.

CodeBuild is the most used build tool with CodePipeline, and is configured as one of the actions in a stage. CodeBuild will produce an artifact that can be deployed. Deployment is done through CodeDeploy, which can be used to deploy artifacts to ECS or Lambda, as well as a variety of other sources.

### CodeBuild

CodeBuild is a managed build service in the Cloud. CodeBuild compiles your source, runs unit tests, and produces artifacts that are ready to deploy. CodeBuild does not require and managed servers, and scales on demand. CodeBuild supports most major programming languages and build systems, but is used with Docker in many cases.

When using a docker build, CodeDeploy steps may be available by pushing changes directly to Elastic Container Registry. ECR updates will trigger an ECS or Fargate deployment when properly configured.

### CodeDeploy

CodeDeploy is an automated deployment system that can deploy artifacts to a number of sources, including EC2 instances, ECS, or Lambda functions. Any application content can be deployed, as long as an artifact can be created out of the source. This includes Multimedia Files, Code, or Web Style Sheets (CSS).

CodeDeploy is particularly strong at Lambda deployments, where the S3 upload requirement can be automated. For other deployment types (EC2, ECS) CodeDeploy leverages blue/green deployments - where a maximum number of hosts or containers are replaced. Traffic is shifted from the original version of the application to a replacement version of the same service. Traffic shifting can be configured as Canary or Linear deployment types in order to better monitor changes as they are deployed. Blue/Green deployment schemes can be managed through CloudFormation or CDK configurations,

### Internal Pipelines

Internal Pipelines (often references as just pipelines, or [pipelines.amazon.com](http://pipelines.amazon.com/)) exist outside of the AWS ecosystem. Internal pipelines can be used to deploy resources based on a VersionSet only. This limits their ability to be used outside of the Amazon Internal eco system, but allows them to be used for cross-region, and cross account deployments.

At this time, it is recommended to continue using Internal Pipelines - but to configure them through internally available CDK constructs. Unlike traditional CDK constructs, these internal pipeline constructs are not compiled into CFN templates, but instead are interpreted during the Synthesis phase of deployment to query and create pipelines through the internally available Pipelines API. As of this writing, Internal Pipeline Constructs are only available in TypeScript. Although Internal pipelines will be replaced by AWS CodePipelines in the future, it is expected that the internally available CDK constructs will support both AWS and Internal Pipelines - in order to ease developer migration.

### CloudWatch

CloudWatch is an AWS service that allows you to monitor application resources running on AWWS in real time. CloudWatch can be used to collect and Track metrics, display Metrics, and display Logs. Unlike traditional Alarming, logging, and metrics system, CloudWatch can be configured as part of the IaC deployment. This eliminates the possibility that alarms are not configured, and allows additional logic to be implemented regarding how alarms are addressed when their threshold is breached. Configuring CloudWatch as part of an IaC deployment is considered a best practice, and can be tied to the enterprise ticketing system used to monitor applications.

Common use cases are:

* Notify users (Sev2/3/4) when an alarm threshold is passed
* Rollback a deployment when an alarm threshold is passed (or not passed in a given timeframe)
* Change an environment variable if an alarm threshold is passed

Although CloudWatch metrics are designed to be isolated by region, cross region monitoring is statistical aggregation is available using the Cross-Region CloudWatch Console.

Metrics are a central concept in CloudWatch, and are the time-ordered set of data points that are published to CloudWatch. Metrics are variables that are published periodically, or continuously. Metrics like CPU, or Network traffic are automatically supported, but custom metrics can also be configured and published from the application source code. Although every metric is identified by the use of a timestamp, metrics can be multidimensional (limited to 10 dimensions), which are key/value pairs within the metric. These dimensions can be used to filter, or gain statistical insight into the metrics.

Most AWS resources have built in metrics, including RDS, Dynamo, Lambda, and ECS, which are specifically important to the monitoring of those resources.

An important feature of CloudWatch is the use of anomaly detection, and ML to determine if a metric is in Error or not. Many times a deployment, or non-code factor will lead to a metric being temporarily triggered. CloudWatch can be configured to automatically determine if these are simply transient issues, or if users need to be notified. Anomaly detection can also be used to monitor metrics that do not have alarms configured, but that are acting in a way that is unexpected to the CloudWatch algorithms.

Since CloudWatch can post to SNS, some metrics and logs can be configured to notify front-end users, or change variables, post messages, or alert users of information that may affect their experience.

LogEvents can be used to log information that may be relevant to developer attempting to Debug an application behavior. This log information can be configured to include network usage automatically. Log Events can be streamed to an ElasticSearch resource, and queried through Kibana. A single ElasticSearch instance may be used to retain logs from multiple services.

## Conclusion

As with any technical field, the IaC environment as been growing for long time, but is currently experiencing what seems like explosive, exponential growth. Using IaC can change the way that a team or enterprise views and manage their own Infrastructure, and security. Often, IaC will speed development, reduce costs, and mitigate risks that would otherwise be left on the development team to manage. Large scale migrations, new deployments, and extending scalability can be done in minutes, not weeks when using the proper CDK set-up.

Although Amazon teams work on the cutting edge of 2009 technology, migration to AWS allows teams to utilize a series of previously unavailable tools to improve their application structure. By creating these templates, and allowing extensibility through object oriented programming techniques, it is possible to significantly improve a teams Operational Excellence.
* * *
*--wiki-sync: "*[*Users/ailor/InfrastructureAsCode*](https://w.amazon.com/bin/view/Users/ailor/InfrastructureAsCode)*"--*

