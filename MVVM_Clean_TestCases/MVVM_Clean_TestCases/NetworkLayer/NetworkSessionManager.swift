import Foundation

protocol NetworkSessionManager {
    func getDataTask(urlReq: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void) throws
}

public class NetworkSessionManagerImplementation: NetworkSessionManager {
    public init() {}
    public func getDataTask(urlReq: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: urlReq, completionHandler: completion)
        task.resume()
    }
}
