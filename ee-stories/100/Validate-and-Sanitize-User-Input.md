
# Validate and Sanitize User Input
## Summary:
As an Dashboard Website / RL Portal user, I want to not mess up any data if I make a silly mistake like scanning the wrong field, double-scanning a barcode, or adding extra whitespace to a field, so that I can correct these mistakes early.
As RL dev oncall, I want to have less tickets that are clearly due to bad data, so that I can focus on more important investigations.

Given, ~~a user wants to scan/input a field~~ A user is on an RL website or portal
When, a user scans this field
Then, this field is validated via the new package.

## Details:

Fields to validate:
- Delete any leading or trailing whitespace
- LPN
    - `/LPN[0-9a-zA-Z]{1,37}/`
- Container
    - `/(cs|ts).*/`
- DSN. Only validate that DSN is a valid DSN format. There are a variable number of rules for this.
- UPC
    - `/8.*0000/`
- RMA
    - DOES NOT MATCH `/(LPN|ts|cs).*/` AND DOES NOT MATCH `/8.*0000/`
-Make sure some fields are all caps (DSN,LPN,ASIN)

If a field is invalid, display a message to the user, and do NOT allow user to submit the page.

## Testing

## External Links:
Link any external tickets/files which may be helpful in this story:
https://w.amazon.com/bin/view/ItemIdentifiers
LPN format:
https://w.amazon.com/bin/view/FCSkuMasterService/FAQs/FC_FAQ#What_is_the_format_for_an_LPN_.28unit_level_identifier.29.3F
DSN format:
https://w.amazon.com/bin/view/
https://w.amazon.com/bin/view/


## Acceptance Criteria:
- Should have added field validations to the Inbound Page
- Should have implemented validation through Object Form rules
- Should have made rules exportable to other pages
