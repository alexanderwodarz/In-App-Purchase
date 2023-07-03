#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(inAppPurchasePlugin, "inAppPurchase",
           CAP_PLUGIN_METHOD(echo, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(list, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getStoreProducts, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getProduct, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getPurchasedItems, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(purchase, CAPPluginReturnPromise);
)
