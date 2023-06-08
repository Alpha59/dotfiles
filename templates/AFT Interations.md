# AFT Interations 

These are all of the places where we interact with AFT throughout our system. 

Inbound Service: 
	Inbound Receipt Message Handler:
		trigger:
		    sender: CReturns UI
		    source: sqs 
		input: 
	    - Return Item Id
	    - RML Trackign Id
	    - Marketplace Id
	    - ASIN
	    - Serial Number
	    - FIFO Cost
	    - handling Warehouse ID
	    - Item Condition
	    - Container ID
	    - Employee ID
	    - LPN
		response: null
		notes: "In order to inbound messages, we must de-register, and delete the device profile for these messages. This requires to response, although a DLQ for runtime messages would be extremely helpful. 
		actions: 
		    De-register Device:
		        input:
	            - dsn
		        dependency: DeviceMasterService
		        response: null
		    Delete Device Profile:
		        input: 
		        - dsn
		        dependency:  FTVDP Management Service
		        response: null
		    Request Replacement:
		        input: 
	            - claimCode
	            - customerID
		        dependency: Concessions Service
		        response: orderId
		    *Get ASIN From LPN*
		    	  async_compatible: false
		        input: 
		           - lpn
		        dependency: AFT
		        response: 
		           - ASIN
		    *Validate Or Create Inventory*
		    	 async_compatible: true
		       input:  // Calls DRII.validateOrCreateInventory
	           - lpn
	           - containerID
	           - DSN
	           - Device Status
	           - ReturnEventType
	           - (Amount)
	           - (Unit)
	           - (Date)
	           - (ReceiptSource)
		        dependency: AFT
		        response: 
		           - ASIN
		 save
        - orderID
        - Promise Date
        - Expected Ship Date
        - Recieved ID
        - Scanable Container ID
        - Recieve ID
        - RMA ID
        - DSN 
        - Item Condition
        - FIFO Cost
        - FIFO Currency
        - IOG
        - Customer ID
        - MarketPlace ID
        - RML Tracking ID
        - Return Event ID
        - ASIN
    Herd Handle Missing Return Event / Herd Handle Ownership 
        trigger: 
         	  sender: CReturns UI
            source: SQS 
        input:
        - return Event Id
        - Return Event Type
        - IOG 
        - Expected Ship Date
        response: null
        actions:
            *Transfer to Default Owner*
            	   async_compatible: true
                notes: Moves to Lumen IOG
                input:
                - lpn
                - Return Item Id
                - IOG
        		   dependency: AFT
        		   response:
        		   - IOG
        save:
        - IOG
