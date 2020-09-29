#if !os(macOS) && !os(watchOS)
import UIKit

public extension UITableViewHeaderFooterView {
	static var nibName: String {
		return NSStringFromClass(self).components(separatedBy: ".").last!
	}
	
	static var nib: UINib {
		return UINib(nibName: nibName, bundle: nil)
	}
}
#endif
