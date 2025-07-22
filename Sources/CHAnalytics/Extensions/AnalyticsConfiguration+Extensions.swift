import Foundation

#if canImport(UIKit)
import UIKit

public extension Analytics {
    func configure(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let isDebug = _isDebugAssertConfiguration()
        configure(for: .applicationDidFinishLaunching(isDebug: isDebug))
    }
    
    func handleApplicationDidBecomeActive() {
        configure(for: .applicationDidBecomeActive)
    }
    
    func handleApplicationDidEnterBackground() {
        configure(for: .applicationDidEnterBackground)
    }
    
    func handleApplicationWillTerminate() {
        configure(for: .applicationWillTerminate)
    }
    
    func handleOpen(url: URL) {
        configure(for: .applicationDidReceiveURL(url))
    }
}
#endif