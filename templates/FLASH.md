## Flash / Flare

https://build.amazon.com/merge/preview#%7B%22destinationVersionSetName%22:%22KORPlanningETL/development%22,%22sourceVersionSetName%22:%22live%22,%22sourceVersionSetEventId%22:%22TIP%22,%22packagesToMerge%22:%5B%22WebsiteLogPusher-3.6%22,%22ProcessManager-3.0%22,%22Openssl-1.1.x%22,%22BSFJavaClient-2.1%22,%22OdinJavaOnlyInterface-1.1%22%5D,%22noImport%22:true%7D

Financial Ledger and Accounting Systems HUB (FLASH)

## What is Flash
Flash is a HUB for understanding the accounting, and business requirements of transaction flows.

>Flash Delivers timely completely and accurate financial information to Amazon's General Ledger

Any transaction placed in the Amazon Business is converted by FLASH into accounting events - booking them into the unified sub ledger (USL).

* Simplifies Accounting data
* Make financial accounting processes reliable
* Create repeatable patterns in accounting information
* Always available infrastructure

Before starting, you will need:

* Accounting Requirements Document
* After intake is created, work with FLASH POC to  identify different systems within FLASH that need to be updated for your usecase

## Financial Information Excellence

This will help  understand impact of business event

Within accounting, we  have different account numbers

1. *Assets* decrease credit
2. *Liabilities* increase credit
3. Equity (shareholder)
4. *Revenue*
5. *COGS*
6. Expenses

Always have a debit and a credit that offset eachother. Always have assets increasing.

7 Unique fields filled for accountants

1. Company Code - 2  char
2. Location Code - 4 char
3. Cost Center - 4 char
4. Account - 5 char
5. Product Line - 4 char
6. Channel - 4 char
7. Project - 4 char (almost always 000)

Can lookup company code on sharepoint. This gives you  country and set of books.

The country code is where the event takes place, not where the customer is. Tax uses the country of residence, but this is not the same for the general ledger.

# Authoring Configuration

## Flare

