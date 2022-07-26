import Foundation

struct MockBaseNetworkConfig: NetworkBaseConfiguration {
    var baseURL: String = ""
    var headers: [String : String] = [:]
}
