import Foundation

struct APIEndpoints {
    
    static func getPetList(with reqModel: PetRequestModel) -> APIRequestConfiguration {

        let config = APIRequestConfigImplementation(url: APIVersioning<APIv1>().endpointFor(service: .getPetList), methodType: .get, headers: [:], queryParameters: reqModel.dictionary.mapIntoString, bodyParameters: [:], bodyEncoding: .jsonSerializationData)
        return config
    }
}
