//
//  LocationManagerTests.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import XCTest
@testable import WikiLocation

final class LocationManagerTests: XCTestCase {
    
    func testLocationManagerInit() {
        let locationManager = LocationManager.shared
        XCTAssertNotNil(locationManager.localLocations)
        XCTAssertNotNil(locationManager.remoteLocations)
        XCTAssertEqual(locationManager.localLocations.count, 0, "Local locations should be empty")
        XCTAssertEqual(locationManager.remoteLocations.count, 0, "Remote locations should be empty")
    }
    
    func testAppendLocalLocation() {
        let locationManager = LocationManager.shared
        let location = Location(name: "Test", latitude: 1.0, longitude: 2.0)
        locationManager.addLocalLocation(location)
        XCTAssertEqual(locationManager.localLocations.count, 1, "Local locations should have one item")
        addTeardownBlock {
            locationManager.clearLocalLocations()
        }
    }
}
