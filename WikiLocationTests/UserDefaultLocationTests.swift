//
//  UserDefaultLocationTests.swift
//  WikiLocationTests
//
//  Created by Kayvan Nouri on 09/12/2024.
//

import XCTest

@testable import WikiLocation

final class UserDefaultLocationTests: XCTestCase {

    func testUserDefaultSaveAndRetrieveFunctionality() {
        UserDefaults.locationsKey = "locations-test"
        let locations = UserDefaults.standard.data(forKey: UserDefaults.locationsKey)
        XCTAssertNil(locations, "Locations should be initially nil.")
        
        let locationsFromUserDefaults = UserDefaults.locations
        XCTAssertEqual(locationsFromUserDefaults.count, 0, "Locations should have zero items.")
        
        let location = Location(name: "Test", latitude: 0.0, longitude: 10.0)
        UserDefaults.locations = [location]
        
        let savedLocations = UserDefaults.locations
        XCTAssertNotNil(savedLocations, "Locations should be saved.")
        XCTAssertEqual(savedLocations.count, 1, "Locations should have one item.")
        XCTAssertEqual(savedLocations.first?.id, location.id, "Location id should match created location name: \(location.id).")
        XCTAssertEqual(savedLocations.first?.name, location.name, "Location name should match created location name: \(location.name ?? "''").")
        XCTAssertEqual(savedLocations.first?.latitude, location.latitude, "Location latitude should match created location: \(location.latitude)")
        XCTAssertEqual(savedLocations.first?.longitude, location.longitude, "Location longitude should match created location: \(location.latitude).")
        
        
        UserDefaults.removeAllLocations()
        let locationsAfterRemoval = UserDefaults.locations
        XCTAssertEqual(locationsAfterRemoval.count, 0, "Locations should have zero items.")
        
        addTeardownBlock {
            UserDefaults.removeAllLocations()
        }
    }

}
