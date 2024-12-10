//
//  WikiLocationUITests.swift
//  WikiLocationUITests
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import XCTest

class UITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        var environment = ProcessInfo.processInfo.environment
        environment["USE_MOCKS"] = "true"
        environment["REMOTE_FETCHING_ENABLED"] = "true"
        
        continueAfterFailure = false
        app.launchEnvironment = environment
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Helper functions
    func selectLocationsTab() -> XCUIElement {
        let tab = app.tabBars.buttons["Locations"]
        tab.tap()
        return tab
    }
    
    func selectSettingsTab() -> XCUIElement {
        let tab = app.tabBars.buttons["Settings"]
        tab.tap()
        return tab
    }
}

final class WikiLocationUITests: UITests {
    
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
        XCTAssertTrue(app.staticTexts["Settings Tab"].exists, "There should be a text equal to 'Settings Tab'.")
    }
    


    

}
