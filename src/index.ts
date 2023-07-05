import { registerPlugin } from '@capacitor/core';
// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-ignore
import type {PluginImplementations} from "@capacitor/core/types/definitions";

import type { inAppPurchasePlugin } from './definitions';
import purchase from './purchase';

const inAppPurchase: PluginImplementations = registerPlugin<inAppPurchasePlugin>('inAppPurchase', {});

export * from './definitions';
export { inAppPurchase };
export {purchase}