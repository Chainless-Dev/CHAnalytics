import XCTest
@testable import CHAnalytics

final class CHAnalyticsTests: XCTestCase {
    var mockEngine: MockAnalyticsEngine!
    var analytics: Analytics!
    
    override func setUp() {
        super.setUp()
        mockEngine = MockAnalyticsEngine()
        analytics = Analytics(engines: [mockEngine])
    }
    
    override func tearDown() {
        mockEngine = nil
        analytics = nil
        super.tearDown()
    }
    
    func testTrackEvent() {
        let event = Event(name: "test_event", parameters: ["key": "value"])
        analytics.track(event: event)
        
        XCTAssertEqual(mockEngine.trackedEvents.count, 1)
        XCTAssertEqual(mockEngine.trackedEvents.first?.name, "test_event")
    }
    
    func testTrackEventWithGlobalProperties() {
        analytics.setGlobalProperty(key: "global_key", value: "global_value")
        
        let event = Event(name: "test_event", parameters: ["key": "value"])
        analytics.track(event: event)
        
        XCTAssertEqual(mockEngine.trackedEvents.count, 1)
        let trackedEvent = mockEngine.trackedEvents.first!
        XCTAssertEqual(trackedEvent.parameters?["key"] as? String, "value")
        XCTAssertEqual(trackedEvent.parameters?["global_key"] as? String, "global_value")
    }
    
    func testSetUserIdentifier() {
        analytics.setUser(identifier: "user123")
        
        XCTAssertEqual(mockEngine.userIdentifier, "user123")
    }
    
    func testReset() {
        analytics.setGlobalProperty(key: "test", value: "value")
        analytics.reset()
        
        XCTAssertTrue(mockEngine.resetCalled)
    }
}

class MockAnalyticsEngine: AnalyticsEngine {
    var trackedEvents: [AnalyticsEvent] = []
    var trackedUserProperties: [AnalyticsUserProperty] = []
    var userIdentifier: String?
    var deviceIdentifier: String?
    var resetCalled = false
    var configurationEvents: [AnalyticsConfiguration] = []
    
    func configure(for configuration: AnalyticsConfiguration) {
        configurationEvents.append(configuration)
    }
    
    func track(event: AnalyticsEvent) {
        trackedEvents.append(event)
    }
    
    func track(userProperty: AnalyticsUserProperty) {
        trackedUserProperties.append(userProperty)
    }
    
    func setUser(identifier: String?) {
        userIdentifier = identifier
    }
    
    func setDevice(identifier: String?) {
        deviceIdentifier = identifier
    }
    
    func reset() {
        resetCalled = true
        userIdentifier = nil
        deviceIdentifier = nil
        trackedEvents.removeAll()
        trackedUserProperties.removeAll()
    }
}