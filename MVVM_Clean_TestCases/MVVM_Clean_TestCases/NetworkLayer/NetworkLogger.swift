import Foundation

public enum LoggerType {
    case requestType(req: URLRequest)
    case responseType(response: URLResponse?, data: Data?)
    case errorType(error: Error)
}

public protocol NetworkLogger {
    func log(type: LoggerType)
}

public final class NetworkLoggerImplementation: NetworkLogger {
    public init() { }
    
    public func log(type: LoggerType) {
        switch type {
        case .requestType(let req):
            self.log(request: req)
        case .responseType(let response, let data):
            self.log(response: response, data: data)
        case .errorType(let error):
            self.log(error: error)
        }
    }

    private func log(request: URLRequest) {
        ("request: \(request.url!)").printIfDebug()
        ("headers: \(request.allHTTPHeaderFields!)").printIfDebug()
        ("method: \(request.httpMethod!)").printIfDebug()
        if let httpBody = request.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            "body: \(String(describing: result))".printIfDebug()
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            "body: \(String(describing: resultString))".printIfDebug()
        }
    }

    private func log(response: URLResponse?, data: Data?) {
        guard let data = data else { return }
        if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            ("responseData: \(String(describing: dataDict))").printIfDebug()
        }
    }

    private func log(error: Error) {
        ("\(error)").printIfDebug()
    }
}
