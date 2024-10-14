
# Upgrade Node.js and CDK in CDK Packages.
## Summary
[//]:# (This should be descriptive enough to frame the Story, at a high level, as well as include any additional resources needed to complete the Story.)

**AS a** Developer
**I WANT** The most recent Versions of Software to be used in my packages
**SO** that I do not become overwhelmed by outdated and deprecated code

## Additional Context
[//]:# (This should be descriptive enough to frame the story as well as include any additional resources needed to accomplish the Story.)

```
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!                                                                            !!
!!  Node 12 has reached end-of-life on 2022-04-30 and is not supported.       !!
!!  Please upgrade to a supported node version as soon as possible.           !!
!!                                                                            !!
!!  This software is currently running on node v12.22.0.                      !!
!!  As of the current release of this software, supported node releases are:  !!
!!  - ^18.0.0 (Planned end-of-life: 2025-04-30)                               !!
!!  - ^16.3.0 (Planned end-of-life: 2024-04-30)                               !!
!!  - ^14.5.0 (Planned end-of-life: 2023-04-30)                               !!
!!  - ^17.3.0 (Planned end-of-life: 2022-06-01) [DEPRECATED]                  !!
!!                                                                            !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
```

```
[WARNING] monocdk.Arn#parse is deprecated.
  use split instead
  This API will be removed in the next major release.
[WARNING] monocdk.aws_cloudwatch.CommonMetricOptions#dimensions is deprecated.
  Use 'dimensionsMap' instead.
  This API will be removed in the next major release.
[WARNING] monocdk.aws_cloudwatch.CommonMetricOptions#dimensions is deprecated.
  Use 'dimensionsMap' instead.
  This API will be removed in the next major release.
[WARNING] monocdk.aws_apigateway.ResourceBase#url is deprecated.
  - Throws error in some use cases that have been enabled since this deprecation notice. Use `RestApi.urlForPath()` instead.
  This API will be removed in the next major release.
[WARNING] monocdk.aws_apigateway.Resource#restApi is deprecated.
  - Throws an error if this Resource is not associated with an instance of `RestApi`. Use `api` instead.
  This API will be removed in the next major release.
```

```
NOTICES

19836   AWS CDK v1 entering maintenance mode soon

        Overview: AWS CDK v1 is entering maintenance mode on June 1, 2022.
                  Migrate to AWS CDK v2 to continue to get the latest features
                  and fixes!

        Affected versions: framework: 1.*, cli: 1.*

        More information at: https://github.com/aws/aws-cdk/issues/19836
```

A guide for this upgrade can be found here: https://docs.aws.amazon.com/cdk/v2/guide/migrating-v2.html

monocdk is considered a part of AWS CDK v1, and monocdk pacakges should migrate to v2 (aws-cdk-lib). You can follow the same migration guide linked in the issue above.

The following CDK Packages exist for our team:
*
*
*
* ~~
*
* ~~
*
* ~~
*
*
*
*
* ~~
*
*
*
*

Not all of the above are active - and should be deprecated if they are not the package which will be used for the service moving forward.

When determining which package to deprecate, match the Service Name + CDK pattern as well as possible.


While looking at these services, there are some obvious repeats ( has 3 CDK packages, DROP has 2) - in the  Code Browser, there is a way to deprecate packages from the repository Info Tab. The person doing this story should deprecate these erroneous packages instead of attempting to upgrade them. Pacakges to be deprecated are crossed out in the list above.

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the story. Each line starts with 'should have'.)
[//]:# (Refer to https://w.amazon.com/bin/view/Users/ailor/UserStoriesandTickets#HOtherAcceptanceCriteriaformats for more information on Acceptance Criteria formats)

- Should have deprecated any packages above not tied to original service (see note above)
- Should have upgraded Node.js to `^18.0.0` (or latest) and fixed any CDK build errors
- Should have upgraded CDK to v2 (or latest) and fixed any build errors
- Should have determined cause of `monocdk.Arn#parse` warning and resolve - since these will no longer work in CDK v2
- **Should have deployed all CDK packages to Personal AWS account to verify deployments**
