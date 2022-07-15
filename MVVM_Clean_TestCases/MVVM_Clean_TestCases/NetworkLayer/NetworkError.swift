import Foundation

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case apiResponseError
    case urlGeneration
    case invalidURL
    case parsingError
}
