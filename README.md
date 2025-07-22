# CHAnalytics

A comprehensive Swift package for analytics tracking across iOS apps, supporting multiple providers with a clean, type-safe API.

## Features

- 🎯 **Multi-Provider Support** - Track to Firebase, Amplitude, and console simultaneously
- 🏗️ **Type-Safe Events** - Structured event and user property protocols
- 🌐 **Global Properties** - Set once, included in all events automatically
- 🔧 **Result Builder Syntax** - Clean, declarative setup
- 🐛 **Debug Support** - Console engine with emoji indicators for development
- 📱 **UIKit Integration** - Easy app lifecycle integration
- ✅ **Well Tested** - Comprehensive test suite with mock implementations

## Installation

### Swift Package Manager

Add CHAnalytics to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/Chainless-Dev/CHAnalytics.git", from: "1.0.0")
]
```

Or add it through Xcode:
1. File → Add Package Dependencies
2. Enter: `https://github.com/Chainless-Dev/CHAnalytics.git`

## Quick Start

### Basic Setup

```swift
import CHAnalytics

// Setup analytics with multiple providers
let analytics = Analytics {
    FirebaseAnalyticsEngine()
    AmplitudeAnalyticsEngine(apiKey: "your-amplitude-key")
    ConsoleAnalyticsEngine() // For debugging
}

// Configure on app launch
analytics.configure(for: .applicationDidFinishLaunching(isDebug: true))
```

### Track Events

```swift
// Screen tracking
analytics.track(event: Event.screenView(screen: "HomeScreen"))

// User actions
analytics.track(event: Event.buttonTap(buttonName: "SignUp", screen: "LoginScreen"))

// E-commerce
analytics.track(event: Event.purchase(amount: 9.99, currency: "USD", itemName: "Premium"))

// Custom events
analytics.track(event: Event(name: "custom_event", parameters: [
    "category": "engagement",
    "value": 42
]))
```

### User Properties

```swift
// Set user properties
analytics.track(userProperty: UserProperty(properties: [
    "subscription_tier": "premium",
    "onboarding_completed": true
]))

// Set user identifier
analytics.setUser(identifier: "user-123")

// Set global properties (included in all subsequent events)
analytics.setGlobalProperty(key: "app_version", value: "1.0.0")
```

## Supported Providers

### Firebase Analytics

Automatically handles Firebase parameter limitations and integrates with Crashlytics.

```swift
let firebaseEngine = FirebaseAnalyticsEngine()
```

### Amplitude

Uses the modern Amplitude-Swift SDK with full feature support.

```swift
let amplitudeEngine = AmplitudeAnalyticsEngine(apiKey: "your-api-key")

// Access Amplitude-specific features
let sessionId = amplitudeEngine.sessionId
```

### Console (Debug)

Perfect for development - logs events to console with emoji indicators.

```swift
let consoleEngine = ConsoleAnalyticsEngine()
// Outputs: 🎯 EVENT: screen_view | Parameters: screen_name: HomeScreen
```

## UIKit Integration

Convenient extensions for app lifecycle tracking:

```swift
// In your AppDelegate
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    analytics.configure(application: application, launchOptions: launchOptions)
    return true
}

func applicationDidBecomeActive(_ application: UIApplication) {
    analytics.handleApplicationDidBecomeActive()
}

func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    analytics.handleOpen(url: url)
    return true
}
```

## Testing

CHAnalytics includes comprehensive testing support:

```swift
import XCTest
@testable import CHAnalytics

// Use the built-in MockAnalyticsEngine for testing
let mockEngine = MockAnalyticsEngine()
let analytics = Analytics(engines: [mockEngine])

analytics.track(event: Event(name: "test_event"))

XCTAssertEqual(mockEngine.trackedEvents.count, 1)
XCTAssertEqual(mockEngine.trackedEvents.first?.name, "test_event")
```

## Platform Support

- iOS 13.0+
- macOS 11.0+
- tvOS 13.0+
- watchOS 6.0+

## Dependencies

- [CHLogger](https://github.com/Chainless-Dev/CHLogger) - Internal logging (implementation only)
- [Firebase iOS SDK](https://github.com/firebase/firebase-ios-sdk) - Firebase Analytics & Crashlytics
- [Amplitude-Swift](https://github.com/amplitude/Amplitude-Swift) - Amplitude analytics

## API Reference

### Core Types

#### `Analytics`
Main analytics coordinator that manages multiple engines.

#### `AnalyticsEvent`
Protocol for defining trackable events.
- `name: String` - Event name
- `parameters: [String: Any]?` - Event parameters

#### `AnalyticsUserProperty`
Protocol for user properties.
- `setOnce: Bool` - Whether to set property only once
- `properties: [String: Any]` - Property key-value pairs

#### `AnalyticsEngine`
Protocol for analytics providers.

### Convenience Types

#### `Event`
Built-in event implementation with convenience initializers:
- `screenView(screen:)`
- `buttonTap(buttonName:screen:)`
- `purchase(amount:currency:itemName:)`
- `login(method:)`
- `signUp(method:)`
- `search(query:)`
- `share(contentType:itemId:)`

#### `UserProperty`
Built-in user property implementation.

## Contributing

We welcome contributions! Please feel free to submit a Pull Request.

## License

This project is available under the MIT license. See the LICENSE file for more info.

## Support

For issues and questions, please use [GitHub Issues](https://github.com/Chainless-Dev/CHAnalytics/issues).