[Training Videos](https://broadcast.amazon.com/channels/9948/playlists/768)
[Flare UI](https://flare.aka.amazon.com/)
[Dev-DSK](https://apollo.amazon.com/environments/DevDesktopAL2/ailor-1-click-FLARE)

[Intake Ticket](https://t.corp.amazon.com/P55582935/communication)
[Intake Request](https://issues.amazon.com/issues/P55831675)
[Model Review Ticket](https://sim.amazon.com/issues/FLASH-DMR-322)
[Offline Design](https://w.amazon.com/bin/view/KOMPAS/KindleReverseLogistics/Projects/Isley-Offline/)
[Morpheus Design](https://w.amazon.com/bin/view/Hamlet/Projects/2020/Morpheus/#HIneligibleDeviceDisposition)
[Advanced Modeling](https://flash.amazon.com/help/topic/GLS9Y89Q4NMMZ2WV)

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
- [X] If you don't have any plan to modify AAA-related parts of the system, you may disable AAA as explained below.
- [X] Sync from parent Beta environment in Apollo
- [X] In FlareService/configuration/spring-configuration/application-config.xml update, change:
- [X] `<property name="aaaEnabled" value="${aaaEnabled:true}" />`
To
- [X] <property name="aaaEnabled" value="${aaaEnabled:false}" />
- [X] In FlareService/build.xml, change:
- [X] `<sysproperty key="aaaEnabled" value="${enableAAA}"/>`
To
- [X] `<sysproperty key="aaaEnabled" value="false"/>`
- [X] To run the test, configure FlareServiceIntegrationTests to connect to the local FlareServiceInstance:
- [X] In FlareServiceIntegrationTests add 'endpoint = "http://localhost:8000";' and 'useAAAJerseyClientFilter = false;' to the FlareClient entry in /configuration/brazil-config/override/TestOverrides.cfg and disable AAA while calling FlareService running locally. It should look like this:

```
*.*.FlareClient += {
    endpoint = "http://localhost:8000";
    useAAAJerseyClientFilter = false;
    logRequestResponse = false;
    readTimeoutMillis = 70000;
    connectTimeoutMillis = 70000;
};
```

- [X] Run 'brazil-build'in FlareService.
- [X] Run 'brazil-build'in FlareServiceIntegrationTests.
- [X] Run brazil-build server -DflareConfigRoot=/home/${USER}/devtooling/filesystem/ in FlareService.

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

- [ ] The reviewer will approve the CR generated by the release to DEVO and resolve the SIM. All subsequent reviews (for uat/prod and for other business configurations) can be approved by your FLASH TPM.

>The intention of this process is to stop the creation of redundant and often poorly documented attributes / core attribute values that serve to only confuse users on which can be used for what purpose.

## Flash Training Modeling

Need to understand business so that bussiness can hold their configuration.

Gather the required ARD Document and Accounting Spreadsheet

The Document shoudl be as close to finilized as possible. The spreadsheet is the primary thing to work off.

jeff is the assigned contact

Flash FPM & TPM is mean.

Need to identify upstream systems - AFT / Hamlet, Pedigree

Need to identify downstream systems.

First use case:

1. Recieve Cash from customer
2. Revenue and Cost of Goods (COGS)
3. Don't need amounts in the models
4. Record the Revenue and the Cash
5. 	Accounting will increase debit since cash was provided
6. COGS the inventory owned by Amazon
7. Debit the cost
8. and Credit the inventory

### Modeling Attributes

* Business Namespace - fixed
* Business Country Code - fixed
* Business Activity
	* Financially signifigant triggering business event
	* Inventory Reciept, ship completem, payment failure, etc
	* Contains one or more sets of balancing records
* Financial Component Group
* Financial Component

### Modeling Template

Sequence is fixed for the 7 segments

Paste it into the modeling template

Use the FLARE library in conjunction with Amazon Brew Use cases

Start with the account number

Work backwards from account number and figure out what the cash receivable.

That should help define the financial component that is defined.

Bussiness activity could be the same as accounting component, but should be more business focused (focused on your business)

need to have both a debit and credit that are equal

The business event should probably be the same across multiple lines.

Business Namespace should be the customer facing name, not the internal name

## Model to Configuration

Modeled in FlareService Package

* Add financial components to global system allowable values list
* Add them to the processing folder
	* Add a business activity folder
	* create a new block by copying an existing block
	* Delete the existing block_id - but never change them otherwise
	* Only need to change a few attributes
	* add the seven segment values from the ARD
* Derived Records create the record based on values not provided by company codes
	* is_intercompany_transfer: true
	* Copy from existing
	* Update to reflect what we want
	* Remove Block_id again
	* Need to determine what the parent is that is being derived from
	* Need to pass 5 core attributes for all intercompany transfers
* Pass all the attributes that are required for the usecase
* `bb server` will do a static check of the values
	* need to add `-DConfigFlare` or something that points to current file  system
* When it's  all done, you can run tests against flare service

## Flare Modeling
Flare Modeling tool can be used to Find a Flare rule that seems to match:

https://onboarding.flash.a2z.com/modeling/7664472fa7c8212442a32d804fd06468

Click Create Flare Rule

Tool is useful for searching existing business use cases and have a minor change in the accounting segment.

## Source2Source

* AFT works with Inventory for 2 different channels.
* Utilize the source2source hand-off to send signals between the 2 systems
* Book the system hand-off entry
* When we ship from offline space to Hamlet
* When we get the inventory notice, we need to book the offset
* Can any GL account onboard to source2source

* Source 2 Source ensures that messages are always sent across all links in the chain.
* Declares intention to send the message
	* When the message is recieved, second system marks message as recieved
*


### GEO Expansion
https://flashui-na.aka.amazon.com/help/topic/G47CPPVWWJVUWDMY



First, FLASH intake ticket Official FPM - contact directly, not through a ticket.

Modeling should not require the account, the document should have the theoretical portion, so we should have the modelling.

Let the accounting team create the new account, so we do not need to create a theoretical portion.

Or we can create a new UI in the and the new account will be a new one.

Do it with the existing account and then use the advanced modeling in the buisiness modeling pre-reqs

There is an excel file to download that I can use the new business activity, and such. Fill in the basic understanding of the use cases. The new attribute is then attached based on the



## JEM Updates

Are account numbers in-correct for AFT FC Input:

12120
12151

Run searchable attributes by accounting
* Need to add all those elements to searchable (H15 gets all Line 24 elements)
* Check Names against GEM
* Find better Mappings (KOR Related)
* Add marketplaces for EU.

https://flare.aka.amazon.com/flash/config

https://flare.aka.amazon.com/flash/traffic_search?aggregationAttributes=business_namespace%2Bbusiness_country_code%2Bbusiness_activity%2Bgl_line_description&domain=prod&executionContextKey=processing&query=business_namespace%3Akindle_offline_retail+business_country_code%3AUS+business_activity%3Awarehouse_transfer_shipment+financial_component_group%3Ainventory_movement+financial_component%3Akor_warehouse_transfer_inventory_item+account_number%3A12120+channel%3A1900+company_code%3A2D+cost_center%3A1200+project%3A0000+gl_line_description%3AKOR+WAREHOUSE_TRANSFER_SHIPMENT

https://share.amazon.com/sites/Corporate_Accounting/global_accounting/COA/Listings/Essbase/Location_hierarchy_by_geography_LTOG.txt

https://flare.aka.amazon.com/flash/config/domain/devo?config_page_number=1&config_page_size=2500&left_tree_spec_id=KLLpSjs%2Fn%2FU%3D

https://phonetool.amazon.com/users/jordaaw?


### DMR With Ryan

Want to introduce a new global attribute `kor_reciept_item_handoff_id`

Business activity and Financial component

A new minor version added to the schema - version 1.1 with the new attribute.
All future updates will require the additional value

Maybe add a new schema definition where we

Should be added a Global Searchable Attribute

Add as a Match Key

Can the list be addded as Global Searchable attributes (searchable_attributes column)

Remove **asin** from searchable_attributes

Add the Searchable attributes as Global Searchable Attributes

Possibly remove the `_out` and `_in` from the Business Activity.

Check if we can change financial component group to something more specific

** Next Steps

* Check attributes with Accounting team again.
* Create a CR, and get reviewed


{
   "message":"Multiple Client Errors:[Missing required attribute(s). `origin: input` attributes are missing from the source attributes, other attributes might be missing a corresponding derivation logic Schema Definition Processing Error]",
   "errors":[
      {
         "error_type":"missing_required_attributes_error",
         "error_message":"Missing required attribute(s). `origin: input` attributes are missing from the source attributes, other attributes might be missing a corresponding derivation logic",
         "record_id":"986",
         "attributes":[
            {
               "attribute":"company_code"
            },
            {
               "attribute":"product_line"
            },
            {
               "attribute":"gl_line_description"
            },
            {
               "attribute":"debit_or_credit"
            },
            {
               "attribute":"channel"
            },
            {
               "attribute":"location"
            },
            {
               "attribute":"set_of_books"
            },
            {
               "attribute":"gl_journal_category"
            },
            {
               "attribute":v1_legacy_business_name
            },
            {
               "attribute":"project"
            },
            {
               "attribute":"cost_center"
            },
            {
               "attribute":"account_number"
            }
         ],
         "suggestions":[
            "Required attributes not marked with any 'origin' value should be present in the input message or a derivation rule should be added to derive a value for this attribute."
         ]
      },
      {
         "error_type":"schema_definition_processing_error",
         "record_id":"986",
         "error_message":"Schema Definition Processing Error",
         "missing_attributes_for_schema_definitions":[
            {
               "schema_definition":"Chart of Accounts@1.0",
               "missing_attributes":[
                  "company_code",
                  "location",
                  "cost_center",
                  "account_number",
                  "product_line",
                  "channel",
                  "project"
               ]
            },
            {
               "schema_definition":"Ledger Input@1.0",
               "missing_attributes":[
                  "debit_or_credit",
                  "set_of_books",
                  "gl_line_description",
                  "gl_journal_category"
               ]
            }
         ]
      }
   ],
   "input_request":[

   ],
   "errored_records":[
      {
         "record_id":"986",
         "input_attributes":{
            "amazon_shipment_ref_id":"REG.TRSUHRQSEC-0-1",
            "asin":"B00DR0PDNE",
            "business_activity":"warehouse_transfer_shipment_handoff",
            "business_country_code":"GB",
            "business_namespace":"kindle_offline_retail",
            "destination_inventory_owner_group_id":7,
            "destination_warehouse_country_code":"GB",
            "destination_warehouse_id":EDI4,
            "destination_warehouse_type":"kor_inventory_location",
            "financial_component":"kor_warehouse_transfer_inventory_item",
            "financial_component_date":"2013-11-20T00":"00":30.000Z,
            "financial_component_group":"inventory_movement",
            "functional_amount":{
               "currency_code":"GBP",
               "value":1.00
            },
            "gl_product_group":"gl_book",
            "idempotence_id":"KORServiceTransactionLineItemId.1234",
            "idempotence_version":1,
            "inventory_cost_audit_type":"REG.KOR",
            "inventory_cost_id":"1234",
            "kor_availability_sku":"AVDKWI29MI1MI",
            "kor_business_event_id":"TOAK129SJ9.1",
            "kor_business_transaction_id":"2991828437201",
            "kor_lot_sku":"LTME2DOODBGR",
            "kor_packaging_sku":"PKLKJD298KLD38",
            "kor_reference_event_id":"TOAK129SJ9",
            "kor_service_transaction_id":"912873291",
            "kor_service_transaction_line_item_id":"1234",
            "local_amount":{
               "value":1.00,
               "currency_code":"GBP"
            },
            "quantity":1,
            "source_inventory_owner_group_id":1,
            "source_warehouse_country_code":"GB",
            "source_warehouse_id":"EDIX",
            "source_warehouse_type":"kor_inventory_location",
            "transaction_date":"2013-11-20T00":"00":30.000Z,
            "unit_cost":{
               "value":1.00,
               "currency_code":"GBP"
            }
         },
         "derived_attributes":{
            "schema_definitions":[
               "Chart of Accounts@1.0",
               "Ledger Input@1.0",
               "FLASH Core Attributes@1.0",
               "Financial Record Input@1.0",
               "Flare Platform@1.0"
            ]
         },
         "condition_attributes":{
            "business_activity":"warehouse_transfer_shipment_handoff",
            "business_country_code":"GB",
            "business_namespace":"kindle_offline_retail",
            "financial_component":"kor_warehouse_transfer_inventory_item"
         }
      }
   ],
   "type":"bad_request",
   "posting_source_system":"FlashAAAShim",
   "method":"post",
   "request_uri":"/message/postWithoutPersistence",
   "aaa_operation":"postWithoutPersistence",
   "hostname":"hobbes-integ-2cm5xl-b232d94a.us-west-2.amazon.com"
}
