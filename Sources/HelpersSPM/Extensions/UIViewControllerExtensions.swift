import UIKit

public extension UIViewController {
	static func initFromStoryboard<T>(name: String, identifier: String) -> T {
		guard let viewController = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier) as? T else {
			fatalError("\(identifier) could not be loaded from \(name) as \(T.self)")
        }
        
        return viewController
    }
}
