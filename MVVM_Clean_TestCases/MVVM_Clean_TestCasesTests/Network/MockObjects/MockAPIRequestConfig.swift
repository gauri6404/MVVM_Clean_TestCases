import Foundation

struct MockBaseNetworkConfig: NetworkBaseConfiguration {
    var baseURL: String = "https://mock.com"
    var headers: [String : String] = [:]
}
