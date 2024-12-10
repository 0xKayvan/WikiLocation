//
//  ApplicationIntegrationUITests.swift
//  WikiLocationUITests
//
//  Created by Kayvan Nouri on 10/12/2024.
//

import XCTest

final class ApplicationIntegrationUITests: UITestCase {

    func testAppFunctionality() throws {
        
        let locationsTab = selectLocationsTab()
        XCTAssertTrue(locationsTab.isSelected, "The Locations tab should be selected.")
       
        let locationsTabNavigationBar = app.navigationBars.firstMatch
        XCTAssertTrue(locationsTabNavigationBar.exists, "The Locations view should be visible.")
        XCTAssertTrue(locationsTabNavigationBar.staticTexts["Locations"].exists, "The Locations view should have a title 'Locations'.")
        
        XCTAssertTrue(locationsTabNavigationBar.buttons["Add"].exists, "The Locations view should have an 'Add' button.")
        XCTAssertTrue(locationsTabNavigationBar.buttons["Add"].isEnabled, "The 'Add' button should be enabled.")
        XCTAssertTrue(locationsTabNavigationBar.buttons["Edit"].exists, "The Locations view should have an 'Edit' button.")
        XCTAssertTrue(locationsTabNavigationBar.buttons["Edit"].isEnabled, "The 'Edit' button should be enabled.")
        
        locationsTabNavigationBar.buttons["Edit"].tap()
        XCTAssertFalse(locationsTabNavigationBar.buttons["Add"].isEnabled, "The 'Add' button should be disabled at this moment.")
        XCTAssertFalse(locationsTabNavigationBar.buttons["Edit"].exists, "The Locations view should not have an 'Edit' button.")
        XCTAssertTrue(locationsTabNavigationBar.buttons["Done"].exists, "The Locations view should have an 'Done' button.")
        XCTAssertTrue(locationsTabNavigationBar.buttons["Done"].isEnabled, "The 'Done' button should be enabled.")
        locationsTabNavigationBar.buttons["Done"].tap()
        XCTAssertTrue(locationsTabNavigationBar.buttons["Add"].isEnabled, "The 'Add' button should be enabled.")
        XCTAssertTrue(locationsTabNavigationBar.buttons["Edit"].exists, "The Locations view should have an 'Edit' button.")
        XCTAssertTrue(locationsTabNavigationBar.buttons["Edit"].isEnabled, "The 'Edit' button should be enabled.")
        
        XCTAssertTrue(app.staticTexts["REMOTE"].exists, "Main list should have a 'Remote' Section Title.")
        XCTAssertFalse(app.images["no-remote-locations-image"].exists, "Main list should not have a 'No Remote Locations' image.")
        XCTAssertFalse(app.staticTexts["no-remote-locations-text"].exists, "Main list should not have a 'No Remote Locations' text.")
        XCTAssertTrue(app.staticTexts["Amsterdam"].exists, "Main list should have 'Amsterdam' item.")
        XCTAssertTrue(app.staticTexts["Mumbai"].exists, "Main list should have 'Mumbai' item.")
        XCTAssertTrue(app.staticTexts["Copenhagen"].exists, "Main list should have 'Copenhagen' item.")
        
        XCTAssertTrue(app.staticTexts["LOCAL"].exists, "Main list should have a 'Local' Section Title.")
        XCTAssertTrue(app.staticTexts["add-local-location-text"].exists, "Main list should have an 'Add Local Location' button.")
        XCTAssertTrue(app.staticTexts["add-local-location-text"].isEnabled, "The 'Add Local Location' button should be enabled.")
        XCTAssertTrue(app.images["add-local-location-image"].exists, "Main list should have an 'Add Local Location' image.")
        locationsTabNavigationBar.buttons["Edit"].tap()
        XCTAssertFalse(app.staticTexts["add-local-location-text"].isEnabled, "The 'Add Local Location' button should be disabled.")
        locationsTabNavigationBar.buttons["Done"].tap()
        XCTAssertTrue(app.staticTexts["add-local-location-text"].isEnabled, "The 'Add Local Location' button should be enabled.")
        
        app.staticTexts["add-local-location-text"].tap()
        let addLocationNavigationBar = app.navigationBars.firstMatch
        XCTAssertTrue(addLocationNavigationBar.exists, "Add new location view should be visible.")
        XCTAssertTrue(addLocationNavigationBar.staticTexts["Add Location"].exists, "Add new location view should have a title 'Add Location'.")
        XCTAssertTrue(locationsTabNavigationBar.buttons["Locations"].exists, "The Locations view should have a back button.")
        locationsTabNavigationBar.buttons["Locations"].tap()
        XCTAssertTrue(locationsTabNavigationBar.exists, "The Locations view should be visible.")
        locationsTabNavigationBar.buttons["Add"].tap()
        XCTAssertTrue(addLocationNavigationBar.exists, "Add new location view should be visible.")
        
        XCTAssertTrue(app.textFields["Name"].exists, "Add new location view should have a 'Name' text field.")
        XCTAssertTrue(app.textFields["Latitude"].exists, "Add new location view should have a 'Latitude' text field.")
        XCTAssertTrue(app.textFields["Longitude"].exists, "Add new location view should have a 'Longitude' text field.")
        XCTAssertTrue(app.buttons["Save"].exists, "Add new location view should have a 'Save' button.")
        XCTAssertFalse(app.buttons["Save"].isEnabled, "The 'Save' button should be disabled.")
        app.textFields["Latitude"].tap()
        app.textFields["Latitude"].typeText("52.29083")
        XCTAssertFalse(app.buttons["Save"].isEnabled, "The 'Save' button should be disabled.")
        app.textFields["Longitude"].tap()
        app.textFields["Longitude"].typeText("4.58333")
        XCTAssertTrue(app.buttons["Save"].isEnabled, "The 'Save' button should be enabled.")
        app.textFields["Latitude"].tap()
        app.textFields["Latitude"].clearText()
        app.textFields["Latitude"].typeText("522.9083")
        XCTAssertFalse(app.buttons["Save"].isEnabled, "The 'Save' button should be disabled.")
        app.textFields["Latitude"].tap()
        app.textFields["Latitude"].clearText()
        app.textFields["Latitude"].typeText("52.29083")
        XCTAssertTrue(app.buttons["Save"].isEnabled, "The 'Save' button should be enabled.")
        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("Hillegom")
        XCTAssertTrue(app.buttons["Save"].isEnabled, "The 'Save' button should be enabled.")
        app.buttons["Save"].tap()
        
        XCTAssertFalse(app.staticTexts["add-local-location-text"].exists, "Main list should not have an 'Add Local Location' button.")
        XCTAssertFalse(app.images["add-local-location-image"].exists, "Main list should not have an 'Add Local Location' image.")
       
        
        let settingsTab = selectSettingsTab()
        XCTAssertTrue(settingsTab.isSelected, "The Settings tab should be selected.")
        
        let settingsTabNavigationBar = app.navigationBars.firstMatch
        XCTAssertTrue(settingsTabNavigationBar.exists, "The Settings view should be visible.")
        XCTAssertTrue(settingsTabNavigationBar.staticTexts["Settings"].exists, "The Settings view should have a title 'Settings'.")
        
        XCTAssertTrue(app.staticTexts["REMOTE LOCATIONS"].exists, "Settings list should have a 'Remote Location' Section Title.")
        XCTAssertTrue(app.switches["remote-fetching-toggle"].exists, "Settings list should have a 'Remote Fetching' toggle.")
        XCTAssertEqual(app.switches["remote-fetching-toggle"].value as? String, "1", "The 'Remote Fetching' toggle should be on.")
        
        XCTAssertTrue(app.staticTexts["LOCAL LOCATIONS"].exists, "Settings list should have a 'Local Location' Section Title.")
        XCTAssertTrue(app.images["add-sample-location-image"].exists, "Settings list should have a plus button for 'Add Sample Location' button.")
        XCTAssertTrue(app.buttons["add-sample-location-button"].exists, "Settings list should have an 'Add Sample Location' button.")
        XCTAssertTrue(app.images["clear-local-locations-image"].exists, "Settings list should have a trash button for 'Clear Local Locations' button.")
        XCTAssertTrue(app.buttons["clear-local-locations-button"].exists, "Settings list should have a 'Clear Local Locations' button.")
        
        
        app.buttons["clear-local-locations-button"].tap()
        _  = selectLocationsTab()
        XCTAssertTrue(locationsTabNavigationBar.exists, "The Locations view should be visible.")
        
        XCTAssertTrue(app.staticTexts["add-local-location-text"].exists, "Main list should have an 'Add Local Location' button.")
        XCTAssertTrue(app.staticTexts["add-local-location-text"].isEnabled, "The 'Add Local Location' button should be enabled.")
        XCTAssertTrue(app.images["add-local-location-image"].exists, "Main list should have an 'Add Local Location' image.")
        
        _ = selectSettingsTab()
        XCTAssertTrue(settingsTabNavigationBar.exists, "The Settings view should be visible.")
        app.buttons["add-sample-location-button"].tap()
        _ = selectLocationsTab()
        XCTAssertTrue(locationsTabNavigationBar.exists, "The Locations view should be visible.")
        XCTAssertFalse(app.staticTexts["add-local-location-text"].exists, "Main list should not have an 'Add Local Location' button.")
        XCTAssertFalse(app.images["add-local-location-image"].exists, "Main list should not have an 'Add Local Location' image.")
        
        _ = selectSettingsTab()
        XCTAssertTrue(settingsTabNavigationBar.exists, "The Settings view should be visible.")
        XCTAssertTrue(app.switches["remote-fetching-toggle"].isHittable)
        app.staticTexts["Remote Fetching"].tap()
        
        XCTAssertEqual(app.switches["remote-fetching-toggle"].value as? String, "0", "The 'Remote Fetching' toggle should be off.")
        _ = selectLocationsTab()
        XCTAssertTrue(locationsTabNavigationBar.exists, "The Locations view should be visible.")
        XCTAssertTrue(app.staticTexts["REMOTE"].exists, "Main list should have a 'Remote' Section Title.")
        XCTAssertTrue(app.images["no-remote-locations-image"].exists, "Main list should have a 'No Remote Locations' image.")
        XCTAssertTrue(app.staticTexts["no-remote-locations-text"].exists, "Main list should have a 'No Remote Locations' text.")
        
        addTeardownBlock {
            UserDefaults.standard.removeObject(forKey: "locations-test")
        }
    }
}


extension XCUIElement {
    func clearText() {
        
        guard let stringValue = self.value as? String else {
            return
        }
        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
}
