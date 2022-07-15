/**
 This class is used to get value for key present in plist
 */

import Foundation

class PListUtility: NSObject {

    // MARK: - Helper methods
    /**
     Get value from plist
     -return: Any type object
     */
    class func getValue(forKey: String) -> Any {
        guard let infoDict = Bundle.main.infoDictionary?[forKey] else {
            return ""
        }
        return infoDict
    }
}
