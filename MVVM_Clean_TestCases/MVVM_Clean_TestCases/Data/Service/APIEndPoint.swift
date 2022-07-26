import Foundation

struct APIEndpoints {
    
    static func getPetList(with reqModel: PetListRequestDTO) -> APIRequestConfiguration {

        let config = APIRequestConfigImplementation(url: APIVersioning<APIv1>().endpointFor(service: .getPetList), methodType: .get, queryParameters: reqModel.dictionary.mapIntoString, bodyParameters: [:], bodyEncoding: .jsonSerializationData)
        return config
    }
}
