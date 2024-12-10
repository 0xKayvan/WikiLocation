//
//  WikiLocationUITests.swift
//  WikiLocationUITests
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import XCTest

final class WikiLocationUITests: UITestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testBaseTabView() throws {
        let locationsTab = app.tabBars.buttons["Locations"]
        XCTAssertTrue(locationsTab.exists, "The Locations tab should exist.")
        
        let settingsTab = app.tabBars.buttons["Settings"]
        XCTAssertTrue(settingsTab.exists, "The Settings tab should exist.")
    }
    
    @MainActor
    func testBaseTabViewFunctionality() throws {
        let locationsTab = selectLocationsTab()
        XCTAssertTrue(locationsTab.isSelected, "The Locations tab should be selected.")
        
        let settingsTab = selectSettingsTab()
        XCTAssertTrue(settingsTab.isSelected, "The Settings tab should be selected.")
    }

}
