# @alexanderwodarz/capacitor-ios-inapppurchase

Allows Capacitor Vue Apps to add in app purchases for iOS

## Install

```bash
npm install @alexanderwodarz/capacitor-ios-inapppurchase
npx cap sync
```

## Preparations
1. After installation open Xcode
2. Click on Project Navigator > App
3. Create a new "StoreKit Configuration File" file with name "Product"
4. Create a new "Property List" file with name "PropertyList"
5. Make sure that both files are directly in "App" located and not in any other directory
6. Click in Project Navigator on Product and configure your products
7. Click on PropertyList and map your Reference Name with your id
8. Press CMD + Shift + , to open "scheme edit"
9. Select left Run and Options
10. Select "Product.storekit" in "StoreKit Configuration"

## Notes
Currently just tested with "Non-Consumable In-App Purchase"

## API

<docgen-index>

* [`list(...)`](#list)
* [`getStoreProducts()`](#getstoreproducts)
* [`getPurchasedItems()`](#getpurchaseditems)
* [`getProduct(...)`](#getproduct)
* [`purchase(...)`](#purchase)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### list(...)

```typescript
list(options: { list: [registerProduct]; }) => Promise<{ value: boolean; }>
```

| Param         | Type                                      |
| ------------- | ----------------------------------------- |
| **`options`** | <code>{ list: [registerProduct]; }</code> |

**Returns:** <code>Promise&lt;{ value: boolean; }&gt;</code>

--------------------


### getStoreProducts()

```typescript
getStoreProducts() => Promise<any>
```

**Returns:** <code>Promise&lt;any&gt;</code>

--------------------


### getPurchasedItems()

```typescript
getPurchasedItems() => Promise<any>
```

**Returns:** <code>Promise&lt;any&gt;</code>

--------------------


### getProduct(...)

```typescript
getProduct(options: { id: string; }) => Promise<{ value: string; }>
```

| Param         | Type                         |
| ------------- | ---------------------------- |
| **`options`** | <code>{ id: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### purchase(...)

```typescript
purchase(options: { id: string; }) => Promise<{ value: boolean; }>
```

| Param         | Type                         |
| ------------- | ---------------------------- |
| **`options`** | <code>{ id: string; }</code> |

**Returns:** <code>Promise&lt;{ value: boolean; }&gt;</code>

--------------------


### Interfaces


#### registerProduct

| Prop            | Type                |
| --------------- | ------------------- |
| **`reference`** | <code>string</code> |
| **`id`**        | <code>string</code> |

</docgen-api>
