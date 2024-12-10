//
//  UITestBaseClass.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 10/12/2024.
//

import XCTest

class UITestCase: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        var environment = ProcessInfo.processInfo.environment
        environment["USE_MOCKS"] = "true"
        environment["REMOTE_FETCHING_ENABLED"] = "true"
        environment["UI_TESTING"] = "true"

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
