import Foundation
@_implementationOnly import CHLogger

public class Analytics {
    private let engines: [AnalyticsEngine]
    private let logger = log
    private var globalProperties: [String: Any] = [:]
    
    public static let shared = Analytics(engines: [])
    
    public init(engines: [AnalyticsEngine]) {
        self.engines = engines
    }
    
    public func configure(for configuration: AnalyticsConfiguration) {
        logger.debug("Configuring analytics engines for: \(configuration)")
        engines.forEach { $0.configure(for: configuration) }
    }
    
    public func track(event: AnalyticsEvent) {
        logger.debug("Tracking event: \(event.name)")
        
        let enrichedEvent: AnalyticsEvent
        if !globalProperties.isEmpty {
            var parameters = event.parameters ?? [:]
            globalProperties.forEach { parameters[$0.key] = $0.value }
            enrichedEvent = Event(name: event.name, parameters: parameters)
        } else {
            enrichedEvent = event
        }
        
        engines.forEach { $0.track(event: enrichedEvent) }
    }
    
    public func track(userProperty: AnalyticsUserProperty) {
        logger.debug("Tracking user property with \(userProperty.properties.count) properties")
        engines.forEach { $0.track(userProperty: userProperty) }
    }
    
    public func setUser(identifier: String?) {
        logger.debug("Setting user identifier: \(identifier ?? "nil")")
        engines.forEach { $0.setUser(identifier: identifier) }
    }
    
    public func setDevice(identifier: String?) {
        logger.debug("Setting device identifier: \(identifier ?? "nil")")
        engines.forEach { $0.setDevice(identifier: identifier) }
    }
    
    public func setGlobalProperty(key: String, value: Any?) {
        if let value = value {
            globalProperties[key] = value
            logger.debug("Set global property: \(key) = \(value)")
        } else {
            globalProperties.removeValue(forKey: key)
            logger.debug("Removed global property: \(key)")
        }
    }
    
    public func reset() {
        logger.debug("Resetting analytics")
        globalProperties.removeAll()
        engines.forEach { $0.reset() }
    }
}