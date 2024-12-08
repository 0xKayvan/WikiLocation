//
//  LocationModelTest.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import XCTest
@testable import WikiLocation

final class LocationModelTest: XCTestCase {

    func testLocationInit() {
        let location = Location(name: "Test", latitude: 1.0, longitude: 2.0)
        XCTAssertEqual(location.name, "Test")
        XCTAssertEqual(location.latitude, 1.0)
        XCTAssertEqual(location.longitude, 2.0)
    }
    
    func testLocationInitNoName() {
        let location = Location(latitude: 1.0, longitude: 2.0)
        XCTAssertNil(location.name)
        XCTAssertEqual(location.latitude, 1.0)
        XCTAssertEqual(location.longitude, 2.0)
    }
}


