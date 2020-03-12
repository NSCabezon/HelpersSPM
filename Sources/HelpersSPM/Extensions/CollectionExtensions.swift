import Foundation

public extension Collection {
    var isNotEmpty: Bool {
        return !isEmpty
    }
	
	func indices(where isIncluded: (Element) throws -> Bool) rethrows -> [Index] {
		try indices.filter {
			try isIncluded(self[$0])
		}
	}
}

public extension Collection where Element: Equatable {
	func indices(of element: Element) -> [Index] { indices.filter { self[$0] == element } }
}
