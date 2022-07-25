import XCTest

class MockPetListRepository: PetListRepository {
    var petList: [PetListResponseModel] = []
    var error: Error?
    
    func fetchPetList(limit: Int, completion: @escaping (Result<[PetListResponseModel]?, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(petList))
        }
    }
}

class TestPetListUsecase: XCTestCase {
    
    var repository: MockPetListRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockPetListRepository()
    }
    
    override func tearDown() {
        repository = nil
        super.tearDown()
    }
    
    func testUseCaseReturnsSuccessIfRepoReturnSuccess() {
        // Given
        let expectation = self.expectation(description: "Usecase return success block")
        repository.petList = [PetListResponseModel()]
        let usecase = PetListUseCaseImplementation(petListRepository: repository)
        
        // When
        let req = PetListUseCaseRequestValue(limit: 10)
        usecase.execute(requestValue: req) { result in
            do {
                _ = try result.get()
                expectation.fulfill()
            } catch {
                XCTFail("Usecase return success block")
            }
        }
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_usecaseReturnsFailureIfRepoReturnFailure() {
        // Given
        let expectation = self.expectation(description: "Usecase return failure block")
        repository.error = NetworkError.apiResponseError
        let usecase = PetListUseCaseImplementation(petListRepository: repository)
        
        // When
        let reqValue = PetListUseCaseRequestValue(limit: 10)
        usecase.execute(requestValue: reqValue) { result in
            do {
                _ = try result.get()
                XCTFail("Usecase return failure block")
            } catch {
                expectation.fulfill()
            }
        }
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
    }
}

