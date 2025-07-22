import Foundation
@_implementationOnly import CHLogger

public class ConsoleAnalyticsEngine: AnalyticsEngine {
    private let logger = log
    private var userIdentifier: String?
    private var deviceIdentifier: String?
    
    public init() {}
    
    public func configure(for configuration: AnalyticsConfiguration) {
        logger.info("Console Analytics configured for: \(configuration)")
    }
    
    public func track(event: AnalyticsEvent) {
        var logMessage = "🎯 EVENT: \(event.name)"
        
        if let parameters = event.parameters, !parameters.isEmpty {
            let paramStrings = parameters.map { "\($0.key): \($0.value)" }
            logMessage += " | Parameters: \(paramStrings.joined(separator: ", "))"
        }
        
        if let userIdentifier = userIdentifier {
            logMessage += " | User: \(userIdentifier)"
        }
        
        if let deviceIdentifier = deviceIdentifier {
            logMessage += " | Device: \(deviceIdentifier)"
        }
        
        logger.info(logMessage)
    }
    
    public func track(userProperty: AnalyticsUserProperty) {
        let propertyStrings = userProperty.properties.map { "\($0.key): \($0.value)" }
        let setType = userProperty.setOnce ? "SET_ONCE" : "SET"
        
        logger.info("👤 USER PROPERTY (\(setType)): \(propertyStrings.joined(separator: ", "))")
    }
    
    public func setUser(identifier: String?) {
        userIdentifier = identifier
        logger.info("👤 USER ID: \(identifier ?? "nil")")
    }
    
    public func setDevice(identifier: String?) {
        deviceIdentifier = identifier
        logger.info("📱 DEVICE ID: \(identifier ?? "nil")")
    }
    
    public func reset() {
        userIdentifier = nil
        deviceIdentifier = nil
        logger.info("🔄 RESET: Cleared user and device identifiers")
    }
}