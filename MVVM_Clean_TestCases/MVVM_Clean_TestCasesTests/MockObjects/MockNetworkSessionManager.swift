import Foundation

struct MockNetworkSessionManager: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    func getDataTask(urlReq: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) throws -> URLSessionDataTask {
        completion(data, response, error)
        return URLSessionDataTask().response
    }
}
