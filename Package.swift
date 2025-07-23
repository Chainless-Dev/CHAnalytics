// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CHAnalytics",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "CHAnalytics",
            targets: ["CHAnalytics"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Chainless-Dev/CHLogger.git", exact: "1.0.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", exact: "11.15.0"),
        .package(url: "https://github.com/amplitude/Amplitude-Swift.git", exact: "1.13.9")
    ],
    targets: [
        .target(
            name: "CHAnalytics",
            dependencies: [
                .product(name: "CHLogger", package: "CHLogger"),
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk"),
                .product(name: "AmplitudeSwift", package: "Amplitude-Swift")
            ]
        ),
        .testTarget(
            name: "CHAnalyticsTests",
            dependencies: ["CHAnalytics"]
        ),
    ]
)
