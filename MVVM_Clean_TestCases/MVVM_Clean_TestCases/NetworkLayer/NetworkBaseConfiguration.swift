import Foundation

public protocol NetworkBaseConfiguration {
    var baseURL: String { get }
    var headers: [String: String] { get }
}

public struct NetworkBaseConfigurationImpl: NetworkBaseConfiguration {
    public let baseURL: String
    public let headers: [String: String]
    
     public init(baseURL: String, headers: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
    }
}
