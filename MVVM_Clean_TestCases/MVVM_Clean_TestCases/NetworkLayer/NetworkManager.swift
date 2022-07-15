import Foundation

public protocol NetworkManager {
    func getAPIResponse<T: Decodable>(for apiConfig: APIRequestConfiguration, returnType: T.Type, completoin: @escaping(Result<T?, NetworkError>) -> Void)
}

public final class NetworkManagerImplementation: NetworkManager {
    private let service: NetworkService
    private let logger: NetworkLogger
    
    init(service: NetworkService, logger: NetworkLogger = NetworkLoggerImplementation()) {
        self.service = service
        self.logger = logger
    }
    
    public func getAPIResponse<T: Decodable>(for apiConfig: APIRequestConfiguration, returnType: T.Type, completoin: @escaping(Result<T?, NetworkError>) -> Void) {
        self.service.executeAPI(apiConfig: apiConfig) { result in
            switch result {
            case .success(let data):
                do {
                    let parsingResult: T = try self.decode(data)
                    completoin(.success(parsingResult))
                } catch(let error) {
                    completoin(.failure(error as! NetworkError))
                }
            case .failure(let error) :
                completoin(.failure(error as! NetworkError))
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



