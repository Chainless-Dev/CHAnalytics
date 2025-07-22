import Foundation

public protocol AnalyticsEngine {
    func configure(for configuration: AnalyticsConfiguration)
    func track(event: AnalyticsEvent)
    func track(userProperty: AnalyticsUserProperty)
    func setUser(identifier: String?)
    func setDevice(identifier: String?)
    func reset()
}

public extension AnalyticsEngine {
    func setDevice(identifier: String?) { }
    func reset() { }
}