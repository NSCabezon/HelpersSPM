#if !os(macOS) && !os(watchOS)
import UIKit

public extension UITextField {
    var textValue: String {
        return text ?? ""
    }
}
#endif
