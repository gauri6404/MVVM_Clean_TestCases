import XCTest

private struct MockModel: Decodable {
    let name: String
}

class TestNetworkManager: XCTestCase {
    
    var config: MockBaseNetworkConfig!
    
    override func setUp() {
        super.setUp()
        config = MockBaseNetworkConfig()
    }
    
    override func tearDown() {
        config = nil
        super.tearDown()
    }
    
    func testResponseDecodingSuccess() {
        // Given
        let expectation = self.expectation(description: "Should decode mock object")
        let responseData = #"{"name": "Hello"}"#.data(using: .utf8)
        
        let networkService = NetworkServiceImplementation(apiConfig: config, sessionManager: MockNetworkSessionManager(response: nil, data: responseData, error: nil), logger: NetworkErrorLoggerMock(), reachability: MockReachabilityManager())
        let sut = NetworkManagerImplementation(service: networkService)
        
        // When
        sut.getAPIResponse(for: MockAPIRequestConfiguration(), returnType: MockModel.self) { result in
            do {
                let object = try result.get()
                XCTAssertEqual(object?.name, "Hello")
                expectation.fulfill()
            } catch {
                XCTFail("Failed decoding MockObject")
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testResponseDecodingFailure() {
        // Given
        let expectation = self.expectation(description: "Should decode mock object")
        let responseData = #"{"address": "Delhi"}"#.data(using: .utf8)
        
        let networkService = NetworkServiceImplementation(apiConfig: config, sessionManager: MockNetworkSessionManager(response: nil, data: responseData, error: nil), logger: NetworkErrorLoggerMock(), reachability: MockReachabilityManager())
        let sut = NetworkManagerImplementation(service: networkService)
        
        // When
        sut.getAPIResponse(for: MockAPIRequestConfiguration(), returnType: MockModel.self) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch {
                expectation.fulfill()
            }
        }
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testWhenBadRequestReceivedShouldRethrowError() {
        // Given
        let expectation = self.expectation(description: "Should throw status error")
        let responseData = #"{"invalidStructure": "Nothing"}"#.data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: "test_url")!, statusCode: 500, httpVersion: "1.1", headerFields: nil)
        
        let networkService = NetworkServiceImplementation(apiConfig: config, sessionManager: MockNetworkSessionManager(response: response, data: responseData, error: nil), logger: NetworkErrorLoggerMock(), reachability: MockReachabilityManager())
        let sut = NetworkManagerImplementation(service: networkService)
        
        // When
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
        
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testEmptyDataAPIResponse() {
        // Given
        let expectation = self.expectation(description: "Should throw no data error")
        let response = HTTPURLResponse(url: URL(string: "test_url")!, statusCode: 200, httpVersion: "1.1", headerFields: [:])
        
        let networkService = NetworkServiceImplementation(apiConfig: config, sessionManager: MockNetworkSessionManager(response: response, data: nil, error: nil), logger: NetworkErrorLoggerMock(), reachability: MockReachabilityManager())
        let sut = NetworkManagerImplementation(service: networkService)
        
        // When
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
        
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
}
