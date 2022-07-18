/**
 This file convert the model to dictionary object
 */
import Foundation

extension Encodable {

    // MARK: - subscripting method
    subscript(key: String) -> Any? {
        return dictionary[key]
    }

    // MARK: - Getter property
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
