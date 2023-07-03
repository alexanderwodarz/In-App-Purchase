import { WebPlugin } from '@capacitor/core';

import type { inAppPurchasePlugin, registerProduct } from './definitions';

export class inAppPurchaseWeb extends WebPlugin implements inAppPurchasePlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  list(options: { list: [registerProduct] }): Promise<{ value: boolean }> {
    console.log('options', options)
    return Promise.resolve({ value: false });
  }

  getStoreProducts(): Promise<any> {
    return Promise.resolve(undefined);
  }

  purchase(options: { id: string }): Promise<{ value: boolean }> {
    console.log(options)
    return Promise.resolve({ value: false });
  }

  getProduct(options: { id: string }): Promise<{ value: string }> {
    console.log(options)
    return Promise.resolve({ value: '' });
  }

  getPurchasedItems(): Promise<any> {
    return Promise.resolve(undefined);
  }



}
