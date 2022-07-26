import Foundation
import Reachability

protocol ReachabilityManager: NSObject {
    func isReachable(status: @escaping(Bool) -> Void)
}

class ReachabilityManagerImpl: NSObject, ReachabilityManager {
    private var reachability: Reachability!
    
    override init() {
        super.init()
        do {
            reachability = try Reachability()
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func stopNotifier() -> Void {
        self.reachability.stopNotifier()
    }
    
    func isReachable(status: @escaping (Bool) -> Void) {
        guard self.reachability.connection != .unavailable else {
            status(false)
            return
        }
        status(true)
    }
}
