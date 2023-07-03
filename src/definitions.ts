export interface inAppPurchasePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  list(options: {list: [registerProduct]}): Promise<{value: boolean}>;
  getStoreProducts(): Promise<any>;
  getPurchasedItems(): Promise<any>;
  getProduct(options: { id: string }): Promise<{ value: string }>;
  purchase(options: {id: string}): Promise<{value: boolean}>;
}

export interface registerProduct {
  reference: string,
  id: string
}