import Foundation
@_implementationOnly import AmplitudeSwift
@_implementationOnly import CHLogger

public class AmplitudeAnalyticsEngine: AnalyticsEngine {
    private let logger = log
    private var amplitude: Amplitude?
    
    public init(apiKey: String? = nil) {
        if let apiKey = apiKey {
            self.amplitude = Amplitude(configuration: Configuration(apiKey: apiKey))
            logger.info("Amplitude Analytics configured with provided API key")
        }
    }
    
    public func configure(for configuration: AnalyticsConfiguration) {
        switch configuration {
        case .applicationDidFinishLaunching(let isDebug):
            if amplitude == nil {
                logger.warning("Amplitude API key not set. Initialize with API key.")
            }
            logger.info("Amplitude Analytics ready (debug: \(isDebug))")
        default:
            break
        }
    }
    
    public func setApiKey(_ apiKey: String) {
        self.amplitude = Amplitude(configuration: Configuration(apiKey: apiKey))
        logger.info("Amplitude API key set")
    }
    
    public func track(event: AnalyticsEvent) {
        let amplitudeEvent = BaseEvent(eventType: event.name, eventProperties: event.parameters)
        amplitude?.track(event: amplitudeEvent)
        logger.debug("Amplitude: Tracked event '\(event.name)' with \(event.parameters?.count ?? 0) parameters")
    }
    
    public func track(userProperty: AnalyticsUserProperty) {
        let identify = Identify()
        
        for (key, value) in userProperty.properties {
            if userProperty.setOnce {
                identify.setOnce(property: key, value: value)
            } else {
                identify.set(property: key, value: value)
            }
        }
        
        amplitude?.identify(identify: identify)
        logger.debug("Amplitude: Set \(userProperty.properties.count) user properties (setOnce: \(userProperty.setOnce))")
    }
    
    public func setUser(identifier: String?) {
        amplitude?.setUserId(userId: identifier)
        logger.debug("Amplitude: Set user ID to \(identifier ?? "nil")")
    }
    
    public func setDevice(identifier: String?) {
        guard let identifier = identifier else { return }
        amplitude?.setDeviceId(deviceId: identifier)
        logger.debug("Amplitude: Set device ID to \(identifier)")
    }
    
    public func reset() {
        amplitude?.setUserId(userId: nil)
        amplitude?.reset()
        logger.debug("Amplitude: Reset user data")
    }
    
    public var sessionId: Int64 {
        return amplitude?.getSessionId() ?? 0
    }
}