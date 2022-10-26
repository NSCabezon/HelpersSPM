import Foundation

public typealias JSON = [String: Any]

enum MockError: Error {
    case fileNotFound(fileName: String)
}

public class Mock {
	public static func loadJSON<T: Decodable>(_ filename: String, as type: T.Type = T.self, inBundle bundle: Bundle = Bundle.main) throws -> T {
		guard let filePath = bundle.path(forResource: filename, ofType: "json") else {
            throw MockError.fileNotFound(fileName: filename)
		}
        let fileURL = URL(fileURLWithPath: filePath)
        return try loadJSONAtPath(fileURL, as: T.self)
    }
    
    public static func loadJSONAtPath<T: Decodable>(_ filePathURL: URL, as type: T.Type = T.self) throws -> T {
        let data = try Data(contentsOf: filePathURL)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
