
# Enable Friendly DNS via SuperNova
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

**AS a** Business Operations User
**I WANT** a friendly dns name to access Portals and UIs
**SO** I can remember the Portal UIs.

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

[SuperNova](https://w.amazon.com/bin/view/SuperNova) is a self-service way for  teams to acquire their own domain name that they can manage using Route 53 ( DNS service).

We would like a personal domain (already created) for the reverse-logistics team. This domain will need to be hosted in the Production account, with all of the appropriate routing rules.

The `.dev` top-level domain is included on the HSTS preload list, making HTTPS required on all connections to .dev websites and pages without needing individual HSTS registration or configuration. Security is built in.

In order to use SuperNova, a SuperNova role will need to be created in each account:

```
new Role(this, 'SuperNovaRole', {
    roleName: 'Nova-DO-NOT-DELETE',
    assumedBy: new ServicePrincipal('nova.aws.internal'),
    managedPolicies: [
        ManagedPolicy.fromAwsManagedPolicyName('
        ManagedPolicy.fromAwsManagedPolicyName('SecurityAudit')
    ]
});
```

`<disambiguator?>.<service-abbreviation>.reverse-logistics.devices.amazon.dev`

Examples of these UI domains are:

* `personal-ailor.drop.reverse-logistics.devices.amazon.dev`
* `personal-suemlee.drop.reverse-logistics.devices.amazon.dev`
* `beta.drop.reverse-logistics.devices.amazon.dev`
* `drop.reverse-logistics.devices.amazon.dev`
* `personal-ailor.drap.reverse-logistics.devices.amazon.dev`
* `personal-suemlee.drap.reverse-logistics.devices.amazon.dev`
* `beta.drap.reverse-logistics.devices.amazon.dev`

**We would like to utilize only a a single domain for UIs - without regionalization**

Examples of Service Level Domains are:

* `personal-ailor.us-east-1.drops.reverse-logistics.devices.amazon.dev`
* `personal-suemlee.us-east-1.drops.reverse-logistics.devices.amazon.dev`
* `beta.us-east-1.drops.reverse-logistics.devices.amazon.dev`
* `prod.us-east-1.drops.reverse-logistics.devices.amazon.dev`
* `personal-ailor.eu-west-2.drgas.reverse-logistics.devices.amazon.dev`
* `personal-suemlee.eu-west-2.drgas.reverse-logistics.devices.amazon.dev`
* `beta.eu-west-2.drgas.reverse-logistics.devices.amazon.dev`
* `prod.eu-west-2.drgas.reverse-logistics.devices.amazon.dev`

Services should remain Regionalized, although a non-regionalized endpoint that chooses the region to forward to would be great.

Top Level Domain and Zone are created by SuperNova, however all lower Level Domains and zones should be created/managed as part of the networking stack.

Each service should add their own:
```
// create child hosted zone
this.childHostedZone = new PublicHostedZone(this, `$\{id}-ChildHostedZone`, {
    zoneName: `drops.reverse-logistics.devices.amazon.dev`
});

// create zone delegation record
new ZoneDelegationRecord(this, `$\{id}-ZoneDelegationRecord`, {
    nameServers: this.childHostedZone.hostedZoneNameServers!,
    zone: props.rootHostedZone,
    recordName: `drops.reverse-logistics.devices.amazon.dev`
});

// for each stage account:
role = new Role(this, `$\{id}-CrossAccoundZoneDelegationRole`, {
  assumedBy: new AccountPrincipal(<Stage-Account>),
  inlinePolicies: {
    'delegation': new PolicyDocument({
      statements: [new PolicyStatement({
        actions: ['route53:ChangeResourceRecordSets'],
        resources: [childHostedZone.hostedZoneArn]
      })]
    })
  }
});
```

This should live in the Service CDK Package - but may be put into a Share Construct.


You will need to create an IAM role to allow DNS delegation in service accounts. Each stack in stage accounts can assume the DNS auto update role, this will allow stage accounts to add NS records in root hosted zones to further sub delegate subdomains to our stage accounts. This is the `$\{id}-CrossAccoundZoneDelegationRole` in the Examples above and below.

[CrossAccountZoneDelegationRecord](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_route53.CrossAccountZoneDelegationRecord.html) Will need to be utilized in order to add each environments subdomains.

```
const subZone = new PublicHostedZone(this, 'SubZone', {
  zoneName: `beta.drops.reverse-logistics.devices.amazon.dev`
});

// import the delegation role by constructing the roleArn
const delegationRoleArn = Stack.of(this).formatArn({
  service: 'iam',
  account: <prod-account>,
  resource: 'role',
  resourceName: `Prod-
});
const delegationRole = iam.Role.fromRoleArn(this, 'DelegationRole', delegationRoleArn);

// create the record
new route53.CrossAccountZoneDelegationRecord(this, 'delegate', {
  delegatedZone: subZone,
  parentHostedZoneName: `drops.reverse-logistics.devices.amazon.dev`
  delegationRole,
});
```

The Personal Subdomains should be deployed only as part of the Personal Deployment Stack.

In order to enable SSL, each domain/subdomain will also need a certificate assigned:

```
const cert = new Certificate(this, `$\{id}-Cert`, {
    domainName: `drops.reverse-logistics.devices.amazon.dev`
    validation: CertificateValidation.fromDns(props.zone),
});
```

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

- Should have created and deployed a Hosted Zone in each account/region via the Networking Stack
- Should have created and deployed SuperNova Role in each Account Via Networking Stack
- Should have created via CDK IAM Role for DNS Delegation in Main Account that can be assumed by each stage
- Should have created or [verified the existence](https://bindles.amazon.com/resource/amzn1.bindle.resource.zfn5wnppxuof2g5ayfoq) of a `reverse-logistics` Super Nova Domain
- Should have created or verified that reverse-logistics domain is managed by [ Bindle](https://bindles.amazon.com/software_app/
- Should have added or verified reverse-logistics domain bindle has all 'Nova DNS Domain Permissions'
- Should have added subdomain delegation to Prod account to all lower envs (Alpha, Beta, Gamma)
- Should have added subordinate Route 53 zones for each subdomain (application)
- Should have added an AWS Certificate to each domain/subdomain role

Note: a tool called `dig` can be used to verify that the domains resolve, even if they are not pointing to a service:

```
dig beta.drops.reverse-logistics.devices.amazon.dev;
```

Dig output is somewhat gibberishy. Look it up to see what it means - that's my best advice.
