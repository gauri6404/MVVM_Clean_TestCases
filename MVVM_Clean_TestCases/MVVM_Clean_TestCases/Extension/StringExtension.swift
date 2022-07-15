import Foundation

extension String {
    func printIfDebug() {
        #if DEBUG
        print(self)
        #endif
    }
}
