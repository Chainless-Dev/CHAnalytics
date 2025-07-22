import Foundation

public protocol AnalyticsEvent {
    var name: String { get }
    var parameters: [String: Any]? { get }
}

public protocol AnalyticsUserProperty {
    var setOnce: Bool { get }
    var properties: [String: Any] { get }
}

public struct Event: AnalyticsEvent {
    public let name: String
    public let parameters: [String: Any]?
    
    public init(name: String, parameters: [String: Any]? = nil) {
        self.name = name
        self.parameters = parameters
    }
}

public struct UserProperty: AnalyticsUserProperty {
    public let setOnce: Bool
    public let properties: [String: Any]
    
    public init(properties: [String: Any], setOnce: Bool = false) {
        self.properties = properties
        self.setOnce = setOnce
    }
}

public enum AnalyticsConfiguration {
    case applicationDidFinishLaunching(isDebug: Bool)
    case applicationDidBecomeActive
    case applicationDidEnterBackground
    case applicationWillTerminate
    case applicationDidReceiveURL(URL)
}