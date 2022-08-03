import Foundation

struct MockAPIRequestConfiguration: APIRequestConfiguration {
    var url: String = ""
    var methodType: HTTPMethodType = .get
    var queryParameters: [String : String]? = nil
    var bodyParameters: [String : String]? = [:]
    var bodyEncoding: BodyEncoding? = .jsonSerializationData
}
