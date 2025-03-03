import Foundation

func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

func delay(_ delay: Double, closure: @Sendable @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}
