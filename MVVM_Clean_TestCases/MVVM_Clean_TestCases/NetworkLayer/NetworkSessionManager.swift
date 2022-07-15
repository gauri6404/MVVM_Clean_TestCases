import Foundation

protocol NetworkSessionManager {
    @discardableResult
    func getDataTask(urlReq: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void) throws -> URLSessionDataTask
}

public class NetworkSessionManagerImplementation: NetworkSessionManager {
    public init() {}
    public func getDataTask(urlReq: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: urlReq, completionHandler: completion)
        task.resume()
        return task
    }
}
