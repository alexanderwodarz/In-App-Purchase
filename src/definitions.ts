export interface inAppPurchasePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
