
# Build Client for Tech MicroService and Update Imports
*Repeated for each of the 4 applications*

### **Summary**:

**As a** developer, **I want** to build a client for  Tech MicroService and update imports in the existing React application to use the new client **so that** I can  seamlessly integrate services with the application, replacing the old client and ensuring proper functionality.

### **Background:**

The previous story developed a new Coral Module, that exposes certain functionalities we want to use in our existing React application. To integrate this service, we need to build a compatible client that can make requests to  Additionally, we must update all the imports and usages of the old client with the new one in our application.

### **Description:**

This story outlines the steps to build a client for   Tech MicroService and then update the existing React application to use this client. The new client should be designed to work seamlessly with the existing application codebase.

### **Step 1: Create  Client**

Define a valid OpenAPI document specification for the  client based on the [Coral Model](https://code.amazon.com/packages/ This specification describes the available functionalities and data structures that can be used with the  service. A tool exists to make this conversion: https://code.amazon.com/packages/Coral2Swagger/trees/mainline but I do not know how well it works.

Coral Services also expose their Model: https://kdms-na-beta.integ.amazon.com/explorer/model.json in Great detail. This could be configured to automatically pull in the published model and convert it into an OpenAPI doc standard.

```
// Model should be valid OpenAPI document specification
 = {
  'Inbound {
      'properties': {
          'processingPath': {
              'items': {
                  'Individual': 'Individual',
                  'Bulk': 'Bulk'
              },
              'type': 'enum'
          },
          'rmaID': {
              'type': 'NonEmptyStringUpTo45Chars',
              'title': 'Enter Shipment ID'
          },
          'returnEventType': {
              'items': {
                  'Rework': 'Rework',
                  'Transship': 'Transship',
                  'AddIn': 'AddIn',
                  'Offline': 'Offline'
              },
              'type': 'enum'
          },
          'dsn': {
              'type': 'NonEmptyStringUpTo45Chars'
          },
      },
      'required': [
          'dsn'
      ],
      'type': 'object'
  }
};
```


Create a client factory for  based on the defined OpenAPI document specification. This factory allows the creation of a  client.

```
 = CoralClient.factory(
```

### **Step 2: Integrate  Client**

Use the newly created  client to make requests to  services, replacing the old client usage. Update all instances in the codebase where the old client is utilized.

```
 'fcCode': 'Rufus', 'asin': 'Rufus', 'labelId': 1994 });
```

### **Step 3: Update Imports**

Go through the entire codebase and update all import statements for the old client to use the new  client instead.

```
// Replace the old import
**`import`**` ``{`` `` ``}`` `**`from`**` ``'@coral'``;`

// With the new  client import
**`import`**` ``{`` `` ``}`` `**`from`**` ``'./
```

### **Step 4: Testing and Validation**

Test the application thoroughly to ensure that it functions correctly with the new  client. Verify that all functionalities remain intact and data is fetched accurately.

Perform integration tests to validate that  services are properly consumed.

### **Step 5: Documentation**

Update the application's documentation to reflect the changes and the use of the new  client.


### **Acceptance Criteria**:

* **Should have**: A  client built according to the defined OpenAPI document specification.
* **Should have**: All imports in the application codebase updated to use the new  client.
* **Should have**: Successful testing and validation of the application with the new  client.
* **Should have**: Updated documentation reflecting the changes and the use of the new client.
