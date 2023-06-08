
# Flare 

[Training Videos](https://broadcast.amazon.com/channels/9948/playlists/768)
[Flare UI](https://flare.aka.amazon.com/)
[Dev-DSK](https://apollo.amazon.com/environments/DevDesktopAL2/ailor-1-click-FLARE)

[Intake Ticket](https://t.corp.amazon.com/P55582935/communication)
[Intake Request](https://issues.amazon.com/issues/P55831675)
[Model Review Ticket](https://sim.amazon.com/issues/FLASH-DMR-322)
[Offline Design](https://w.amazon.com/bin/view/KOMPAS/KindleReverseLogistics/Projects/Isley-Offline/)
[Morpheus Design](https://w.amazon.com/bin/view/Hamlet/Projects/2020/Morpheus/#HIneligibleDeviceDisposition)

https://w.amazon.com/bin/view/Matcher/SLIM/Usage
https://w.amazon.com/bin/view/Flare/Tenant_Flash_Core_Data_Model_Review_Process
https://code.amazon.com/packages/FlareConfig/trees/prod/--/configuration/flare/global/attribute

https://flash.amazon.com/help/topic/GT8MVEK7GY5H45BK
## Environment Set Up
- [X] Create new M4.2XL Dev-dsk for Flare work


### FlareCLI

- [X] Create 1-click Child of FlareCLI with Apollo: https://apollo.amazon.com/environments/FlareCLI
	- FlareCLI 1 click child: https://flash.amazon.com/help/topic/GT8MVEK7GY5H45BK
- [X] Make sure the stage is Beta.
- [X] Run as user should be your username.
- [X] Make sure your environment has deployment permission given to ApolloAutoSyncDJS/FlareExpertModeTooling/Prod (AAA ID) via Bindle so that future improvements benefit you in a timely manner. Future improvements to FlareCLI are automatically built into all child-environments.
- [X] Go to your FlareCLI child environment, https://apollo.amazon.com/environments/FlareCLI/<yourname>/
- [X] Click Manage Access.
- [X] Add custom permissions
- [X] Choose type: AAA ID
- [X] AAA ID Name: ApolloAutoSyncDJS/FlareExpertModeTooling/Prod
- [X] Check Deploy environment.
- [X] Click Submit.
- [X] Make sure your environment has deployment permission given to 'builder' (POSIX system account) via Bindle so that future improvements benefit you in a timely manner. Future improvements to FlareCLI are automatically built into all child-environments.
- [X] Edit your environment to make it consumable by marking Allow this environment to be consumed by other environments. 
- [X] You can add the environment as a consumable in the pipeline of your cloud desktop from this point on for automatic delivery.
- [X] Sync from parent Beta environment in Apollo.

### FlashAAAShim
- [X] Create 1-click Child of https://apollo.amazon.com/environments/FlashAAAShim/stages/Beta
- [X] Make sure the stage is Beta.
- [X] Run as user should be your username
- [X] Under "Edit Beta Stage Properties", go to "Edit deployment preferences". Click "Use existing preference set". Search for "FlashAAAShim-Prod" and click "Associate". This is required because Bounce deployments should always be enabled.
- [X] Please make sure your environment has deployment permission given to 'builder' (POSIX system account) via Bindle so that future improvement will deliver to you in a timely manner. Future improvements to ExpertModeToolingCLI will be automatically built into all child-environments.
- [X] Make it as consumable.
- [ ] If you don't have any plan to modify AAA-related parts of the system, you may disable AAA as explained below.
- [X] Sync from parent Beta environment in Apollo
- [ ] In FlareService/configuration/spring-configuration/application-config.xml update, change:
- [ ] `<property name="aaaEnabled" value="${aaaEnabled:true}" />`
To
- [ ] <property name="aaaEnabled" value="${aaaEnabled:false}" />
- [ ] In FlareService/build.xml, change:
- [ ] `<sysproperty key="aaaEnabled" value="${enableAAA}"/>`
To
- [ ] `<sysproperty key="aaaEnabled" value="false"/>`
- [ ] To run the test, configure FlareServiceIntegrationTests to connect to the local FlareServiceInstance:
- [ ] In FlareServiceIntegrationTests add 'endpoint = "http://localhost:8000";' and 'useAAAJerseyClientFilter = false;' to the FlareClient entry in /configuration/brazil-config/override/TestOverrides.cfg and disable AAA while calling FlareService running locally. It should look like this:

```
*.*.FlareClient += {
    endpoint = "http://localhost:8000";
    useAAAJerseyClientFilter = false;
    logRequestResponse = false;
    readTimeoutMillis = 70000;
    connectTimeoutMillis = 70000;
};
```

- [ ] Run 'brazil-build'in FlareService.
- [ ] Run 'brazil-build'in FlareServiceIntegrationTests.
- [ ] Run brazil-build server -DflareConfigRoot=/home/${USER}/devtooling/filesystem/in FlareService.

### FlareService/NA

- [X] Create 1-click Child of FlareService/NA
- [X] Make sure the stage is Beta.
- [X] Run as user should be your username.
- [X] Click Edit Stage Operational Config and add the following Sets:
- [X] AppConfig - change the value of the override key to: CalvinHerdInterfaceConfigOverrides.cfg,DesktopOverride.cfg
- [X] PubSub - change the value of the domain key to: desktop
- [X] Sync from parent Beta environment in Apollo, choose deployment type to be Update instead of FlipActivate. (If choosing FlipActivate deployment will fail for missing odin permission)
- [X] Activate AAASecurityDaemon on your desktop, run:
- [X] `sudo /apollo/bin/runCommand -a Activate -e FlareService_NA.CONSUMES.AAASecurityDaemon`

>Note: If you see the following message when syncing from the parent environment: “Error: user gfs-clvn retrieved from Manifest does not exist in the system,” you can check the Run as User configured on both the environment and consumed environments. Go to permissions.amazon.com, and search for your Hostclass. Clicking it takes you to the Account Management page. Add access for the user (in this case, "gfs-clvn"). Allow time for the permissions to propagate and try again.


## Authoring New Config

- [X] Add to `~/.bash_profile` `alias flare='/apollo/env/FlareCLI/bin/flare'`
- [X] Create a Brazil workspace for your changes. We're going to call ours "devtooling" and create it in our home folder, but the name of the workspace and its location don't matter:
- [X] `brazil ws create --name devtooling -vs FlareServiceIntegrationTests/prod`
- [X] Checkout the version of FlareService: (please make sure you are using the --latestVersion command line option. This will pull the commit that is currently built into the FlareServiceIntegrationTests/prod versionset)
- [X] `cd devtooling && brazil ws use --package FlareService --latestVersion`
- [X] Checkout FlareServiceIntegrationTests to run the integration tests: (please make sure you are using the --latestVersion command line option. This will pull the commit that is currently built into the FlareServiceIntegrationTests/prod versionset)
- [X] `brazil ws use -p FlareServiceIntegrationTests --latestVersion`
- [X] Setup your local Flare environment in your Brazil workspace, which FlareCLI uses to track your filesystem and work requests:
- [X] `flare environment setup --tenant flash`
- [X] Create a work request to capture the changes you are making. Remember to add quotes if you use spaces in the name or description.
- [X] `flare work-request create --name "<name>" --description "<some description>"`
- [ ] The CLI will store the id of the work request you just created in your local environment. But you can always set this value manually if you need to create a new enironment:
- [ ] `flare env set --key work_request_id --value <i>`
- [X] Pull down all the Flare config rules for flash in the form of a "config filesystem"
- [X] `flare work-request get-config` 

>This command downloads all rules in the flash tenant and should take about 10 minutes.


## Core Review Process

- [X] Create a SIM in the FLASH Financial Data Model Review/Flare Core Model Review folder using the following [SIM Template](https://sim.amazon.com/issues/create?template=b92a1829-6838-4d3a-90c8-f815eba67267)
- [X] Have your assigned FLASH TPM review the SIM and ensure it is filled out appropriately. Once reviewed, a member of the Flare Core Data Reviewer team will be assigned to your SIM to review the request.
- [ ] Reviewers will strive to provide feedback within a 2 day SLA. The reviewer may ask questions, clarifications and make suggestions for the proposed changes.  Please engage with the team during the planning phase and go through the wiki thoroughly to avoid iterations and any delays. 
- [ ] Once the reviewer get all the questions being answered, they will provide the sign off and the business team can proceed with creating a FLARE release with the proposed changes.

>NOTE: This release should only contain changes relevant to the data model review process, any other changes should be done separately and can be reviewed later with your assigned FLASH TPM. As an example, if it is attribute review, then the CR should only have the definition of the new global attribute.
>
- [ ] The reviewer will approve the CR generated by the release to DEVO and resolve the SIM. All subsequent reviews (for uat/prod and for other business configurations) can be approved by your FLASH TPM.

>The intention of this process is to stop the creation of redundant and often poorly documented attributes / core attribute values that serve to only confuse users on which can be used for what purpose.

