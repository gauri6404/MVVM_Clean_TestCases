import Foundation


public protocol NetworkService {
    func executeAPI(apiConfig: APIRequestConfiguration, completion: @escaping(Result<Data?, Error>) -> Void)
}

public final class NetworkServiceImplementation: NetworkService {
    private let apiConfig: NetworkBaseConfiguration
    private let sessionManager: NetworkSessionManager
    private let logger: NetworkLogger
    private let reachability: ReachabilityManager
    
    init(apiConfig: NetworkBaseConfiguration, sessionManager: NetworkSessionManager = NetworkSessionManagerImplementation(), logger: NetworkLogger = NetworkLoggerImplementation(), reachability: ReachabilityManager = ReachabilityManagerImpl()) {
        self.sessionManager = sessionManager
        self.logger = logger
        self.apiConfig = apiConfig
        self.reachability = reachability
    }
    
    private func request(request: URLRequest, completion: @escaping(Result<Data?, Error>) -> Void) {
        self.reachability.isReachable { status in
            guard status else {
                let error: NetworkError = NetworkError.notConnected
                completion(.failure(error))
                return
            }
            do {
                try self.sessionManager.getDataTask(urlReq: request) { data, response, error in
                    if let _ = error {
                        var error: NetworkError = .apiResponseError
                        if let response = response as? HTTPURLResponse {
                            error = .error(statusCode: response.statusCode, data: data)
                        }
                        self.logger.log(type: .errorType(error: error))
                        completion(.failure(error))
                    } else if let data = data {
                        if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
                            let error = NetworkError.error(statusCode: statusCode, data: data)
                            self.logger.log(type: .errorType(error: error))
                            completion(.failure(error))
                        } else {
                            self.logger.log(type: .responseType(response: response, data: data))
                            completion(.success(data))
                        }
                    } else {
                        completion(.failure(NetworkError.noDataError))
                    }
                }
            }
            catch(let error) {
                completion(.failure(error))
            }
        }
    }
    
    public func executeAPI(apiConfig: APIRequestConfiguration, completion: @escaping(Result<Data?, Error>) -> Void) {
        do {
            let urlRequest = try apiConfig.getUrlRequest(with: self.apiConfig)
            self.request(request: urlRequest, completion: completion)
        } catch(let error) {
            completion(.failure(error))
        }
    }
}



