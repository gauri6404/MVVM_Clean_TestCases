import XCTest

class NetworkErrorLoggerMock: NetworkLogger {
    func log(type: LoggerType) {
        switch type {
        case .requestType(let req):
            print(req)
        case .responseType(let response, let data):
            print(response as Any)
            print(data as Any)
        case .errorType(let error):
            print(error)
        }
    }
}


class TestNetworkService: XCTestCase {
    
    var config: MockBaseNetworkConfig!
    
    override func setUp() {
        super.setUp()
        config = MockBaseNetworkConfig()
    }
    
    override func tearDown() {
        config = nil
        super.tearDown()
    }
    
    func testMockDataPassed() {
        // Given
        let expectation = self.expectation(description: "Should return correct data")
        let expectedResponse = "Response data"
        let expectedResponseData = expectedResponse.data(using: .utf8)!
        
        let sut = NetworkServiceImplementation(apiConfig: config, sessionManager: MockNetworkSessionManager(response: nil, data: expectedResponseData, error: nil), logger: NetworkErrorLoggerMock())
        
        // When
        sut.executeAPI(apiConfig: MockAPIRequestConfiguration()) { result in
            guard let responseData = try? result.get(), let responseStr = String(data: responseData, encoding: String.Encoding.utf8) else {
                XCTFail("Should return proper response")
                return
            }
            XCTAssertEqual(responseStr, expectedResponse)
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    
    func testURLComponentGenerationError() {
        // Given
        let expectation = self.expectation(description: "Should return url component generation error")
        let expectedResponse = "Response data"
        let expectedResponseData = expectedResponse.data(using: .utf8)!
        
        let sut = NetworkServiceImplementation(apiConfig: config, sessionManager: MockNetworkSessionManager(response: nil, data: expectedResponseData, error: nil), logger: NetworkErrorLoggerMock())
        
        // When
        sut.executeAPI(apiConfig: MockAPIRequestConfiguration(url: "-;@,?:ą", methodType: .get, queryParameters: [:], bodyParameters: [:], bodyEncoding: .jsonSerializationData)) { result in
            do {
                _ = try result.get()
                XCTFail("Should throw url component generation error")
                return
            } catch let error {
                guard case NetworkError.urlComponentGenerationError = error else {
                    XCTFail("Should throw url component generation error")
                    return
                }
                expectation.fulfill()
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testAPIResponseError() {
        // Given
        let expectation = self.expectation(description: "Should return api response error")
        
        let response = HTTPURLResponse(url: URL(string: "test_url")!, statusCode: 500, httpVersion: "1.1", headerFields: [:])
        
        let sut = NetworkServiceImplementation(apiConfig: config, sessionManager: MockNetworkSessionManager(response: response, data: nil, error: nil), logger: NetworkErrorLoggerMock())
        
        //when
        sut.executeAPI(apiConfig: MockAPIRequestConfiguration()) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                guard case NetworkError.noDataError = error else {
                    XCTFail("Should return api response error")
                    return
                }
                expectation.fulfill()
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testInvalidStatusCodeError() {
        // Given
        let expectation = self.expectation(description: "Should return status code error")
        let response = HTTPURLResponse(url: URL(string: "test_url")!, statusCode: 301, httpVersion: "1.1", headerFields: [:])
        let responseData = "Response data".data(using: .utf8)!
        
        let sut = NetworkServiceImplementation(apiConfig: config, sessionManager: MockNetworkSessionManager(response: response, data: responseData, error: nil), logger: NetworkErrorLoggerMock())
        
        //when
        sut.executeAPI(apiConfig: MockAPIRequestConfiguration()) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case NetworkError.error(let statusCode, _) = error {
                    XCTAssertEqual(statusCode, 301)
                    expectation.fulfill()
                }
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 0.1)
    }
}
