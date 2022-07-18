import Foundation

public enum NetworkError: Error, Equatable {
    case notConnected
    case urlComponentGenerationError
    case urlGenerationError
    case error(statusCode: Int, data: Data?)
    case apiResponseError
    case parsingError
    case noDataError
}

struct APIError: Decodable {
    var status_code: Int?
    var status_message: String?
    var success: Bool?
}
