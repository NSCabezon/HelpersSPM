import Foundation
import UIKit

public extension CGColor {
    func toUIColor() -> UIColor {
        return UIColor(cgColor: self)
    }
}
