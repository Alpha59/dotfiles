# Personal Development on AWS

As part of the Advanced Planning and Scheduling team’s NAWS migration efforts, the team transitioned two Coral/REST services and one Horizonte/REST service from EC2 on Apollo to ECS/Fargate. In line with the Builder Hub Golden Path and AWS best practices, the team replaced Odin dependencies with permissions granted through IAM roles. As an initial quick and easy local development setup, the team leveraged RDE to run the services locally using the deployed IAM roles for permissions. Though this tactic is effective for testing individual services, it has shortcomings when attempting to connect multiple services and run the APS full stack. Furthermore, CDK changes to AWS infrastructure needed to be tested in our shared Beta account. As a result, the team made the decision to switch to personal AWS account for local development and testing.

This document looks to provide steps for APS developers to provision a personal AWS account, to bootstrap the account for CDK deployments, and to deploy the Coral and Horizonte services to the same account. In order to best use this guide, you should be familiar with the APS Coral and Horizonte services, know about the basic CDK deployment commands, and have local workspaces with each of the services and CDK packages prepared. After completing the steps in this guide, a developer should be able to test the Coral Materials or Planning service independently through Coral Diver as well as test the Horizonte Portal service with either the Beta or Alpha Coral backend. Lastly, this setup should allow developers to use the APS backend with their locally running version of the OpsCentral UI. This replicates the functionality of the MAWS full stack testing, allows for more in depth testing for infrastructure changes, and allows for greater flexibility as it relates to debugging options.

More high level details regarding basic CDK deployments and the APS setup can be found in the related guide:

