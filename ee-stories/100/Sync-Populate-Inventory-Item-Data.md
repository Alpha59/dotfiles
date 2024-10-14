
# Sync - Populate Inventory Item Data
#### [ Sync - Inventory ASIN Catalog Item Data

**INPUT**
marketplace id
ASIN

**OUTPUT**
catalog data: CatalogItemInfo ([model](https://code.amazon.com/packages/

**External Dependencies**
RestClient (datapath/query/catalog/item/hidden/)

**Description when it's being used**
fetch data associated with ASIN when getting shipping option in creating replacement option

#### [ Sync - Inventory GL from fcSku

**INPUT**
FcSKU
fc code

**OUTPUT**
GL (long)

**External Dependencies**
FCSkuMasterService.getGLByFcSku


