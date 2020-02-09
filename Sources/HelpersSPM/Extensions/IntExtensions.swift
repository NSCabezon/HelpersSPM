import Foundation

public extension Int {
    var isOdd: Bool {
        return self % 2 == 0
    }
    
    var isEven: Bool {
        return !self.isOdd
    }
}
