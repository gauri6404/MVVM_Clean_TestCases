import Foundation

protocol APIEndPoint {
    /// This property denotes the api's endpoint
     var endpoint: String { get }
}


/**
This enumeration denotes the **API Version-2**
*/
enum APIv1: APIEndPoint {

    /// cases for version-1 related APIs
    case getPetList

    /// This property return the version-2 api's endpont
    var endpoint: String {
        switch self {
        case .getPetList:
            return "v1/breeds"
        }
    }
}


/**
This class denotes the API versioning
*/
class APIVersioning <T: APIEndPoint> {
    /**
     This method use to fetch api endpoint
     - parameter service: T {Generic} - version specific service
     - returns: String - API endpoint
     */
    func endpointFor(service: T) -> String {
        return service.endpoint
    }
}
