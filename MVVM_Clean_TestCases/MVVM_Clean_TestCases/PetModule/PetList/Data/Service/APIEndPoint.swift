import Foundation

struct APIEndPoints {

    static func getPetList() -> APIRequestConfiguration {
        let config = APIRequestConfigImplementation(url: APIVersioning<APIv1>().endpointFor(service: .getPetList), methodType: .get)
        return config
    }
}
