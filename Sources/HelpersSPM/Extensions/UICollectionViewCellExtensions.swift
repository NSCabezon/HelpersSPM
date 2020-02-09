import Foundation
import UIKit

public extension UICollectionViewCell {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static var nibWithBundle: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}
