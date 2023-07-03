import { WebPlugin } from '@capacitor/core';

import type { inAppPurchasePlugin } from './definitions';

export class inAppPurchaseWeb extends WebPlugin implements inAppPurchasePlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
