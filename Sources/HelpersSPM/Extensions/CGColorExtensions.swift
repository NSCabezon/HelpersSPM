#if !os(macOS) && !os(watchOS)
import UIKit

public extension CGColor {
    func toUIColor() -> UIColor {
        return UIColor(cgColor: self)
    }
}
#endif
