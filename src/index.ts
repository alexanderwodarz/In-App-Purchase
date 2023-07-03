import { registerPlugin } from '@capacitor/core';

import type { inAppPurchasePlugin } from './definitions';

const inAppPurchase = registerPlugin<inAppPurchasePlugin>('inAppPurchase', {
  web: () => import('./web').then(m => new m.inAppPurchaseWeb()),
});

export * from './definitions';
export { inAppPurchase };