Outbound Service: 
    Activate Device
        trigger: 
            sender: CReturns IU
            source: SQS
        input:
        - Inbound Device Type
        - Inbound DSN
        - Markeyplace ID
        - Return Event ID
        response: null
        actions: 
            *Get Asin By LPN*
                async_compatible: false
        	      input: 
        	      - LPN
        	      dependency: AFT
        	      response:
        	      - ASIN
        	  Fulfill Device Request:
        	      input:
        	      - Device Type
        	      - Inbound DSN
        	      - ASIN
        	      - Order ID 
        	      - Shipment Item ID
        	      - Order Item ID
        	      - Market Place Id
        	      dependency: Kindle Device Sales Service
        	      response: null   
        save: null
    Herd Set-up Inventory
        notes: Only apples when Creating Same Unit Shipment
        trigger: 
            sender: CReturn UI
            source: SQS
        input: 
        - LPN
        - outbound FC
        - scannable container ID
        - original FC SKU
        - outbound FC Code
        - IOG
        response: null
        actions:
            *Get Container* 
                async_compatible: false
        	      input: 
        	      - Container ID
        	      dependency: AFT
        	      response: AFT Container
        	  *Get Container Items*
        	      async_compatible: false
        	      input: 
        	      - AFT Container
        	      dependency: AFT
        	      response: AFT Item
        	  Get FC Sku for LPN
        	      input: 
        	      - FC Sku
        	      - FC Code
        	      dependency: FC Sku Master
        	      response: FN Sku
			  Get FN Sku for FC Sku
        	      input: 
        	      - LPN
        	      - FC Code
        	      dependency: FC Sku Master
        	      response: LPN
        	  Change FC Sku
        	      input: 
        	      - FC Sku
        	      - FC Code
        	      dependency: FC Sku Master
        	      response: null
        	  Remove Binding
        	      notes: Only if device unowned
        	      input: 
        	      - Consumer Type
        	      - FC Sku
        	      - FC Code
        	      dependency: FC Inventory Item Service
        	      response: null
        	  Flip IOG:
        	      notes: Only if IOG does not match
        	      input:
        	      - default IOG
        	      - FN Sku
        	      - IOG
        	      - Default IOG
        	  	   dependency: FC Inventory Item Service
        	  	   response: null
        save:
        - FC SKU
        - FN SKU
        - Inventory Disposition
        - IOG
	Stow Device 
		trigger: 
            sender: FC Associate
            source: API 
        input:
        - FC Code
        - FcSku
        - Source Container
        - Destination Container
        - User Id
        - Return Event ID
        - Force Stow
        - DSN
        - Return Event ID
        - Station ID
        response: null
        actions:
            *Validate Container Desitination*
                async_compatible: false
	            input: 
	            - Return Event Id
	            - Outbound Guidance
	            - Destination COntainer
	            dependency: AFT
	            response: boolean 
	         *Get or Create Container ID*
	             async_compatible: false
	             input: 
	             - containerId
	             dependency: AFT
	             response: boolean
	         *Move Item*
	             async_compatible: true
	             input:
	             - Fc Sku
	             - Container
	             - Destination Container
	             - UserId
	             dependency: AFT
	             reponse: null
	        Ship Device in OLP
	         	   input:
	         	   - FC Code
	         	   - DSN
	         	   - ReturnEventId
	         	   - Employee Id
	         	   - StationId
	        	   dependency: OLP
	        	   response: null 		
        save:
        - Guidance Rules
        - Disposition
        - Outbound Channel
        - Ship Location
        - Ship Method
        - Station Id
        - Source Container
        - Destination Container
        - Outbound Status
        - FC Sku
        - FC Code
        - User Id
	Herd Set-up Inventory
		trigger: 
            sender: FC User
            source: API (via Outbound)
        input:
        - Return Event ID
        response: null
        actions:
        save:
        - Fc Sku
        - Fn Sku
        - Inventory Disposition
Dashboard Service: 
    Deprioritize Return Event: 
        trigger: 
            sender: CS Associate
            source: API
        input:
        - Reason
        - User
        response: Device Info
        actions:
            *Deprioritize Return Event*
                async_compatible: true
        	      input: 
        	      - LPN
        	      - IOG
        	      - FC Code
        	      dependency: AFT
        	      response: IOG
        save:
        - Service Level
        - Reason
        - IOG
        - Active Status
Dashboard Website: 
    Validate Item In Container
        trigger: 
            sender: FC Associate
            source: API
        input:
        - FC Code
        - Scannable Container ID
        - Inventory ID (LPN)
        response: True / Error
        actions:
            *Validate Item in Container*
        	      input: 
        	      - FC Code
        	      dependency: AFT
        	      response:
        	      - fcSku
        save: null
	Submit Transship Request
		trigger:
			sender: FC Associate
			source: API 
		input:
		- FcCode
		- container
		- workstationId
		- is Force
		- Container Type
		actions:
			*Get Container / Validate Tote*:
			    async_compatible: false
				input:
				- fcCode
				- container
				dependency: AFT
				response: 
				- Boolean
			Submit Tranship Scan Request
				input:
				- container
				- containerType
				- workstationId
				- FcCode
				dependency: 
				response:
				- boolean
	Submit VReturn Request
		trigger:
			sender: FC Associate
			source: API 
		input:
		- FcCode
		- container
		- workstationId
		- is Force
		- Container Type
		actions:
			*Get Container / Validate Tote*:
			    async_compatible: false
				input:
				- fcCode
				- container
				dependency: AFT
				response: 
				- Boolean
			Submit Tranship Scan Request
				input:
				- container
				- containerType
				- workstationId
				- FcCode
				dependency: null
				response: null
		save:
		- scannableContainerId
		- mapped ContainerId
		- outboundShipStatus
		- containerType
		- rmaId
		- userId
		- stationId
		- shipmentId
		- actualShipDate
