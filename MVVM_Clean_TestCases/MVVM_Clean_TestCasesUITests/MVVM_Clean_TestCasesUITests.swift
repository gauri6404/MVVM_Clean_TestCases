import XCTest

class MVVM_Clean_TestCasesUITests: XCTestCase {

    func testTableExistence() throws {
        let app = XCUIApplication()
        app.launch()
        
        if Reachability.isConnectedToNetwork() {
            if !app.tables[AccessibilityIdentifier.tableView].waitForExistence(timeout: 5) {
                XCTFail("Failed to load table")
            } else {
                XCTAssertTrue(app.tables[AccessibilityIdentifier.tableView].exists)
            }
        } else {
            XCTAssertTrue(app.alerts["Error"].waitForExistence(timeout: 10))
        }
    }
}
