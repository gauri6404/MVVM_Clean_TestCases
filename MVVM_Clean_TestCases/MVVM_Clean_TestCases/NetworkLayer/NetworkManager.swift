import Foundation

public protocol NetworkManager {
    func executeAPI<T: Codable>(returningClass: T.Type, completoin: @escaping(Result<T, Error>) -> Void)
}

public final class NetworkManagerimplementation: NetworkManager {
    private let sessionManager: URLSession
    private let logger: NetworkLogger
    private let request: APIRequestConfiguration
    
    public init(sessionManager: URLSession = .shared, logger: NetworkLogger = NetworkLoggerImplementation(), request: APIRequestConfiguration) {
        self.sessionManager = sessionManager
        self.logger = logger
        self.request = request
    }
    
    public func executeAPI<T>(returningClass: T.Type, completoin: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        let dataTask = DataTaskManagerImplementation(sessionManager: sessionManager, logger: logger)
        dataTask.getSessionDataTask(config: request) { result in
            switch result {
            case .success(let data):
                do {
                    let parsingResult: T = try self.decode(data)
                    completoin(.success(parsingResult))
                } catch(let error) {
                    completoin(.failure(error))
                }
            case .failure(let error) :
                completoin(.failure(error))
            }
        }
    }
    
    private func decode<T: Decodable>(_ data: Data?) throws -> T {
        guard let data = data else {
            throw NetworkError.parsingError
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.parsingError
        }
    }
}