Device Returns Border Service: 
	Initiate Kitting:
		trigger: 
            sender: FC Associate
            source: API 
        input:
        - Return Event ID
        - outbound Channel
        - Station Touch
        - ASIN
        - Scannable Container ID
        - Disposition
        response:
        - FN Sku
        actions:
            *List WHD Item*
                async_compatible: true
        	      input:
        	      - ASIN
        	      - Scannable ContainerID
        	      - Listing Contiditon
        	      - Listing Description ID
        	      dependency: SKU Master, AFT, Warehouse Deals, Listing Service, Inventory Item
        	      response:
        	      - FN Sku
        	      - FC Sku
        	      - IOG
        	  Initiate Outbound SUS Workflow
        save:	
        - Scannable Container ID
        - FC Sku
        - FN Sku
        - ASIN
        - Disposition
        - AFT Disposition // SELLABLE
        - LPN
        - IOG
        - Station Touch
        - Return Event ID

## Other Uses

KRIBS.ExpectedShipDateCalculator Access FC Location Time Zone
KRIBS.ShipmentRequestDataGramBuilder Gets GL From FC-SKU


## Offline to do: 

Inbound UI Page: 

```
input = {
	LocationID
	WorkstationId
	scannableContainerId
	returnEventType // Offline
	shipmentId
	dsn	
	// TODO: Needs invalidity Reason
	// TODO: Needs Re-sellerID
}
```

Inbound Unit Controller:

Inbound Unit Input:

```
{
	returnEventId
	dsn
	returnEventType // Offline
	shipmentId // RMA
	scannableContainerId 
	licensePlateNumber 
	openStatus 
	defectCodes 
	workstationId
	locationId
	// TODO: Needs invalidity Reason
	// TODO: Needs Re-sellerID
}
```

```
DRBS.RecieveUnit(input) 
{ 
	PostInboundGuidance
}
```

Device Returns Border Service
// TODO: Move Post Inbound Guidance After Response from API Gateway
// Response: disposition
// TODO: DBRS Market Place Id Removed from Weblab (FC Code only)
// TODO: Use disposition from response to Problem Solve, Scrap, or Continue
// TODO: Use resellerID and ReturnEvent Type to determine if calling Single Scan offline

```
{
	rmaId
	invalidityReason
	resellerId
	locationId
	dsn
	userId
	destitionContainerId
	// TODO: Needs invalidity Reason
	// TODO: Needs Re-sellerID
}
```

// TODO: API Gateway for DRIBS
// TODO: DRIBS Single Scan Call `/v1/handle-single-device-disposition` if no invalidity reason
```
{
	resellerID
	rmaId
	scannedDeviceId
	locationId
	containerId
	userId
	warehouseDeviceId // ?
}
```

// TODO: DRIBS Single Scan Call `HandleIneligibleDeviceDispositionV2` if invalidity reason
```
{ 
	rmaId
	reason
	resellerID
	userId
	locationId
	containerId
	warehouseDeviceId // ?
}
```

// TODO: DRIBS Create Queue for CostInfo
// TODO: DRIBS Create lambda to consume Cost info and create inventory 
// TODO: Use Cost Info + DRII add Inventory to create inventory for device

