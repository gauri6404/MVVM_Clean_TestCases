import XCTest

class TestPetListUsecase: XCTestCase {
    
    func test_usecaseReturnsSuccessIfRepoReturnSuccess() {
        let expectation = self.expectation(description: "Usecase return success block")
        let repository = MockPetListRepositorySuccess()
        let usecase = MockPetListUseCase(repository: repository)
        let reqValue = PetListUseCaseRequestValue(currentPageIndex: 0, limit: 10)
        usecase.execute(requestValue: reqValue) { result in
            do {
                _ = try result.get()
                expectation.fulfill()
            } catch {
                XCTFail("Usecase return success block")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_usecaseReturnsFailureIfRepoReturnFailure() {
        // given
        let expectation = self.expectation(description: "Usecase return failure block")
        
        // when
        let repository = MockPetListRepositoryFailure()
        let usecase = MockPetListUseCase(repository: repository)
        let reqValue = PetListUseCaseRequestValue(currentPageIndex: 0, limit: 10)
        
        // then
        usecase.execute(requestValue: reqValue) { result in
            do {
                _ = try result.get()
                XCTFail("Usecase return failure block")
            } catch {
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}


struct MockPetListRepositorySuccess: PetListRepository {
    func fetchPetList(page: Int, limit: Int, completion: @escaping (Result<[PetListResponseModel]?, Error>) -> Void) {
        completion(.success(mockPetList))
    }
}

struct MockPetListRepositoryFailure: PetListRepository {
    func fetchPetList(page: Int, limit: Int, completion: @escaping (Result<[PetListResponseModel]?, Error>) -> Void) {
        completion(.failure(NetworkError.apiResponseError))
    }
}

class MockPetListUseCase: PetListUseCase {
    private var repository: PetListRepository
    
    init(repository: PetListRepository) {
        self.repository = repository
    }
    func execute(requestValue: PetListUseCaseRequestValue, completion: @escaping (Result<[PetListResponseModel]?, Error>) -> Void) {
        return repository.fetchPetList(page: requestValue.currentPageIndex, limit: requestValue.limit) { result in
            completion(result)
        }
    }
}

