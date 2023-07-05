import type { product} from "./index";
import {inAppPurchase} from "./index";

export default {
    // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types
    install: (app: any) => {
        const w = {
            getProducts: async (): Promise<[product]> => {
                const product = await inAppPurchase.getStoreProducts()
                console.log(product)
                return JSON.parse(product.products)
            },
            getProduct: async (id: string): Promise<product> => {
                const { product } = await inAppPurchase.getProduct({id})
                return JSON.parse(product)
            },
            purchase: async (id: string) => {
                const {response} = await inAppPurchase.purchase({id})
                return response
            },
            getPurchased: async() => {
                const {purchased} = await inAppPurchase.getPurchasedItems()
                return JSON.parse(purchased)
            }
        }
        inAppPurchase.addListener('purchase', (info: Record<string, any>) => {
            console.log('myPluginEvent was fired');
            const response = JSON.parse(info.response)
            if(response.error){
                alert("Es ist ein Fehler aufgetreten")
                return
            }
            console.log(response)
        })
        app.config.globalProperties.$purchase = w
        app.$purchase = w
    }
}
