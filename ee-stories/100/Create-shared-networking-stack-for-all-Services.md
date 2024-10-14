
# Create shared networking stack for all   Services
## Summary


**As an**    Developer **I want** All of my services to be configured and built using CDK on-top of a networking stack **So that** I can stop worrying about networking infrastructure and start writing service code.

## Additional Context

We have struggled to create a networking stack that allows all of our services to communicate with each other and outside of the RL space. This story aims to solve that.

https://conduit.security.a2z.com/accounts/aws/821652348846/attributes

## Acceptance Criteria


* Should have created the  account
* Should have created the  account
* Should have created the  account
* Should have created a new project via bones for  returns infrastructure
* Should have created and deployed a networking stack to an Alpha  Account
* Should have created the following resources inside of the networking stack:
    * VPC
    * ECS Cluster
    * Cloud Map
    * Security Groups
* Should have created a construct that consumes the network stack resources and makes them available to lower environments.
* Should have verified that the VPC inside of the networking stack matches all security requirements
