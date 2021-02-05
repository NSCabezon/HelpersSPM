import Foundation

public extension URL {
    var queryDictionary: [String: String]? {
        guard let query = self.query else { return nil}

        var queryStrings = [String: String]()
        for pair in query.components(separatedBy: "&") {

            let key = pair.components(separatedBy: "=")[0]

            let value = pair
                .components(separatedBy:"=")[1]
                .replacingOccurrences(of: "+", with: " ")
                .removingPercentEncoding ?? ""

            queryStrings[key] = value
        }
        return queryStrings
    }

    func starts(with url: URL) -> Bool {
        return self.absoluteString.starts(with: url.absoluteString)
    }

    func appendingQueryParameters(_ parameters: [String: String]?) -> URL {
        guard let parameters = parameters,
              var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
                return self
        }
        
        var mutableQueryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        mutableQueryItems.append(contentsOf: parameters.map { URLQueryItem(name: $0, value: $1) })
        urlComponents.queryItems = mutableQueryItems
        return urlComponents.url!
    }

    static func fromString(_ string: String) -> URL {
        guard let url = URL(string: string) else {
            fatalError("Cannot build url from string: \"\(string)\"")
        }
        return url
    }
}
