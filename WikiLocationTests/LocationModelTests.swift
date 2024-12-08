//
//  LocationModelTest.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import XCTest
@testable import WikiLocation

final class LocationModelTests: XCTestCase {

    func testLocationInit() {
        let location = Location(name: "Test", latitude: 1.0, longitude: 2.0)
        XCTAssertNotNil(location.id)
        XCTAssertEqual(location.name, "Test")
        XCTAssertEqual(location.latitude, 1.0)
        XCTAssertEqual(location.longitude, 2.0)
    }
    
    func testLocationInitNoName() {
        let location = Location(latitude: 1.0, longitude: 2.0)
        XCTAssertNotNil(location.id)
        XCTAssertNil(location.name)
        XCTAssertEqual(location.latitude, 1.0)
        XCTAssertEqual(location.longitude, 2.0)
    }
    
    // MARK: - Mockable Tests
    func testMockability() {
        let location = Location.mock()
        // Ignore the Xcode warning which says "'is' test is always true"
        // Swift compiler is type-checking the protocol conformity,
        // and even though the warning is correct, the test will fail
        // if the protocol conformity is removed from class definition.
        XCTAssertTrue(location is (any Mockable), "Location should be mockable")
    }
    
    func testStub() {
        let location = Location.stub()
        XCTAssertNotNil(location.id)
        XCTAssertEqual(location.name, "Amsterdam", "Default stub name should be Amsterdam")
        XCTAssertEqual(location.latitude, 52.3676, "Default stub latitude should be 52.3676")
        XCTAssertEqual(location.longitude, 4.9041, "Default stub longitude should be 4.9041")
    }
    
    func testMock() {
        let location = Location.mock()
        XCTAssertNotNil(location.id)
        XCTAssertNotNil(location.name)
        XCTAssertNotNil(location.latitude)
        XCTAssertNotNil(location.longitude)
    }
    
    func testMocks() {
        let locations = Location.mocks(count: 3)
        XCTAssertEqual(locations.count, 3, "Should return 3 locations")
        locations.forEach { location in
            XCTAssertNotNil(location.id)
            XCTAssertNotNil(location.name)
            XCTAssertNotNil(location.latitude)
            XCTAssertNotNil(location.longitude)
        }
    }
}


