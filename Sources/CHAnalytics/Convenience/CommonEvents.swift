import Foundation

public extension Event {
    static func appLaunched() -> Event {
        Event(name: "app_launched")
    }
    
    static func appBecameActive() -> Event {
        Event(name: "app_became_active")
    }
    
    static func appEnteredBackground() -> Event {
        Event(name: "app_entered_background")
    }
    
    static func screenView(screen: String) -> Event {
        Event(name: "screen_view", parameters: ["screen_name": screen])
    }
    
    static func buttonTap(buttonName: String, screen: String? = nil) -> Event {
        var parameters: [String: Any] = ["button_name": buttonName]
        if let screen = screen {
            parameters["screen_name"] = screen
        }
        return Event(name: "button_tap", parameters: parameters)
    }
    
    static func purchase(amount: Double, currency: String, itemName: String? = nil) -> Event {
        var parameters: [String: Any] = [
            "amount": amount,
            "currency": currency
        ]
        if let itemName = itemName {
            parameters["item_name"] = itemName
        }
        return Event(name: "purchase", parameters: parameters)
    }
    
    static func login(method: String) -> Event {
        Event(name: "login", parameters: ["method": method])
    }
    
    static func signUp(method: String) -> Event {
        Event(name: "sign_up", parameters: ["method": method])
    }
    
    static func search(query: String) -> Event {
        Event(name: "search", parameters: ["query": query])
    }
    
    static func share(contentType: String, itemId: String? = nil) -> Event {
        var parameters: [String: Any] = ["content_type": contentType]
        if let itemId = itemId {
            parameters["item_id"] = itemId
        }
        return Event(name: "share", parameters: parameters)
    }
}