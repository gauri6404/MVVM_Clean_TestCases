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
        } catch {}
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc private func networkStatusChanged(_ notification: Notification) {
        let str = (notification.object as! Reachability).connection.description
        if str == "No Connection" {
            DispatchQueue.main.async {
                print("Network not connected")
            }
        } else {
            DispatchQueue.main.async {
                print("Network connected")
            }
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
