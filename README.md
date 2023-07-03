# capacitor-vue-ios-inapppurchase

Allows Capacitor Vue Apps to add in app purchases for iOS

## Install

```bash
npm install capacitor-vue-ios-inapppurchase
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`list(...)`](#list)
* [`getStoreProducts()`](#getstoreproducts)
* [`getPurchasedItems()`](#getpurchaseditems)
* [`getProduct(...)`](#getproduct)
* [`purchase(...)`](#purchase)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


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
