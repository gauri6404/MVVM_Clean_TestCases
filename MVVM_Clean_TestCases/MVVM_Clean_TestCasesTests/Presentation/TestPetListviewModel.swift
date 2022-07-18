import XCTest

class MockPetListUseCase1: PetListUseCase {
    var expectation: XCTestExpectation?
    var error: Error?
    var petlist = mockPetList
    
    func execute(requestValue: PetListUseCaseRequestValue, completion: @escaping (Result<[PetListResponseModel]?, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(petlist))
        }
        expectation?.fulfill()
    }
}

class TestPetListViewModel: XCTestCase {
    
    func testViewModelItemCountIsTenOnFirstcall() {
        // given
        let mockPetListUseCase = MockPetListUseCase1()
        mockPetListUseCase.expectation = self.expectation(description: "contains only 10 items")
        for _ in 1...264 {
            mockPetListUseCase.petlist.append(PetListResponseModel())
        }
        mockPetListUseCase.petlist = mockPetList
        let viewModel = PetListViewModelImplementation(petListUseCase: mockPetListUseCase)
        // when
        viewModel.getPetList()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertEqual(viewModel.items.value.count, 10)
        XCTAssertTrue(viewModel.hasMorePages)
    }
    
    func testViewModelItemCountIsTwentyOnSecondcall() {
        // given
        let mockPetListUseCase = MockPetListUseCase1()
        mockPetListUseCase.expectation = self.expectation(description: "contains only 10 items")
        for _ in 1...264 {
            mockPetListUseCase.petlist.append(PetListResponseModel())
        }
        mockPetListUseCase.petlist = mockPetList
        let viewModel = PetListViewModelImplementation(petListUseCase: mockPetListUseCase)
        // when
        viewModel.getPetList()
        waitForExpectations(timeout: 5, handler: nil)
        
        mockPetListUseCase.expectation = self.expectation(description: "contains only 20 items")
        viewModel.didLoadNextPage()
        
        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.currentPage, 2)
        XCTAssertEqual(viewModel.items.value.count, 20)
        XCTAssertTrue(viewModel.hasMorePages)
    }
    
    func testViewmodelReturnErrorIfUseCaseReturnError() {
        // given
        let mockPetListUseCase = MockPetListUseCase1()
        mockPetListUseCase.expectation = self.expectation(description: "contain errors")
        mockPetListUseCase.error = NetworkError.apiResponseError
        let viewModel = PetListViewModelImplementation(petListUseCase: mockPetListUseCase)
        // when
        viewModel.getPetList()

        // then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(viewModel.error)
    }
}
