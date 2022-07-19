import Foundation

class PListUtility: NSObject {

    class func getValue(forKey: String) -> Any {
        guard let infoDict = Bundle.main.infoDictionary?[forKey] else {
            return ""
        }
        return infoDict
    }
}
