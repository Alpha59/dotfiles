
# Create a CDK Amplify Package for existing Website/Application
*Repeated for each of the 4 applications*

### **Summary:**

**As a** developer, **I want** to create a CDK Amplify Package for an existing website or application **so that** the setup is correctly verified for these services, **and** I do not need to repeat the infrastructure code for every website.

### Pre-Deployment Steps

Note: Some CDK Packages are already available for services, such as  RL Portal React and   Dashboard Website. This ticket is for verifying that the setup is completed correctly for these services.

*  RL Portal React →
*  →

#### Step 1: Create CDK Package or Other New Packages


```
# Create a new version set
brazil vs create --versionSet=$\{SERVICE_NAME}/naws --from='live' --platforms=AL2_x86_64 --overwrite --bindleId  --mailingList='kindle-rl-dev+@amazon.com'

# Add platforms to the development version set
brazil versionset addplatforms --versionSet '$\{SERVICE_NAME}/development' --platforms AL2_x86_64

# Clone from development to naws
brazil vs clone --from $\{SERVICE_NAME}/development --to $\{SERVICE_NAME}/naws --overwrite

# Remove unnecessary platforms
brazil versionset removeplatforms --versionSet '$\{SERVICE_NAME}/naws' --platforms RHEL5_64
brazil versionset removeplatforms --versionSet '$\{SERVICE_NAME}/naws' --platforms AL2012
brazil versionset removeplatforms --versionSet '$\{SERVICE_NAME}/naws' --platforms RHEL5
brazil versionset removeplatforms --versionSet '$\{SERVICE_NAME}/naws' --platforms AL2_aarch64

# Verify the version set exists in the Git Farm
# https://code.amazon.com/version-sets//naws

# Verify that the service already exists
# https://code.amazon.com/packages/

# Create CDK package
# Create a remote workspace
~/.toolbox/bin/brazil ws create --name 
cd /
~/.toolbox/bin/brazil ws use -vs $\{SERVICE_NAME}/naws
~/.toolbox/bin/brazil ws use -p $\{SERVICE_NAME}
~/.toolbox/bin/brazil-octane package promote     --abstract '$\{SERVICE_NAME}CDK' --bindleName='' --description ': $\{SERVICE_NAME}CDK' --push     --packagePermissions public --subjectToExportControl='No'

brazil-octane ws brazilify
```

#### Step 2: Create Pipeline

```
# Create a pipeline for the CDK package
~/.toolbox/bin/brazil-octane pipeline create --versionSet '$\{SERVICE_NAME}/naws' --name '$\{SERVICE_NAME}-CDK' --bindleId '' --packages='$\{SERVICE_NAME}CDK' --mailingList='kindle-rl-dev+@amazon.com'
```

#### Step 3: Add Bindle

* Add Bindle: https://bindles.amazon.com/resource/amzn1.bindle.resource.gwbimchocnblyccbj67q

#### Step 4: Ensure Permissions

Ensure permissions for the following:

1. AAA Applications
2. Apollo Environments
3. CloudFront Domains
4. Conduit AWS Accounts
5. Conduit IAM Roles
6. Nova DNS Domains
7. Pipelines
8. Software Packages
9. SuperStar Service Environments
10. Version Set Groups
11. Weblab Experiments

#### Step 5: Create a New Branch for Existing Service Package

```
# Create a new branch for the existing service package
git checkout -b naws/initial-commit
git push --set-upstream mainline
git add -A
git commit -m 'Initial Commit from create-stories to create NAWS Branch'
```

### **Acceptance Criteria:**



1. **Given** the version set exists in the Git Farm,
    1. **when** I verify its existence using the provided URL,
    2. **then** the version set should be accessible and verified on the platform.



* **Should have:** created a new version set created with the specified parameters.
* **Should have:** created a new branch created from the existing service package.
* **Should have:** successfully added Platforms to the development version set.
* **Should have:** Successfully cloned from development to target version set.
* **Should have:** successfully removed Unnecessary platforms from the target version set.
* **Should have:** verified The Versionset is accessible through the provided URL.
* **Should have:** successfully created A CDK package with the specified properties.
* **Should have:** successfully created A pipeline for the CDK package.
* **Should have:** successfully added Bindle to project resources.
* **Should have:** Permissions correctly configured for AAA Applications, Apollo Environments, CloudFront Domains, Conduit AWS Accounts, Conduit IAM Roles, Nova DNS Domains, Pipelines, Software Packages, SuperStar Service Environments, Version Set Groups, and Weblab Experiments.
