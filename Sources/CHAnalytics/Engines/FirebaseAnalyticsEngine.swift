import Foundation
@_implementationOnly import FirebaseCore
@_implementationOnly import FirebaseAnalytics
@_implementationOnly import FirebaseCrashlytics
@_implementationOnly import CHLogger

public class FirebaseAnalyticsEngine: AnalyticsEngine {
    private let logger = log
    
    public init() {}
    
    public func configure(for configuration: AnalyticsConfiguration) {
        switch configuration {
        case .applicationDidFinishLaunching:
            guard FirebaseApp.app() == nil else {
                logger.warning("Firebase already configured")
                return
            }
            FirebaseApp.configure()
            logger.info("Firebase Analytics configured")
        default:
            break
        }
    }
    
    public func track(event: AnalyticsEvent) {
        var parameters: [String: Any]?
        
        event.parameters?.forEach { key, value in
            parameters = parameters ?? [:]
            let trimmedKey = String(key.prefix(40))
            
            if let stringValue = value as? String {
                parameters?[trimmedKey] = String(stringValue.prefix(100))
            } else {
                parameters?[trimmedKey] = value
            }
        }
        
        let eventName = String(event.name.prefix(40))
        FirebaseAnalytics.Analytics.logEvent(eventName, parameters: parameters)
        
        logger.debug("Firebase: Tracked event '\(eventName)' with \(parameters?.count ?? 0) parameters")
    }
    
    public func track(userProperty: AnalyticsUserProperty) {
        for (key, value) in userProperty.properties {
            let propertyKey = String(key.prefix(24))
            let propertyValue = value as? String ?? "\(value)"
            let trimmedValue = String(propertyValue.prefix(36))
            
            FirebaseAnalytics.Analytics.setUserProperty(trimmedValue, forName: propertyKey)
        }
        
        logger.debug("Firebase: Set \(userProperty.properties.count) user properties")
    }
    
    public func setUser(identifier: String?) {
        FirebaseAnalytics.Analytics.setUserID(identifier)
        Crashlytics.crashlytics().setUserID(identifier ?? "")
        logger.debug("Firebase: Set user ID to \(identifier ?? "nil")")
    }
    
    public func reset() {
        FirebaseAnalytics.Analytics.setUserID(nil)
        Crashlytics.crashlytics().setUserID("")
        logger.debug("Firebase: Reset user data")
    }
}