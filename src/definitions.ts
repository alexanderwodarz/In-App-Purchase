export interface inAppPurchasePlugin {
  list(options: {list: [registerProduct]}): Promise<{value: boolean}>;
  getStoreProducts(): Promise<any>;
  getPurchasedItems(): Promise<any>;
  getProduct(options: { id: string }): Promise<{ product: string}>;
  purchase(options: {id: string}): Promise<{value: boolean}>;
}

export interface product {
  description: string,
  name: string,
  price: string
}

export interface registerProduct {
  reference: string,
  id: string
}