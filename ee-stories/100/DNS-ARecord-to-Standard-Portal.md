
# DNS ARecord to Standard Portal
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

**AS a** Business Operations User
**I WANT** a friendly dns name to access Portals and UIs
**SO** I can remember the Portal UIs.

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

[SuperNova](https://w.amazon.com/bin/view/SuperNova) is a self-service way for  teams to acquire their own domain name that they can manage using Route 53 ( DNS service).

The [root ticket](https://issues.amazon.com/issues/KRL-13208) divided the base domain used for rl tech `reverse-logistics.devices.amazon.dev` into 3 separate domains and accounts:
- alpha.reverse-logistics.devices.amazon.dev (ALPHA: 939400162252)
- beta.reverse-logistics.devices.amazon.dev (BETA: 145224550763)
- reverse-logistics.devices.amazon.dev (PROD: 687036466858)

The [previous ticket](https://issues.amazon.com/issues/KRL-13376) will have examples of how the host zones are created which will be useful for this ticket.

We want the L3 constructs in DRC to receive a host zone as an input and then point the service endpoint to the dns created.

In order to create the DNS [ARecord](https://docs.aws.amazon.com/cdk/api/v1/docs/@aws-cdk_aws-route53.ARecord.html) for each L3 construct type.

L3 construct will need to be extended to accept the HostedZone from DnsHostedZoneConstruct

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

- Should modify portal/standard.ts in   Constructs that points to the DNS generated via DnsHostedZoneConstruct
- Should have verified that the DNS points to the by accessing the portal using the DNS/URL in browser
- Should have deployed and tested on your personal aws account using at least one of our services verifying that the construct is functional

## References:
- Sue has done this in a MicroService previously [

MicroService Standard:
https://code.amazon.com/packages/

Portal CloudFront: https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-cloudfront-distribution.html
MicroService ECS: https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-elb-load-balancer.html
NanoService API Gateway: https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-api-gateway.html


