import XCTest
@testable import MVVM_Clean_TestCases

class TestStoryboardable: XCTestCase {
    
    func testPetListVCInstantiation() {
        // When
        let petListVC = PetListViewController.instantiate()
        
        // Then
        XCTAssertNotNil(petListVC)
    }
    
    func testPetDetailVCInstantiation() {
        // When
        let petDetailVC = PetDetailViewController.instantiate()
        
        // Then
        XCTAssertNotNil(petDetailVC)
    }
}
