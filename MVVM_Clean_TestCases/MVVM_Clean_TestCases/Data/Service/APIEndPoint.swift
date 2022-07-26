import Foundation

struct APIEndpoints {
    
    static func getPetList() -> APIRequestConfiguration {

        let config = APIRequestConfigImplementation(url: APIVersioning<APIv1>().endpointFor(service: .getPetList), methodType: .get, queryParameters: nil, bodyParameters: [:], bodyEncoding: .jsonSerializationData)
        return config
    }
}
