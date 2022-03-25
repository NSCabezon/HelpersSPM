import Foundation

public extension Encodable {
	var asJSON: JSON? {
		guard let data = try? JSONEncoder().encode(self) else { return nil }
		return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
	}
	
	var asJSONString: String? {
		let encodedData = try? JSONEncoder().encode(self)
		if let data = encodedData,
			let objString = String(data: data, encoding: String.Encoding.utf8) {
			return objString
		} else {
			assert(false, "something went wrong 😅")
			return ""
		}
	}
}
