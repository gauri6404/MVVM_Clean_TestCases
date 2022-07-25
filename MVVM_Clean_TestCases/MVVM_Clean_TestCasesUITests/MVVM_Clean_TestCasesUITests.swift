import XCTest

class MVVM_Clean_TestCasesUITests: XCTestCase {

    func testTableOrErrorExistence() throws {
        let app = XCUIApplication()
        app.launch()
        let tableExistance = app.tables[PetListAccessibilityIdentifier.tableView].waitForExistence(timeout: 5)
        XCTAssertTrue(tableExistance)
        if !tableExistance {
            XCTAssertTrue(app.alerts["Error"].waitForExistence(timeout: 10))
        }
    }
}
