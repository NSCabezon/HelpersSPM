import Foundation

extension CFString: Hashable {
    var hash: Int {
        return (self as String).hash
    }
}

public func == (lhs: CFString, rhs: CFString) -> Bool {
    return CFStringCompare(lhs, rhs, CFStringCompareFlags()) == .compareEqualTo
}
