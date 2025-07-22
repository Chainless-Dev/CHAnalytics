import Foundation

@resultBuilder
public struct AnalyticsEngineBuilder {
    public static func buildBlock(_ engines: AnalyticsEngine...) -> [AnalyticsEngine] {
        engines
    }
    
    public static func buildArray(_ engines: [AnalyticsEngine]) -> [AnalyticsEngine] {
        engines
    }
    
    public static func buildOptional(_ engine: AnalyticsEngine?) -> AnalyticsEngine? {
        engine
    }
    
    public static func buildEither(first engine: AnalyticsEngine) -> AnalyticsEngine {
        engine
    }
    
    public static func buildEither(second engine: AnalyticsEngine) -> AnalyticsEngine {
        engine
    }
}

public extension Analytics {
    convenience init(@AnalyticsEngineBuilder _ builder: () -> [AnalyticsEngine]) {
        self.init(engines: builder())
    }
}