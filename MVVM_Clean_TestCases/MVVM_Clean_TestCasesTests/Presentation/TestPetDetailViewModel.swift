import XCTest

class TestPetDetailViewModel: XCTestCase {
    
    func testViewModel() {
        // Given
        let petInfoModel = PetInfoPresentationModel()
        
        // When
        let viewModel = PetDetailViewModelImplementation(petInfo: petInfoModel)
        
        // Then
        XCTAssertEqual(viewModel.petDetail.petName, petInfoModel.name)
        XCTAssertEqual(viewModel.petDetail.petBreedGroup, petInfoModel.breedGroup)
        XCTAssertEqual(viewModel.petDetail.petBreed, petInfoModel.breed)
        XCTAssertEqual(viewModel.petDetail.petTemperament, petInfoModel.temperament)
        XCTAssertEqual(viewModel.petDetail.petOrigin, petInfoModel.origin)
        XCTAssertEqual(viewModel.petDetail.petLifeSpan, petInfoModel.lifeSpan)
    }
}
