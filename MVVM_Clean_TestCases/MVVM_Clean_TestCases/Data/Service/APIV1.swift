import Foundation

protocol APIEndPoint {
     var endpoint: String { get }
}

enum APIv1: APIEndPoint {

    case getPetList

    var endpoint: String {
        switch self {
        case .getPetList:
            return "v1/breeds/"
        }
    }
}

class APIVersioning <T: APIEndPoint> {
    func endpointFor(service: T) -> String {
        return service.endpoint
    }
}