[APS NAWS Development Guide](https://quip-amazon.com/JhbcAQGdvUG4)

# 0. Stacks and Tips

## 0.1. Stacks by Service

Below are the stacks for each service, ordered roughly by deployment order.

Note that because of the SuperStar setup of ADAPSPortalFargate connecting to both the Alpha and Beta stage of ADAPSMaterialsServiceFargate and ADAPSPlanningServiceFargate, you must complete the Portal setup either first or last. If the Portal setup is attempted when the Materials/Planning cluster stacks have been deployed, but the service stack has not deployed, you will receive errors about AZ mismatches.

**ADAPSMaterialsServiceFargate**

* VPC
    * Creates the service VPC and subnets
* DNS
    * Creates the service domain name
* Storage
    * Creates the python lambda and S3 bucket needed for the CTB upload
* Cluster
    * Creates the SuperStar resources, log groups, and NLB resources
* Service
    * Creates the service itself, the task instance role, and grants permissions to the task instance role


**ADAPSPlanningServiceFargate**

* VPC
    * Creates the service VPC and subnets
* DNS
    * Creates the service domain name
* Cluster
    * Creates the SuperStar resources, log groups, and NLB resources
* Service
    * Creates the service itself, the task instance role, and grants permissions to the task instance role


**ADAPSPortalFargate**

* VPC
    * Creates the service VPC and subnets
* DNS
    * Creates the service domain name
* GatewayDNS
    * Creates the API Gateway domain name
* Storage
    * Creates the python lambda and S3 bucket needed for the CTB upload
* Cluster
    * Creates the SuperStar resources, log groups, and NLB resources
* Brass
    * Creates the resources for Brass authorization
* Service
    * Creates the service itself, the task instance role, and grants permissions to the task instance role
* APIGateway
    * Creates the API Gateway used to access the Portal service

## 0.2. Debugging by Stack Type

If there is an issue with stack deployments, the best method for debugging is to use CloudFormation to confirm the exact error in the “Events” tab. If the stack deployed successfully, the following will apply regarding debugging steps.

* VPC
    * Confirm correct number of subnets
* DNS
    * Use dig to confirm domain
        * `dig NS ``[brehog.planning.adaps.devices.amazon.dev](http://brehog.planning.adaps.devices.amazon.dev/)`
* Storage
    * Confirm S3 bucket name
        * Update references to S3 bucket in service code
* Cluster
    * Confirm VPC ES has been added to SuperStar alpha stage
* Service
    * When the tasks hang during startup, the Application logs or the Application-STDOUT will be the best place to check for a specific error message
    * Activity testing via either coral diver or direct REST call

# 1. General Setup

[Materials Coral Diver](https://coral.amazon.com/ADAPSMaterialsServiceFargate)

[Planning Coral Diver](https://coral.amazon.com/ADAPSPlanningServiceFargate)

## 1.1. Creating a Personal AWS Account

For this section, we will use conduit to create an account

https://conduit.security.a2z.com/create-account

Parameters for creation

* Account Name: This can be whatever you want, I recommend something simple such as brehog-dev
* Account Email: [brehog+dev@amazon.com](mailto:brehog+dev@amazon.com)
* Fleet: ADAPS AWS Dev Accounts
* Region: AWS Global
* Bindle: ADAPSDev
* Account Usage: Development


Once you create an account, it can take a few hours for it to get created and be ready for use

**Optional**: Update AWSRegion to be us-west-2

The ADAPS team is granted permissions on the [ADAPSDev Bindle](https://bindles.amazon.com/software_app/ADAPSDev). If future permissions are required, it is best to add them to this group so that everyone on the team can be given the same permissions.

After creation, it can also be worth updating the defaults for your new  account. For example, you may want to update the default region to be us-west-2. This can be done in conduit by selecting the field you want to change and editing the attributes for that field.


## 1.2. ADAPSBaseCDK Initial Changes

In order to deploy development stacks, you will want to check out and modify ADAPSBaseCDK locally. ADAPSBaseCDK is setup with developer account constants that will be used across service CDK deployments. After creating your personal development account, you will want to update the `dev-accounts/constants` to include your account details. The key updates are as follows:

1. Update the [ALIAS_TO_DEV_ACCOUNT_NUMBER](https://code.amazon.com/packages/ADAPSBaseCDK/blobs/a33fffc3586951b1ef69ccff9a0bccd3e8f26a51/--/src/dev-accounts/constants/constants.ts#L11) map to have your alias and dev account number
    1. **Commit this change and make a CR to finalize**
    2. This change will need to be committed, since the DEV_ACCOUNT_NUMBERS are referenced in a few other CDK locations, and we will want to keep all of our developer accounts
        1. Example: https://code.amazon.com/reviews/CR-101428864/revisions/1#/comments
2. Update the developerAlias to be your own alias
    1. This change does not need to be committed, but this will help to populate the developmentStageDetails with your account number and alias
    2. Your own alias will be used in future resource creation such as the S3 bucket and domain name
3. One thing to keep in mind during service deployments is the [createAllegianceRole](https://code.amazon.com/packages/ADAPSBaseCDK/blobs/48c0789cd46e4aa54f2210e997293d89cff18610/--/src/dev-accounts/constants/constants.ts#L25) flag
    1. An IAM role with the same name is created in both Planning and Materials’ Cluster stack, because of this conflicting resource you will want to have the flag set to true when deploying the first Cluster stack but set to false when deploying the second Cluster stack
        1. If you have the flag set to true in both cases, you will get an error about attempting to create a resource with a conflicting name
        2. If you have the flag set to false in both cases, you will lack a critical role required for Allegiance onboarding
    2. More details can be found in the Coral-specific section [3.4. Creating Allegiance Roles](https://quip-amazon.com/isiaARvLMcM4#temp:C:ccc6f98b28aa8b54e9e82213cc27)

## 1.3. Deploying the First Stack & Bootstrapping

Refresh your account credentials using the following:

`ada credentials update --account <account number> --role IibsAdminAccess-DO-NOT-DELETE --provider conduit --once`

You will oftentimes get errors regarding expired credentials when attempting CDK deployments or attempting a CDK deployment in a new account. The above command will be handy to grapple with those errors.

The first time you deploy to a new region in your development account, you will likely encounter errors similar to the one attached.

```
ADAPSMaterialsServiceFargate-Dns-development:  start: Publishing 1f0dda537c3c0d2dba68f1a0ea1c1f43972083231366cd02c693c7920e63b7d6/artifact:development-295621963539-us-west-2
ADAPSMaterialsServiceFargate-Dns-development:  fail: No bucket named 'deploymentbucket-9fbeec3e2f9c8c906736e3adf0c5c025c7712ca5'. Is account 295621963539 bootstrapped?
ADAPSMaterialsServiceFargate-Dns-development:  fail: No bucket named 'deploymentbucket-9fbeec3e2f9c8c906736e3adf0c5c025c7712ca5'. Is account 295621963539 bootstrapped?
ADAPSMaterialsServiceFargate-Dns-development:  fail: No bucket named 'deploymentbucket-9fbeec3e2f9c8c906736e3adf0c5c025c7712ca5'. Is account 295621963539 bootstrapped?

 ❌ Deployment failed: Error: Failed to publish asset ae967c277459e8936ac565a71d34ea5dcff7b98e556466c36a4d6da023a2d9aa:development-295621963539-us-west-2
    at Deployments.publishSingleAsset (/local/home/brehog/brazil-pkg-cache/packages/CDKBuild/CDKBuild-4.x.143315.0/AL2_x86_64/DEV.STD.PTHREAD/build/staging-cdk/node_modules/aws-cdk/lib/index.js:415:11819)
    at process.processTicksAndRejections (node:internal/process/task_queues:95:5)
    at async Object.publishAsset (/local/home/brehog/brazil-pkg-cache/packages/CDKBuild/CDKBuild-4.x.143315.0/AL2_x86_64/DEV.STD.PTHREAD/build/staging-cdk/node_modules/aws-cdk/lib/index.js:415:151100)
    at async /local/home/brehog/brazil-pkg-cache/packages/CDKBuild/CDKBuild-4.x.143315.0/AL2_x86_64/DEV.STD.PTHREAD/build/staging-cdk/node_modules/aws-cdk/lib/index.js:415:137075
```

This is because the account is not bootstrapped and set up for CDK deployments. You can bootstrap your account with the following command:

`bb cdk bootstrap aws://<account number>/us-west-2`

We also create a personal bootstrap stack for the development stage. Deploy this stack to your development account using the following:

`brazil-build bootstrap BONESBootstrap-<alias>-<account number>-us-west-2`

Another potential tripping point is that you do not have the service or service image build locally (including ImageBuild and LogImageBuild packages). Make sure you have these build artifacts as you look to deploy (even if not deploying the service stack).

At this point, your account should be prepared for CDK deploys. Test with the DNS stack using the following command:


>Warning: Make sure that your changes in CR from step 1 in Section 1.2 have deployed through the Beta environment for the service you’re deploying. If that change has not propagated it may prevent DNS delegation from happening successfully, requiring you to delete and recreate your Dns-development stack.


`bb cdk deploy ADAPSMaterialsServiceFargate-Dns-development`

Note that bootstrapping must be done on a region by region basis. Services that require stacks in multiple region, such as ADAPSPortalFargate, will require bootstrapping in each of the regions that you want to deploy to.

It is also worth noting that you should not have to ‘re-bootstrap’ a region if you are deploying a new service to an already bootstrapped region. For example, if you bootstrap us-west-2 from ADAPSMaterialsServiceFargate, you should be able to deploy Planning and Portal stacks to us-west-2 without additional bootstrapping.


## 1.4. SuperStar and More Bootstrapping

Prior to setting up your account for SuperStar, you will see the following error when trying to deploy a stack with SuperStar resources.

`ADAPSPortalFargate-EcsCluster-development failed: Error [ValidationError]: Template format error: Unrecognized resource types: [Retail::ConsumerNetwork::ServiceEnvironment, Retail::ConsumerNetwork::ClientConfiguration]`

The SuperStar service environment is typically set up in the “Cluster” stack for APS services. In order to deploy this stack and move forward with the personal development setup, you will need to modify the service Bindle and bootstrap your account. ADAPSPortalFargate will be used as the example for the following:


1. Find the service Bindle: [ADAPSPortalFargate](https://bindles.amazon.com/resource/amzn1.bindle.resource.ko4htk6g7nlregxtfpsq), [ADAPSMaterialsServiceFargate](https://bindles.amazon.com/software_app/ADAPSMaterialsServiceFargate), [ADAPSPlanningServiceFargate](https://bindles.amazon.com/software_app/ADAPSPlanningServiceFargate)
2. Add your personal AWS account and grant SuperStar permissions
3. Bootstrap the account using the SuperStarPersonalBootstrap stack
    1. `brazil-build cdk deploy SuperStarPersonalBootstrap`
4. Make sure to wait for ALIAS_TO_DEV_ACCOUNT_NUMBER map changes flow to Beta so sharedResourceStack could be updated to retrieve authorization for vpc endpoints creation.
5. Deploy the cluster stack after Bindle modifications, bootstrapping and beta deployment
6. Notes: after setup the first cluster stack, remember to set the createAllegianceRole to false as in this [CR](https://code.amazon.com/packages/ADAPSBaseCDK/commits/48c0789cd46e4aa54f2210e997293d89cff18610?__session=eyJwa2ciOiJBREFQU0Jhc2VDREsiLCJ0YWJzIjpbeyJmaWxlIjoiQURBUFNCYXNlQ0RLL3RyZWVzL21haW5saW5lIn0seyJmaWxlIjoiQURBUFNCYXNlQ0RLL2xvZ3MifSx7ImZpbGUiOiJBREFQU0Jhc2VDREsvY29tbWl0cy80OGMwNzg5YyJ9XX0%3D#), otherwise would receive resource already exists error.

After going through the bootstrapping steps, you will be able to deploy the SuperStar/Cluster stack.


# *The Sections Below are Specific to a Service Type*

My recommendation would be fully completing either the Horizonte or Coral service setup prior to setting up a service of the other type. The best course of action would either be fully setting up the Horizonte Portal and testing it with the Beta Planning/Materials Coral backend or fully setting up the Coral Planning/Materials and testing through Coral Diver.

Horizonte: [2. Horizonte Setup (REST Portal)](https://quip-amazon.com/isiaARvLMcM4#temp:C:ccc78feb22a342e4c84a34ef45e5)

Coral:  [3. Coral Setup (Material/Planning services)](https://quip-amazon.com/isiaARvLMcM4#temp:C:ccc5261fb22e86d4644bf6f9252b)

# 2. Horizonte Setup (REST Portal)

## 2.1. Weblab

Weblab created a whole slue of issues with initial Portal setup. This section is designed to prevent that on subsequent setup attempts and to simplify the process.

If Weblab is not set up, you will see an error similar to the one below when attempting to deploy the ECSService stack in Portal.

`{`
`"log": "+ echo 'Failed to find rodb /var/amazon/metalab/weblab/db/weblab.rodb'",`
`"container_id": "e311c4a425a343c8819bfd5e2b6c15f3-581894629",`
`"container_name": "Application",`
`"source": "stdout"`
`}`

The best way to solve this is to onboard your account to Weblab using their self service UI.

https://weblab.amazon.com/onboarding

Note that the UI oftentimes has intermittent failures when onboarding an account. I had to attempt the onboarding 5 times prior to it working on my dev account. Attached below is their Wiki for ECS services in case there are additional errors outside of what I faced above.

https://w.amazon.com/bin/view/Weblab/Service/WeblabAllocationProvider/1_8/ECS

## 2.2. Modifying Clients for Alpha vs Beta

ADAPSPortalFargate is capable of running in two different ways in a personal AWS account. First, you can run your Portal Service with the Beta Planning and Materials supporting the Coral backend. This configuration is best if you are making a REST only change and there is nothing from Planning or Materials that needs to be modified. Alternatively, you can run your Portal Service with the development Planning and Materials as the Coral backend. This is the ‘development full stack’ approach, and is best suited if you are making a change across all layers of the code base.

In order to support both configurations, the SuperStar environment for Portal Alpha is connected to both Alpha and Beta stages for Planning and Materials. Because of this, to switch between the two configurations, you should **not** need to update any of the CDK code and you should only be required to make **minor client configuration changes**.

Follow these steps to set up the UI:
https://w.amazon.com/bin/view/KOMPAS/Advanced_Planning_Scheduling/Development_Environment/#HSetup
And add your dev desktop url to enable CORS here:
https://code.amazon.com/reviews/CR-112133576/revisions/1#/diff

There are two types of client configurations that must be updated, and the changes to them are as follows:

1. Update the <service>ClientConfig package to change the Java client ([Planning](https://code.amazon.com/packages/ADAPSPlanningServiceFargateClientConfig/blobs/mainline/--/coral-config/ADAPSPlanningServiceFargateAlpha.config), [Materials](https://code.amazon.com/packages/ADAPSMaterialsServiceFargateClientConfig/blobs/mainline/--/coral-config/ADAPSMaterialsServiceFargateAlpha.config))
    1. Pick which of the clients you want to use for the Alpha domain
    2. If you want to connect to your development service, update the Alpha client config to use your alias in the domain name
2. Update the REST client config in ADAPSPortalFargate ([Planning](https://code.amazon.com/packages/ADAPSPortalFargate/blobs/6334199ab33c0a2436da307d94d36c3adbded54c/--/src/com/amazon/adaps/portal/webapp/config/CoralStreamClientConfig.java#L81), [Materials)](https://code.amazon.com/packages/ADAPSPortalFargate/blobs/6334199ab33c0a2436da307d94d36c3adbded54c/--/src/com/amazon/adaps/portal/webapp/config/CoralStreamClientConfig.java#L43)
    1. Pick which of the clients you want to use for the Alpha domain
    2. If you want to connect to your development service, update the Alpha client config to use your alias in the domain name

## 2.3. Errors

### 2.3.1. SuperStar fails to deploy with "no overlapping Azs"

Client and Service both need at least 1 AZ ID that overlaps in order for SuperStar/Private-Links to work (note: AZ ID is different from AZ, a good write up is here: https://docs.aws.amazon.com/ram/latest/userguide/working-with-az-ids.html).

Before you try below, there might be something wrong with the SuperStar app we deploy to by default (I still hit the error below even after changing AZs). Try adding a prefix` -{user}` [here](https://code.amazon.com/packages/ADAPSPortalFargateCDK/blobs/077f13b4e891b5a42405c12fcf9ffd99f4cc2c73/--/lib/ecs_cluster.ts#L210) to deploy to a new SS app.

Since we only deploy our services to [1 AZ by default](https://code.amazon.com/packages/ADAPSPortalFargateCDK/blobs/d6917582b2cc448ce5929096fc606dc047aa6ef4/--/lib/vpc.ts#L66), there’s a chance you’ll hit this error. Golden-path suggestion is that the service should be created in as many AZs as possible to prevent this. If you can’t control the service AZs, then you should increase your `maxAzs` in CDK to increase the chances of overlap. If you’ve already deployed the CDK stacks, you’ll need to delete everything down to the VPC to change `maxAzs` .
**Note:** You will need to manually deregister your VPC ES from SS, and delete the CW log groups for the cluster since they will be retained upon stack deletion. If you don’t your next re-deployment will fail.

# 3. Coral Setup (Material/Planning services)

## 3.1. Adding Permissions to Access RDS

>6/11/24: This section below is outdated. Please follow [APS Publicly Exposed Security Groups](https://quip-amazon.com/ctbfA5X7haqr) for how to grant Material/Planning access to RDS.


[2. Setup guides: APS Publicly Exposed Security Groups](https://quip-amazon.com/ctbfA5X7haqr#temp:C:FNa877e6dacb35e47619c5379e2f) has replaced the section below. Thanks Travis :)

~~Once the ADAPSPlanningServiceFargate and ADAPSMaterialsServiceFargate **VPC Stacks** are deployed into your account, there is a manual step needed to get permissions to access RDS. Currently we have security rules for RDS which only allow access by certain IP addresses, and the IP that your account is using needs to be manually added.~~

~~VPC Stack deployment:~~
~~bb cdk deploy ADAPSMaterialsServiceFargate-Vpc-development (Can be found by using `ls build/cdk.out`)~~

1. ~~Open your AWS account and navigate to **[Elastic IPs](https://us-west-2.console.aws.amazon.com/vpcconsole/home?region=us-west-2#Addresses:)** to find the IP addresses that were created for your Planning and Materials services. There should be 1 IP for each (called Allocated IPV4 address).~~
2. ~~Open the [ADAPS-Test](https://conduit.security.a2z.com/accounts/aws/023336666209/attributes) account.~~
3. ~~Open the “[Security Groups](https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#SecurityGroups:)” page in EC2.~~
4. ~~Find the security group called “RDS Security Group”. You may also be able to access it through [this link](https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#SecurityGroup:groupId=sg-776fd70e).~~
5. ~~Open the “Security Groups” page.~~
6. ~~Add a new rule:~~
    1. ~~Type: Custom TCP~~
    2. ~~Port Range: 8192 - 8200~~
    3. ~~Source: your.ip.address.here/32~~
    4. ~~Description: [Your Alias]-[Planning/Materials]~~
7. ~~Click Save Rules.~~

>~~In the scenario that the security group has reached the maxed number of rules, follow this [guide](https://repost.aws/knowledge-center/ec2-find-security-group-resources) to find another security group that is attached to the same resource~~


~~Your personal dev stack should now have the ability to access RDS. If you ever need to teardown and rebuild your personal stack, this step will need to be repeated (and you should go in and remove the old IPs as well).~~

~~Consider doing [DOS RDS access](https://quip-amazon.com/isiaARvLMcM4#temp:C:ccc61b126761995421cafef19e70) while you have the Elastic IP at the ready as well if you need DOS RDS access.~~

~~Original Exploration for our services: [Cross Account RDS Connection Findings](https://quip-amazon.com/lVPHAQYmumQv)~~

## 3.2. Adding a New CloudAuth Endpoint

This setup is needed for the Materials and Planning Coral services. In order to onboard your development service to authorize using CloudAuth, you need to perform some AAA setup with the task role as well as CloudAuth endpoint onboarding. Deploying the service stack without these steps completed will result in failure. Since we know the name of the service role and the service endpoint based on dev configuration, **we can perform these steps prior to any Service Stack deployment**. Because of the delay in propagating CloudAuth permission changes, it is recommended to do these steps **as early as possible**. The steps are roughly as follows:

1. Add your task instance role to the AAA application under AWS Principal Identities
    1. Materials: https://aaa.amazon.com/applications/amzn1.aaa.app.7zliawhu3g2ri2x34xtq
    2. Planning: https://aaa.amazon.com/applications/amzn1.aaa.app.lkjxudjm62wa6oqerkaa
    3. Portal: https://aaa.amazon.com/applications/amzn1.aaa.app.l6zafj6o6cvorfqukrfq
2. Click on the service under “Exposed Services” to reach the CloudAuth page
3. Add your service endpoint by using “Modify CloudAuth Endpoints for <Service Name>”
    1. Materials: https://aaa.amazon.com/pipelines/new_service_onboarding/continue_migration?service_name=ADAPSMaterialsServiceFargate#onboarding_anchor
    2. Planning: https://aaa.amazon.com/pipelines/new_service_onboarding/continue_migration?service_name=ADAPSPlanningServiceFargate#onboarding_anchor
    3. Default, with IAM authentication

>You might encounter a message saying: “**You are not done! Your clients will not be able to request access to your Service unless you complete Step 4.**

**Click NEXT to continue with the onboarding.**” You can disregard the message if you completed all the steps

1. Once you onboard, your CloudAuth endpoint, you will want to redeploy the service to update the available CloudAuth endpoints that the task can see
    1. Materials: https://coral.amazon.com/ADAPSMaterialsServiceFargate/Alpha/configure
    2. Planning: https://coral.amazon.com/ADAPSPlanningServiceFargate/Alpha/configure
2. Confirm CloudAuth setup via [Coral Diver call](https://coral.amazon.com/ADAPSMaterialsServiceFargate/Alpha/model/com.amazon.adaps.materials%23ADAPSMaterialsServiceFargate/com.amazon.adaps.materials%23ActualizePreApprovedCEISupply?endpoint=https%3A%2F%2Fbrehog.materials.adaps.devices.amazon.dev)
    1. Materials: [https://coral.amazon.com/ADAPSMaterialsServiceFargate/Alpha/explorer](https://coral.amazon.com/ADAPSMaterialsServiceFargate/Alpha/configure)
    2. Planning: [https://coral.amazon.com/ADAPSPlanningServiceFargate/Alpha/explorer](https://coral.amazon.com/ADAPSPlanningServiceFargate/Alpha/configure)


Once again, you will be able to onboard your role and endpoints **prior to any stack deployments** as long as you know your Personal AWS account number and the developer alias you will use for the ADAPSBaseCDK constant. You can pull the role name from other dev account onboardings that have been completed, or follow the pattern below:

Task Instance Roles:  **arn:aws:iam::<account number>:role/<Materials/Planning/Portal>EcsTaskInstanceRole-<alias>**


## 3.3. Allegiance/Coral Diver Setup

For the past 4+ years, Coral Diver has a [restriction](https://sim.amazon.com/issues/CORAL-635) which requires NAWS services to be available in CORP/PROD. From the standpoint of our local development, this translates to us needing to setup an Allegiance endpoint for our Coral development services.

The Allegiance onboarding process is the same as for the deployed services, and can be followed as explained below:

1. Remove the existing Development stage details from the [STAGE_TO_ALLEGIANCE_DETAILS](https://code.amazon.com/packages/ADAPSMaterialsServiceFargateCDK/blobs/83fd99a45173fb559c71465113dd3a6f863e3601/--/lib/constants/constants.ts#L54) constant
    1. This will skip the Allegiance setup initially, but we will redeploy after the VPC Endpoint is deployed
2. Deploy the ECS cluster stack in the personal AWS account
    1. You will need the VPC Endpoint service to add to the Allegiance setup
    2. To verify that you are using the correct VPC Endpoint service you can do the following:
        1. While looking at the [VPC Endpoint Services](https://us-west-2.console.aws.amazon.com/vpcconsole/home?region=us-west-2#EndpointServices:), click on the endpoint Service ID that you want to verify
        2. Now click on the load balancer name that the VPC Endpoint Service is linked to
        3. You will be redirected to the EC2 dashboard where you will have to click on the load balancer name once again
        4. Now under listeners, identify if the correct Default SSL/TLS certificate is present. In this scenario it would be something like “brehog.materials.adaps.devices.amazon.dev”
3. Create a private link from MAWS in Allegiance
    1. https://allegiance.corp.amazon.com/create_private_link_from_maws
        1. Service fabric of CORP should be selected
        2. Use the nomenclature <Service Name>-<Alias> for the Search Alias
            1. ADAPSMaterialsServiceFargate-brehog
        3. Use your personal account Id
        4. Use your VPC Endpoint service’s Service Name as the Service Configuration Name
            1. Ex. com.amazonaws.vpce.us-west-2.vpce-svc-0c1959aa86d4c34d5
4. Save the private link details
    1. https://allegiance.corp.amazon.com/create_private_link_from_maws_result?awsAccountId=295621963539&searchAlias=ADAPSMaterialsServiceFargate-brehog&searchTags=&serviceConfigurationName=com.amazonaws.vpce.us-west-2.vpce-svc-0c1959aa86d4c34d5&awsRegion=us-west-2&fabric=Corp&transitAwsAccountId=284450082675&createEndpoints=true&dnsEntries=[%22vpce-0dc0a607f0324e905-4qmb741x.vpce-svc-0c1959aa86d4c34d5.us-west-2.vpce.amazonaws.com%22,%20%22vpce-0dc0a607f0324e905-4qmb741x-us-west-2b.vpce-svc-0c1959aa86d4c34d5.us-west-2.vpce.amazonaws.com%22
5. Copy the top DNS entry and update the constants file with the DNS name. Leave the hostedZoneId as is.
    1. Redeploy the ECS Cluster stack to add the Allegiance record

## 3.4.  Creating Allegiance Roles

The StageDetails interface has an optional field called `[createAllegianceRole](https://code.amazon.com/packages/ADAPSBaseCDK/blobs/a33fffc3586951b1ef69ccff9a0bccd3e8f26a51/--/src/dev-accounts/constants/constants.ts#L30)`. This field is used to determine if a development stage will create the Allegiance role named `AllegianceClientAccess-DO-NOT-DELETE` . Since Allegiance requires a role with a specific name, and the ECS Cluster stack for both Planning and Materials try to create this role, you will need to use this boolean to prevent creation in the second ECS Cluster stack. This boolean should be used as follows:

1. For the first ECS Cluster stack you deploy, set this to true
    1. This role is required for Allegiance, and you will want it created in your developer account
2. For the second ECS Cluster stack you deploy, set this to false
    1. Since it will try to create a role with the same name, which is not allowed within the same account, we need to disable the ‘duplicate creation’ for the second deployed ECS Cluster stack
    2. This change should not impact any of the deployed stages, as they are always deployed to their own accounts

## 3.5. Fluxo Cert Mapping

Prior to deploy the service stack in Planning service and Materials service, we need to add our personal AWS account as destination to the [Fluxo Odin material set](https://odin.amazon.com/#view/materialSet/com.amazon.certificates.adaps.naws.amazon.com-STANDARD_SSL_SERVER_INTERNAL_ENDPOINT-RSA-Chain), otherwise would failed in service creation and see an error in the AppContainer-STDOUT logs:

```
`{
"log": "`**`Exception`**` in thread \"main\" java.lang.IllegalStateException: `**`Failure`**` retrieving certificate from OdinEverywhere.",
"container_id": "fc85125973f44c13a7a57bcc930a7630-581894629",
"container_name": "Application" }`
```

## 3.6.  Planning Specific Setup - DOS Odin

To access the DOS S3 bucket, we use two Odin Material Sets. One is for the [working directory (S3 location)](https://odin.amazon.com/#view/materialSet/com.amazon.kindleplanning.orchestration.workingdir.devo) and another is for the [Beta encryption key](https://odin.amazon.com/#view/materialSet/com.amazon.kpa.beta.encryption_key). Previously, this was not an issue since we added permission to both our Dev Desktops and Planning AWS accounts. Since we are setting up the service in a new account, we will need to onboard our Dev Account to these Material Sets. If you were to attempt a service deployment without the correct permissions, you may see an error simmilar to the following in the AppContainer-STDOUT logs:

```
{
"log": "Exception in thread \"main\" java.lang.IllegalStateException: Material set com.amazon.kpa.beta.encryption_key is not currently available from Odin",
"container_id": "5d8edb05dbc84d18ab726a3ba18784e0-581894629",
"container_name": "Application",
"source": "stderr"
}
```

The solution, as mentioned above, is to add your account as a Hostclass on the Material Sets. APS team cannot modify these permissions ourselves, so we must reach out to the DOS engineers to assist with this change. An example message which I sent to get permissions


>Hey Nikolas, I was looking for your help with a couple of DOS Beta Material set access changes. For context, we are making Personal Dev accounts to run our NAWS Planning Service. As a result, I want to update the Odin Material Set permissions to include my Dev Account.

The two Material Sets I need permission on are the [workingdir](https://odin.amazon.com/#view/materialSet/com.amazon.kindleplanning.orchestration.workingdir.devo) and the [encryption key](https://odin.amazon.com/#view/materialSet/com.amazon.kpa.beta.encryption_key). Can you add the AWS account 295621963539 (PDX) as a destination on both please?


The Material Sets are both owned by the dial-prediction-ssd team, which is matched with the attached [rule](https://permissions.amazon.com/a/team/amzn1.abacus.team.vnluveyet76geptkztda#).

You can also find their current [on call](https://oncall.corp.amazon.com/#/view/dial-prediction-ssd/schedule)with the attached link.


#### DOS RDS access

Very similar steps to section 3.1 will also need to be followed to get access to DOS’s RDS. Steps highlighted in bold are those that are different from the steps in 3.1.

1. Open your AWS account and navigate to [**Elastic IPs**](https://us-west-2.console.aws.amazon.com/vpcconsole/home?region=us-west-2#Addresses:) to find the IP addresses that were created for your Planning and Materials services. There should be 1 IP for each (called Allocated IPV4 address).
2. **Open the [Kindle-Planning-Prod](https://conduit.security.a2z.com/accounts/aws/744622736866/attributes) account**
3. Open the “Security Groups” page.
4. **Find the security group called “AdeptMySqlVpcPeering”.**
5. Open the “Security Groups” page.
6. **Add a new rule:**
    1. **Type: Custom TCP**
    2. **Port: 0 - 65535**
    3. **Source: your.ip.address.here/32**
    4. **Description: access for ADAPSPlanningServiceFargate-[Your alias]**
7. Click Save Rules.

>In the scenario that the security group has reached the maxed number of rules, follow this [guide](https://repost.aws/knowledge-center/ec2-find-security-group-resources) to find another security group that is attached to the same resource



# 4. Tips and Tricks

## 4.1. Minimum Local Package Set

Our version sets are always changing with feature work, OE updates, and merges from live. Because of this constant state of change, building a version set after a period of not working in it can be difficult. Luckily, there are a few tricks you can do to reduce the version set maintenance required for development work. The core idea behind this technique is using the minimum local package set required for your changes, then relying on a version set sync to pull in the remainder of the changes. For a NAWS service where you want to run a CDK deployment to test changes, a few packages will be required. We will use ADAPSPlanningServiceFargate as an example.

**ADAPSPlanningServiceFargate minimum packages to deploy CDK**

* **ADAPSPlanningServiceFargate** - Service package
* **ADAPSPlanningServiceFargateCDK** - Service CDK
    * *ADAPSBaseCDK* - Not required but advisable to include
* **ADAPSPlanningServiceFargateLogImpageBuild** - Docker image (logging)
* **ADAPSPlanningServiceFargateImageBuild** - Docker image (service)

This setup applies to other NAWS services, as you will want your service package, service CDK, and any docker image packages to be pulled and built locally to run a CDK deployment. For all of the packages you have checked out locally, you will want to pull from git and ensure they are on the latest commit. In addition to the minimum required packages, you will want to check out any packages that you want to either use a different branch/commit than the latest in the version set or packages that you want to modify as part of the development work. For example, if I wanted to make a manager update, I can check out ADAPSPlanning locally in addition to the required packages for that version set.

The benefits of this “minimum local package set” approach is as follows:

* Rely upon the quick version set sync to pull changes in all other packages
    * Simplifies the tedious package by package git pull process
* Confidence in having the latest changes in sync with the version set
    * This makes the CR publishing process and dry-run builds more reliable, as you know your local environment has fidelity with the current version set
* Reduce the build time
    * Recursive builds will only require the packages you have checked out locally. Reducing the number of local checkouts reduces the total build time


