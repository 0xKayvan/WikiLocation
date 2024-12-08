//
//  WikiLocationUITests.swift
//  WikiLocationUITests
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import XCTest

final class WikiLocationUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
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
        XCTAssertTrue(app.staticTexts["Settings Tab"].exists, "There should be a text equal to 'Settings Tab'.")
    }
    
    @MainActor
    func testLocationsView() throws {
        _ = selectLocationsTab()
        
        let navigationBar = app.navigationBars.firstMatch
        XCTAssertTrue(navigationBar.exists, "The Locations view should be visible.")
        XCTAssertTrue(navigationBar.staticTexts["Locations"].exists, "The Locations view should have a title 'Locations'.")
    }

    
    // MARK: - Helper functions
    private func selectLocationsTab() -> XCUIElement {
        let tab = app.tabBars.buttons["Locations"]
        tab.tap()
        return tab
    }
    
    private func selectSettingsTab() -> XCUIElement {
        let tab = app.tabBars.buttons["Settings"]
        tab.tap()
        return tab
    }
}
