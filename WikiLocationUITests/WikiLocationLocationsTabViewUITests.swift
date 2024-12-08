//
//  WikiLocationLocationsTabViewUITests.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import XCTest

final class WikiLocationLocationsTabViewUITests: UITests {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func testLocationsView() throws {
        _ = selectLocationsTab()
        
        let navigationBar = app.navigationBars.firstMatch
        XCTAssertTrue(navigationBar.exists, "The Locations view should be visible.")
        XCTAssertTrue(navigationBar.staticTexts["Locations"].exists, "The Locations view should have a title 'Locations'.")
    }
    
}
