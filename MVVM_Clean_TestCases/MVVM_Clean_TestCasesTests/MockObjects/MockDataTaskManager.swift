import Foundation

class MockDataTaskManager: DataTaskManager {
    func getSessionDataTask(config: APIRequestConfiguration, completion: @escaping (Result<Data?, Error>) -> Void) -> URLSessionDataTask? {
        return URLSessionDataTask()
    }
}
