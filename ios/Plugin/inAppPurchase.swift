import Foundation
import Capacitor

@objc public class inAppPurchase: NSObject {
    
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
    @objc public func list(_ list: [String: String]) -> String {
        print(list)
        return "hello"
    }
}
