import Foundation

public enum HTTPMethodType: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public enum BodyEncoding {
    case jsonSerializationData
    case stringEncodingAscii
}

public protocol APIRequestConfiguration {
    var url: String { get }
    var methodType: HTTPMethodType { get }
    var queryParameters: [String: String]? { get }
    var bodyParameters: [String: String] { get }
    var bodyEncoding: BodyEncoding { get }
    
    func getUrlRequest(with baseConfig: NetworkBaseConfiguration) throws -> URLRequest
}

public struct APIRequestConfigImplementation: APIRequestConfiguration {
    
    public let url: String
    public let methodType: HTTPMethodType
    public let queryParameters: [String: String]?
    public let bodyParameters: [String: String]
    public let bodyEncoding: BodyEncoding
    
    public init(url: String, methodType: HTTPMethodType, queryParameters: [String: String]? = nil, bodyParameters: [String: String] = [:], bodyEncoding: BodyEncoding = .jsonSerializationData) {
        self.url = url
        self.methodType = methodType
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.bodyEncoding = bodyEncoding
    }
}

extension APIRequestConfiguration {
    public func getUrlRequest(with config: NetworkBaseConfiguration) throws -> URLRequest {
        do {
            guard var urlComponents = URLComponents(string: config.baseURL + url) else { throw NetworkError.urlComponentGenerationError }
            urlComponents.queryItems = queryParameters?.map({ (key, value) in
                let queryItem = URLQueryItem(name: key, value: value)
                return queryItem
            })
            guard let url = urlComponents.url else { throw NetworkError.urlGenerationError }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = methodType.rawValue
            urlRequest.allHTTPHeaderFields = config.headers
            if !bodyParameters.isEmpty {
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
            }
            return urlRequest
        } catch(let error) {
            throw error
        }
    }
}
