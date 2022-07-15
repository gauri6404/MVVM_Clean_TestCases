import Foundation


public protocol DataTaskManager {
    @discardableResult
    func getSessionDataTask(config: APIRequestConfiguration, completion: @escaping(Result<Data?, Error>) -> Void) -> URLSessionDataTask?
}

public final class DataTaskManagerImplementation: DataTaskManager {
    
    private let sessionManager: URLSession
    private let logger: NetworkLogger
    
    public init(sessionManager: URLSession = .shared, logger: NetworkLogger = NetworkLoggerImplementation()) {
        self.sessionManager = sessionManager
        self.logger = logger
    }
    
    private func getDataTask(request: URLRequest, completion: @escaping(Result<Data?, Error>) -> Void) -> URLSessionDataTask {
        let task = sessionManager.dataTask(with: request) { data, response, error in
            if let reqError = error {
                self.logger.log(type: .errorType(error: reqError))
                if let nwResponse = response as? HTTPURLResponse {
                    completion(.failure(NetworkError.error(statusCode: nwResponse.statusCode, data: data)))
                } else {
                    completion(.failure(NetworkError.apiResponseError))
                }
            } else {
                self.logger.log(type: .responseType(response: response, data: data))
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }
    
    @discardableResult
    public func getSessionDataTask(config: APIRequestConfiguration, completion: @escaping(Result<Data?, Error>) -> Void) -> URLSessionDataTask? {
        do {
            let urlRequest = try config.getUrlRequest(with: config)
            return getDataTask(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(NetworkError.urlGeneration))
            return nil
        }
    }
}
