import Foundation

class MockReachabilityManager: NSObject, ReachabilityManager {
    func isReachable(status: @escaping (Bool) -> Void) {
        status(true)
    }
}
