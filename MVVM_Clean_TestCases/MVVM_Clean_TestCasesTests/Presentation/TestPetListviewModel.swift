import XCTest

class MockPetListUseCase: PetListUseCase {
    var expectation: XCTestExpectation?
    var error: Error?
    var petlist: [PetListResponseModel] = []
    
    func execute(requestValue: PetListUseCaseRequestValue, completion: @escaping (Result<[PetListResponseModel]?, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success([PetListResponseModel()]))
        }
        expectation?.fulfill()
    }
}

class TestPetListViewModel: XCTestCase {
    
    var useCase: MockPetListUseCase!

    override func setUp() {
        super.setUp()
        useCase = MockPetListUseCase()
    }
    
    override func tearDown() {
        useCase = nil
        super.tearDown()
    }
    
    
    func testViewModelItemCountIfUseCaseReturnSuccess() {
        // Given
        useCase.expectation = self.expectation(description: "contains only 10 items")
        useCase.petlist = [PetListResponseModel()]
        
        // When
        let viewModel = PetListViewModelImplementation(petListUseCase: useCase)
        viewModel.getPetList()
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.items.value.count, useCase.petlist.count)
    }
    
    func testViewModelReturnErrorIfUseCaseReturnError() {
        // Given
        useCase.expectation = self.expectation(description: "contain errors")
        useCase.error = NetworkError.apiResponseError
        
        // When
        let viewModel = PetListViewModelImplementation(petListUseCase: useCase)
        viewModel.getPetList()
        
        // Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
}
