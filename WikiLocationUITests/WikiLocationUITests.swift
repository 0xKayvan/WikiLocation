//
//  WikiLocationUITests.swift
//  WikiLocationUITests
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import XCTest

final class WikiLocationUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testBaseTabView() throws {
        let app = XCUIApplication()
        app.launch()
        
        let locationsTab = app.tabBars.buttons["Locations"]
        XCTAssertTrue(locationsTab.exists, "The Locations tab should exist.")
        
        let settingsTab = app.tabBars.buttons["Settings"]
        XCTAssertTrue(settingsTab.exists, "The Settings tab should exist.")
    }
    
    @MainActor
    func testBaseTabViewFunctionality() throws {
        let app = XCUIApplication()
        app.launch()
        
        let locationsTab = app.tabBars.buttons["Locations"]
        locationsTab.tap()
        XCTAssertTrue(locationsTab.isSelected, "The Locations tab should be selected.")
        let navigationBar = app.navigationBars.firstMatch
        XCTAssertTrue(navigationBar.exists, "The Locations view should be visible.")
        XCTAssertTrue(navigationBar.staticTexts["Locations"].exists, "The Locations view should have a title 'Locations'.")
        
        
        let settingsTab = app.tabBars.buttons["Settings"]
        settingsTab.tap()
        XCTAssertTrue(settingsTab.isSelected, "The Settings tab should be selected.")
        XCTAssertTrue(app.staticTexts["Settings Tab"].exists, "There should be a text equal to 'Settings Tab'.")
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
