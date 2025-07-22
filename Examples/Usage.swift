import CHAnalytics

func setupAnalytics() {
    let analytics = Analytics {
        FirebaseAnalyticsEngine()
        AmplitudeAnalyticsEngine(apiKey: "your-amplitude-key")
        ConsoleAnalyticsEngine()
    }
    
    analytics.configure(for: .applicationDidFinishLaunching(isDebug: true))
}

func trackingExamples() {
    analytics.track(event: Event.screenView(screen: "HomeScreen"))
    
    analytics.track(event: Event.buttonTap(buttonName: "SignUp", screen: "LoginScreen"))
    
    analytics.track(event: Event.purchase(amount: 9.99, currency: "USD", itemName: "Premium"))
    
    analytics.track(event: Event(name: "custom_event", parameters: [
        "category": "engagement",
        "value": 42
    ]))
    
    analytics.track(userProperty: UserProperty(properties: [
        "subscription_tier": "premium",
        "onboarding_completed": true
    ]))
    
    analytics.setUser(identifier: "user-123")
    
    analytics.setGlobalProperty(key: "app_version", value: "1.0.0")
}