//
//  SettingsTabViewUITests.swift
//  WikiLocationUITests
//
//  Created by Kayvan Nouri on 10/12/2024.
//

import XCTest

final class SettingsTabViewUITests: UITestCase {

    func testSettingsView() throws {
        _ = selectSettingsTab()
        
        let navigationBar = app.navigationBars.firstMatch
        XCTAssertTrue(navigationBar.exists, "The Settings view should be visible.")
        XCTAssertTrue(navigationBar.staticTexts["Settings"].exists, "The Settings view should have a title 'Settings'.")
    }
}
