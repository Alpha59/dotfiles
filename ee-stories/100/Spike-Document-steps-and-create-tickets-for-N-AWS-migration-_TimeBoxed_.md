
# Spike: Document steps and create tickets for N-AWS migration (TimeBoxed)
## Description
[//]:# (This should be descriptive enough to frame the Spike as well as include any additional resources needed to accomplish the Spike.)

**AS a** Developer
**I WANT** the N-AWS migration to happen quickly and effectively
**SO** that I can quickly and effectively complete this work

## Acceptance Criteria
[//]:# (This is a very explicit list of everything that is required to be completed, in the past tense, to finish the Spike. Each line starts with 'Should have'.)

- Should have Documented all steps into a tutorial style document
- Should have included scripts and steps where possible
- Should have created tickets for quickly repeatable steps
- Should have created a general starting script

## Findings
*Findings are added below as comments*
[//]:# (This is a write-up of what was learned from the Spike and should answer all of the questions in the acceptance criteria.)

## Scripts

### Get basic information about service
```
BINDLE_ID=$\(kcurl --capath /apollo/env/envImprovement/etc/cacerts/ --silent -X POST -H 'Content-Type: application/json; charset=UTF-8' -d '{'Service' : 'com.amazon.bindle.coral.   calls#BindleService', 'Operation' : 'com.amazon.bindle.coral.calls#DescribeResource', 'Input':{'resourceType': {'resourceTypeName': 'package', 'namespaceName': 'Brazil'},          'resourceName': ''''''}}' https://bindle-service-sso.amazon.com | jq -r '.Output.parent.resourceId');
  #amzn1.bindle.resource.5lk2wezknpi5nz5knmoa
  pass 'The entered bindle id is: ';


  PARENT_BINDLE_ID=$\(kcurl --capath /apollo/env/envImprovement/etc/cacerts/ --silent -X POST -H 'Content-Type: application/json; charset=UTF-8' -d '{'Service' : 'com.amazon.bindle.  coral.calls#BindleService', 'Operation' : 'com.amazon.bindle.coral.calls#DescribeResource', 'Input':{'resourceType': {'resourceTypeName': 'package', 'namespaceName': 'Brazil'},    'resourceName': ''''''}}' https://bindle-service-sso.amazon.com | jq -r '.Output.bindle.bindleId');
  pass 'The entered bindle parent name is: ';
  #amzn1.bindle.resource.qv63lefqeo6kqllw4ruq


  BINDLE_NAME=$\(kcurl --capath /apollo/env/envImprovement/etc/cacerts/ --silent -X POST -H 'Content-Type: application/json; charset=UTF-8' -d '{'Service' : 'com.amazon.bindle.       coral.calls#BindleService', 'Operation' : 'com.amazon.bindle.coral.calls#DescribeResource', 'Input':{'resourceType': {'resourceTypeName': 'package', 'namespaceName': 'Brazil'},    'resourceName': ''''''}}' https://bindle-service-sso.amazon.com | jq -r '.Output.bindle.bindleName');
  #
  pass 'The entered bindle name is: ';


  AAA_ID=$\(kcurl --capath /apollo/env/envImprovement/etc/cacerts/ --silent -X POST -H 'Content-Type: application/json; charset=UTF-8' -d '{'Service' : 'com.amazon.bindle.coral.      calls#BindleService', 'Operation' : 'com.amazon.bindle.coral.calls#ListResourcesByParent', 'Input': {'parent': {'resourceId': '''''', 'resourceName':              '''''', 'resourceTypeId':'amzn1.bindle.resource-type.faylbbmq7qgihzyfmh3q'}}}'  https://bindle-service-sso.amazon.com | jq -r '.Output.resources[] | select(.           resourceId | contains('aaa')) | .resourceId');
  pass 'The entered AAA ID is: ';


AAA_NAME=$\(kcurl --capath /apollo/env/envImprovement/etc/cacerts/ --silent -X POST -H 'Content-Type: application/json; charset=UTF-8' -d '{'Service' : 'com.amazon.bindle.coral.    calls#BindleService', 'Operation' : 'com.amazon.bindle.coral.calls#ListResourcesByParent', 'Input': {'parent': {'resourceId': '''''', 'resourceName':              '''''', 'resourceTypeId':'amzn1.bindle.resource-type.faylbbmq7qgihzyfmh3q'}}}'  https://bindle-service-sso.amazon.com | jq -r '.Output.resources[] | select(.           resourceId | contains('aaa')) | .resourceName');
  pass 'The entered AAA NAME is: ';


  TEST_PACKAGE=$\(kcurl --capath /apollo/env/envImprovement/etc/cacerts/ --silent -X POST -H 'Content-Type: application/json; charset=UTF-8' -d '{'Service' : 'com.amazon.bindle.      coral.calls#BindleService', 'Operation' : 'com.amazon.bindle.coral.calls#ListResourcesByParent', 'Input': {'parent': {'resourceId': '''''', 'resourceName':        '''''', 'resourceTypeId':'amzn1.bindle.resource-type.faylbbmq7qgihzyfmh3q'}}}'  https://bindle-service-sso.amazon.com |  jq -r '.Output.resources[] | select(.          resourceName | contains('Test')) | .resourceName');
  pass 'The entered TEST PACKAGE NAME is: ';

```

### Create VS
```
  # Create VersionSet
  # Create a new version set for the N-AWS migration
  debug 'Create VersionSet';
  #brazil vs create --versionSet=$\{SERVICE_NAME}/naws --from='live' --platforms=AL2_x86_64 --overwrite --bindleId  --mailingList='kindle-rl-dev+@amazon.com'
  brazil versionset addplatforms --versionSet '$\{SERVICE_NAME}/development' --platforms AL2_x86_64;
  brazil vs clone --from $\{SERVICE_NAME}/development --to $\{SERVICE_NAME}/naws --overwrite;
  brazil versionset removeplatforms --versionSet '$\{SERVICE_NAME}/naws' --platforms RHEL5_64;
  brazil versionset removeplatforms --versionSet '$\{SERVICE_NAME}/naws' --platforms AL2012;
  brazil versionset removeplatforms --versionSet '$\{SERVICE_NAME}/naws' --platforms RHEL5;
  brazil versionset removeplatforms --versionSet '$\{SERVICE_NAME}/naws' --platforms AL2_aarch64;
  echo 'https://code.amazon.com/version-sets//naws';
  if [[ '' != 'true' ]]; then
      echo 'Now is the time to verify that the vs exist in git Farm';
      read ENABLED;
      pass '';
  fi

  # SERVICE SHOULD ALREADY Exist
  echo 'https://code.amazon.com/packages/';
  if [[ '' != 'true' ]]; then
      echo 'Now is the time to verify that the above packages exist in git Farm';
      read ENABLED;
      pass '';
  fi
```

### Create CDK Packages

```
  ### CREATE CDK PACKAGE
  debug 'Create Remote Workspace: ';
  rm -rf /;
  ~/.toolbox/bin/brazil ws create --name ;
  cd /;
  ~/.toolbox/bin/brazil ws use -vs $\{SERVICE_NAME}/naws;
  ~/.toolbox/bin/brazil ws use -p $\{SERVICE_NAME};

  debug 'Create Brazil $\{SERVICE_NAME}CDK';
  cd /;
  ~/.toolbox/bin/brazil-octane pkg generate pkg-empty --name='$\{SERVICE_NAME}CDK' || mkdir $\{SERVICE_NAME}CDK;
  cd //src/$\{SERVICE_NAME}CDK;
  ~/.toolbox/bin/brazil-octane package promote       --abstract '$\{SERVICE_NAME}CDK' --bindleName='' --description ': $\{SERVICE_NAME}CDK' --push       --packagePermissions public --subjectToExportControl='No';

  debug 'Create Brazil $\{SERVICE_NAME}ImageBuild';
  cd /;
  ~/.toolbox/bin/brazil-octane pkg generate pkg-empty --name='$\{SERVICE_NAME}ImageBuild' || mkdir $\{SERVICE_NAME}ImageBuild;
  cd //src/$\{SERVICE_NAME}ImageBuild;
  ~/.toolbox/bin/brazil-octane package promote       --abstract '$\{SERVICE_NAME}ImageBuild' --bindleName='' --description ': $\{SERVICE_NAME}ImageBuild' --push       --packagePermissions public --subjectToExportControl='No';

  debug 'Create Brazil $\{SERVICE_NAME}LogImageBuild';
  cd /;
  ~/.toolbox/bin/brazil-octane pkg generate pkg-empty --name='$\{SERVICE_NAME}LogImageBuild' || mkdir $\{SERVICE_NAME}ImageBuild;
  cd //src/$\{SERVICE_NAME}LogImageBuild;
  ~/.toolbox/bin/brazil-octane package promote       --abstract '$\{SERVICE_NAME}LogImageBuild' --bindleName='' --description ': $\{SERVICE_NAME}LogImageBuild' --push       --packagePermissions public --subjectToExportControl='No';

  brazil-octane ws brazilify;

 kcurl --capath /apollo/env/envImprovement/etc/cacerts/ --silent -X POST -H 'Content-Type: application/json; charset=UTF-8' -d '{'Service' : 'com.amazon.bindle.coral.calls#BindleService', 'Operation' : 'com.amazon.bindle.coral.calls#GrantPermission', 'Input':{'permission': { 'actorId': 'builder-tools', 'actorType': 'amzn1.bindle.actor-type.    package', 'permissionNamespace': 'brazil', 'permissionResourceType': 'package', 'permissionOperation': ['publish']}, 'resource': {'resourceId': ''''''}}}' https://bindle-service-sso.amazon.com | jq
```
