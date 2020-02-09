import Foundation

public extension Bool {
    func toString() -> String {
        return self ? "true" : "false"
    }
    
    var isFalse: Bool {
        return !self
    }
    
    var not: Bool {
        return !self
    }
}
