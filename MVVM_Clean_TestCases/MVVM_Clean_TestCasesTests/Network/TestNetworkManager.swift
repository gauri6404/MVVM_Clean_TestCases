import XCTest

private struct MockModel: Decodable {
    let name: String
}

private enum DataTransferErrorMock: Error {
    case someError
}

class TestNetworkManager: XCTestCase {
    
    func test_ResponseDecodingSuccess() {
        do {
            try XCTSkipUnless(ReachabilityManager.sharedInstance.reachability.connection != .unavailable, "Network is not connected")
            //given
            let config = MockBaseNetworkConfig()
            let expectation = self.expectation(description: "Should decode mock object")
            
            let responseData = #"{"name": "Hello"}"#.data(using: .utf8)
            let networkService = NetworkServiceImplementation(apiConfig: config, sessionManager: MockNetworkSessionManager(response: nil, data: responseData, error: nil), logger: NetworkLoggerImplementation())
            
            let sut = NetworkManagerImplementation(service: networkService)
            //when
            
            sut.getAPIResponse(for: MockAPIRequestConfiguration(), returnType: MockModel.self) { result in
                do {
                    let object = try result.get()
                    XCTAssertEqual(object?.name, "Hello")
                    expectation.fulfill()
                } catch {
                    XCTFail("Failed decoding MockObject")
                }
            }
            //then
            wait(for: [expectation], timeout: 0.1)
        } catch {}
    }
    
    func test_ResponseDecodingFailure() {
        //given
        let config = MockBaseNetworkConfig()
        let expectation = self.expectation(description: "Should decode mock object")
        
        let responseData = #"{"address": "Delhi"}"#.data(using: .utf8)
        let networkService = NetworkServiceImplementation(apiConfig: config, sessionManager: MockNetworkSessionManager(response: nil, data: responseData, error: nil), logger: NetworkLoggerImplementation())
        
        let sut = NetworkManagerImplementation(service: networkService)
        //when
        sut.getAPIResponse(for: MockAPIRequestConfiguration(), returnType: MockModel.self) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch {
                expectation.fulfill()
            }
        }
        //then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_whenBadRequestReceived_shouldRethrowNetworkError() {
        do {
            try XCTSkipUnless(ReachabilityManager.sharedInstance.reachability.connection != .unavailable, "Network is not connected")
            //given
            let config = MockBaseNetworkConfig()
            let expectation = self.expectation(description: "Should decode mock object")
            let responseData = #"{"invalidStructure": "Nothing"}"#.data(using: .utf8)!
            let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                           statusCode: 500,
                                           httpVersion: "1.1",
                                           headerFields: nil)
            let networkService = NetworkServiceImplementation(apiConfig: config, sessionManager: MockNetworkSessionManager(response: response, data: responseData, error: nil), logger: NetworkLoggerImplementation())

            let sut = NetworkManagerImplementation(service: networkService)
            //when
            sut.getAPIResponse(for: MockAPIRequestConfiguration(), returnType: MockModel.self) { result in
                do {
                    _ = try result.get()
                    XCTFail("Should not happen")
                } catch let error {

                    if case NetworkError.error(statusCode: 500, _) = error {
                        expectation.fulfill()
                    } else {
                        XCTFail("Wrong error")
                    }
                }
            }
            //then
            wait(for: [expectation], timeout: 0.1)
        } catch {}
    }
    
    func test_EmptyDataAPIResponse() {
        do {
            try XCTSkipUnless(ReachabilityManager.sharedInstance.reachability.connection != .unavailable, "Network is not connected")
            //given
            let config = MockBaseNetworkConfig()
            let expectation = self.expectation(description: "Should throw no data error")
            
            let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                           statusCode: 200,
                                           httpVersion: "1.1",
                                           headerFields: [:])
            let networkService = NetworkServiceImplementation(apiConfig: config, sessionManager: MockNetworkSessionManager(response: response, data: nil, error: nil), logger: NetworkLoggerImplementation())
            
            let sut = NetworkManagerImplementation(service: networkService)
            //when
            sut.getAPIResponse(for: MockAPIRequestConfiguration(), returnType: MockModel.self) { result in
                do {
                    _ = try result.get()
                    XCTFail("Should not happen")
                } catch let error {
                    if case NetworkError.noDataError = error {
                        expectation.fulfill()
                    } else {
                        XCTFail("Wrong error")
                    }
                }
            }
            //then
            wait(for: [expectation], timeout: 0.1)
        } catch {}
    }
}
