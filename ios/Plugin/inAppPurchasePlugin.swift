import Foundation
import Capacitor
import StoreKit

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@available(iOS 15.0, *)
@objc(inAppPurchasePlugin)
public class inAppPurchasePlugin: CAPPlugin {
    private let implementation = inAppPurchase()
    private var storeKit = StoreKitManager()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
    
    @objc func list(_ call: CAPPluginCall) {
        var list: [IonicStoreProduct] = []
        storeKit.storeProducts.forEach() {
            product in
           
                list.append(IonicStoreProduct(name: product.displayName, description: product.description, price: product.displayPrice))
            
        }
        do {
            call.resolve([
                "products": String(data: try JSONEncoder().encode(list), encoding: .utf8)!
            ])
        }catch {
            call.resolve([
                "error":true
            ])
        }
    }
    
    @objc func purchase(_ call: CAPPluginCall) {
        let product: Product? = storeKit.storeProducts.first { product in
            return product.id == call.getString("id")
        }
        guard product != nil else {
            self.notifyListeners("purchase", data: ["response" : ["error": "product not found", "id": call.getString("id")]])
            return
        }
        Task {
            do {
                
                let response = try await storeKit.purchase(product!)
                guard response != nil else {
                    let error = IonicTransactionError(productId: product!.id, error: "CANCELED OR PENDING")
                    self.notifyListeners("purchase", data: ["response" : String(data: try JSONEncoder().encode(error), encoding: .utf8)!])
                    return
                }
                let transaction = IonicTransaction(storefront: "DEU", quantity: 1, productId: response!.productID)
                    
                self.notifyListeners("purchase", data: ["response":  String(data: try JSONEncoder().encode(transaction), encoding: .utf8)!])
            }catch {
                switch error {
                case StoreError.failedVerification:
                    self.notifyListeners("purchase", data: ["response" : ["error":"purchase not verified", "id":call.getString("id")]])
                    
                default :
                    self.notifyListeners("purchase", data: ["response" : ["error":"unknown error", "id":call.getString("id")]])
                }
            }
            
        }
    }
    
    @objc func getPurchasedItems(_ call: CAPPluginCall){
        do {
            var list: [IonicStoreProduct] = []
            storeKit.storeProducts.forEach() {
                product in
                if((try? storeKit.isPurchased(product)) != nil){
                    list.append(IonicStoreProduct(name: product.displayName, description: product.description, price: product.displayPrice))
                }
            }
            call.resolve([
                "purchased": String(data: try JSONEncoder().encode(list), encoding: .utf8)!
            ])
        } catch {
            call.resolve(["error": true])
        }
    }
    
    @objc func getProduct(_ call: CAPPluginCall) {
        do {
            let product: Product = storeKit.storeProducts.first { product in
                return product.id == call.getString("id")
            }!
            call.resolve([
                "product": String(data: try JSONEncoder().encode(IonicStoreProduct(name: product.displayName, description: product.description, price: product.displayPrice)), encoding: .utf8)!
            ])
        } catch {
            call.resolve([
                "product": ""
            ])
        }
    }
    
    @objc func getStoreProducts(_ call: CAPPluginCall) {
        var list: [IonicStoreProduct] = []
        storeKit.storeProducts.forEach() {
            product in
            list.append(IonicStoreProduct(name: product.displayName, description: product.description, price: product.displayPrice))
        }
        do {
            call.resolve([
                "products": String(data: try JSONEncoder().encode(list), encoding: .utf8)!
            ])
        } catch {
            call.resolve([
                "products": ""
            ])
        }
    }
}

struct IonicTransactionError : Codable {
    let productId: String
    let error: String
}

struct IonicTransaction : Codable {
    let storefront: String
    let quantity: Int
    let productId: String
}

struct IonicStoreProduct : Codable {
    let name : String
    let description : String
    let price : String
}

@available(iOS 15.0, *)
class StoreKitManager: ObservableObject {
    
    @Published var storeProducts: [Product] = []
    @Published var purchasedCourses: [Product] = []
    
    var updateListenerTask: Task<Void, Error>? = nil
    
    var productDict: [String : String]
    
    init () {
        if let plistPath = Bundle.main.path(forResource: "PropertyList", ofType: "plist"),
           let plist = FileManager.default.contents(atPath: plistPath) {
            productDict = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String : String]) ?? [:]

        } else {
            productDict = [:]
        }
        
        updateListenerTask = listenForTransactions()
        
        Task {
            await requestProducts()
            
            await updateCustomerProductStatus()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    await self.updateCustomerProductStatus()
                    await transaction.finish()
                    print("GOT NEW TRANSACTION")
                    //inAppPurchasePlugin.plugin!.notifyListeners("purchase", data: ["testing":result])
                } catch {
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    @MainActor
    func requestProducts() async {
        do {
            storeProducts = try await Product.products(for: productDict.values)
        } catch {
            print("failed - error retrieving products \(error)")
        }
    }
    
    
    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        switch result {
        case .success(let verificationResult):
            let transaction = try checkVerified(verificationResult)
            await updateCustomerProductStatus()
            await transaction.finish()
            
            //inAppPurchasePlugin.plugin!.notifyListeners("purchase", data: ["testing" : result])
            return transaction
                
        case .userCancelled, .pending:
            //inAppPurchasePlugin.plugin!.notifyListeners("purchase", data: ["testing" : result])
            print(result)
            return nil
            
        default:
            return nil
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let signedType):
            return signedType
        }
    }
    
    @MainActor
    func updateCustomerProductStatus() async {
        var purchaedCourses: [Product] = []
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                if let course = storeProducts.first(where: { $0.id == transaction.productID}) {
                    purchaedCourses.append(course)
                }
            } catch {
                print("Transaction failed verification")
            }
            self.purchasedCourses = purchaedCourses
        }
    }
    
    func isPurchased(_ product: Product) throws -> Bool {
        return purchasedCourses.contains(product)
    }
    
}

public enum StoreError: Error {
    case failedVerification
}
