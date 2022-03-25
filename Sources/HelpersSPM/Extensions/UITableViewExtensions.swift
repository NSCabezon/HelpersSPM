#if !os(macOS) && !os(watchOS)
import UIKit

public extension UITableView {
	func registerNib<T: UITableViewCell>(_ type: T.Type) {
		register(T.nib, forCellReuseIdentifier: T.nibName)
	}
	
	func registerNibWithBundle<T: UITableViewCell>(_ type: T.Type) {
		register(T.nibWithBundle, forCellReuseIdentifier: T.nibName)
	}
	
	func registerClass<T: UITableViewCell>(_ type: T.Type) {
		register(T.self, forCellReuseIdentifier: T.nibName)
	}

	func registerHeader<H: UITableViewHeaderFooterView>(_ type: H.Type) {
        register(H.nib, forHeaderFooterViewReuseIdentifier: H.nibName)
    }
	
	func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type = T.self) -> T? {
		return self.dequeueReusableCell(withIdentifier: cellType.nibName) as? T
	}
	
	func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath, cellType: T.Type = T.self) -> T? {
		return self.dequeueReusableCell(withIdentifier: cellType.nibName, for: indexPath) as? T
	}
	
	func dequeueReusableHeaderFooterView<H: UITableViewHeaderFooterView>() -> H {
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: H.nibName) as? H else {
            fatalError("\(H.nibName) could not be dequeued as \(H.self)")
        }
        return header
    }
}
#endif
