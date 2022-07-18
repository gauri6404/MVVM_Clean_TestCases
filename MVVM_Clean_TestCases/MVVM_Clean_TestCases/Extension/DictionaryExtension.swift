import Foundation

extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
    
    var mapIntoString: [String: String] {
        let result = self.reduce([String: String]()) { (partialResult, dict) -> [String: String] in
            var result = partialResult
            result["\(dict.key)"] = "\(dict.value)"
            return result
        }
        return result
    }
}
