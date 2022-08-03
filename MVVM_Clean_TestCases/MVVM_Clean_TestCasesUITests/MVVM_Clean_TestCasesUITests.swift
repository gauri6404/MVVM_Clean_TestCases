import XCTest

class MVVM_Clean_TestCasesUITests: XCTestCase {

    func testTableOrErrorExistence() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Test for pet list existance
        let tableExistance = app.tables[PetModuleAccessibilityIdentifier.listTableView].waitForExistence(timeout: 5)
        XCTAssertTrue(tableExistance)
        
        // Test for Pet list table cell existance
        let cellElement = app.tables[PetModuleAccessibilityIdentifier.listTableView].cells.firstMatch
        if cellElement.exists {
            cellElement.tap()
            // Make sure movie details view exist
            XCTAssertTrue(app.otherElements[PetModuleAccessibilityIdentifier.petDetail].waitForExistence(timeout: 5))
        }
        
        // Test for alert existance if list is empty
        if !tableExistance {
            XCTAssertTrue(app.alerts["Error"].waitForExistence(timeout: 10))
        }
    }
}
