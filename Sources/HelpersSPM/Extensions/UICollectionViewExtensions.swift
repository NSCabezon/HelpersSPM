#if !os(macOS) && !os(watchOS)
import UIKit

public extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.nibName)
    }
    
    func registerNibWithBundle<T: UICollectionViewCell>(_ type: T.Type) {
        register(T.nibWithBundle, forCellWithReuseIdentifier: T.nibName)
    }
    
	func dequeueReusableCell<T: UICollectionViewCell>(_ cellType: T.Type = T.self, for indexPath: IndexPath) -> T? {
		return self.dequeueReusableCell(withReuseIdentifier: T.nibName, for: indexPath) as? T
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionViewCell>(kind: String, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind,
                                                          withReuseIdentifier: T.nibName,
                                                          for: indexPath) as? T else {
                                                            fatalError("\(T.nibName) could not be dequeued for \(indexPath) of kind \(kind) as \(T.self)")
        }
        return cell
    }
}
#endif
