#if !os(macOS) && !os(watchOS)
import UIKit

public extension UISegmentedControl {
	func removeLast(animated: Bool = false) {
		let lastIndex = numberOfSegments - 1
		removeSegment(at: lastIndex, animated: animated)
	}
}
#endif
