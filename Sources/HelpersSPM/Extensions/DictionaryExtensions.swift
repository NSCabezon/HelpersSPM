import Foundation

public extension Dictionary {
    mutating func update(other: Dictionary) {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
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
