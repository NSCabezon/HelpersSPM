import Foundation

public extension Bundle {
    var buildVersion: String {
        guard let version = object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String else {
            return "-"
        }
        return version
    }
    
    var appVersion: String {
        guard let version = object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return "-"
        }
        return version
    }
    
    var applicationReadableVersion: String {
        let mainBundle = Bundle.main
        return "v\(mainBundle.appVersion) (\(mainBundle.buildVersion))"
    }
}
