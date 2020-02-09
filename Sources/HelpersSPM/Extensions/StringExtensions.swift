import Foundation

public extension String {
    var base64Encoded: String {
        guard let plainData = data(using: .utf8) else {
            fatalError("could not get data from string")
        }
        let base64String = plainData.base64EncodedString(options: Data.Base64EncodingOptions.endLineWithCarriageReturn)
        return base64String
    }
    
    var base64Decoded: String? {
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        let decodedString = NSString(data: decodedData as Data, encoding: String.Encoding.utf8.rawValue)
        return decodedString as String?
    }
    
    func containsAnyCharacterOfSet(_ set: CharacterSet) -> Bool {
        for character in self {
            for codeUnit in String(character).utf16 {
                if set.contains(UnicodeScalar(codeUnit)!) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func toDateFromJsonFormat() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateObj = dateFormatter.date(from: self)
        
        return dateObj
    }
    
    /// From Json with YYYY-MM-dd it returns date
    func toDateFromJsonFormat_YYYYMMdd() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateObj = dateFormatter.date(from: self)
        
        return dateObj
    }

    func toDateFromSpanishFormat() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateObj = dateFormatter.date(from: self)
        
        return dateObj
    }

    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    var trimed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    func match(inAny occurrences: [String]) -> Bool {
        return occurrences.anyMatch(with: self)
    }
    
    func isValidUrl() -> Bool {
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func match(withPattern pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        let range = NSRange(location: 0, length: count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
    
    func match(forPattern pattern: String, index: Int) -> String? {
        let list = matches(forPattern: pattern)
        if let element = list.element(atIndex: index) {
            return element
        }
        return nil
    }
    
    func matches(forPattern pattern: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return []
        }
        
        let nsString = self as NSString
        let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: nsString.length))
        if let result = results.first {
            return (0..<result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound ? nsString.substring(with: result.range(at: $0)) : ""
            }
        } else {
            return []
        }
    }
    
    var URLEscapedString: String {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
	
	var linkedInPattern: String {
        return "^http[s]?://(linkedin.com|.+\\.linkedin.com)/in/(.*)$"
    }
    
    func isValidLinkedInProfileUrl() -> Bool {
        return match(withPattern: linkedInPattern)
    }
    
    var linkedInUsername: String? {
        return match(forPattern: linkedInPattern, index: 2)
    }
}


public extension Sequence where Iterator.Element == String {
    /**
     Find any occurences of given string in any part of every item. This func is CASE and ACCENT INSENSITIVE
     */
    func anyMatch(with occurrence: String) -> Bool {
        return contains(where: { element in
            return occurrence.range(of: element, options: [.diacriticInsensitive, .caseInsensitive], range: nil, locale: nil) != nil
        })
    }
}
