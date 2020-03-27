import Foundation

public typealias JSON = [String: Any]

class Mock {
	public static func loadJSON<T: Decodable>(_ filename: String, as type: T.Type = T.self, inBundle bundle: Bundle = Bundle.main) -> T {
		let data: Data
		
		guard let filePath = bundle.path(forResource: filename, ofType: "json") else {
			fatalError("Couldn’t find \(filename) in main bundle.")
		}
		
		let fileURL = URL(fileURLWithPath: filePath)
		do {
			data = try Data(contentsOf: fileURL)
		} catch {
			fatalError("Couldn’t load \(filename) from main bundle:\n\(error)")
		}
		
		do {
			let decoder = JSONDecoder()
			return try decoder.decode(T.self, from: data)
		} catch {
			fatalError("Couldn’t parse \(filename) as \(T.self):\n\(error)")
		}
	}
}

public extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    func toJSONString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []),
            let json = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) else {
                return nil
        }
        return json as String
    }
}
