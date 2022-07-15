import Foundation

struct MockAPIRequestConfig: APIRequestConfiguration {
    var url: String = "https://mock.com"
    var methodType: HTTPMethodType = .get
    var headers: [String : String] = [:]
    var queryParameters: [String : String]? = nil
    var bodyParameters: [String : String] = [:]
    var bodyEncoding: BodyEncoding = .jsonSerializationData
}
