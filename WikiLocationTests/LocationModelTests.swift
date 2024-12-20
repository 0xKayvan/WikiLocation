//
//  LocationModelTest.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import XCTest
@testable import WikiLocation

final class LocationModelTests: XCTestCase {

    func testLocationInit() throws {
        let location = Location(name: "Test", latitude: 1.0, longitude: 2.0)
        XCTAssertNotNil(location.id, "Location id should not be nil")
        XCTAssertEqual(location.name, "Test", "Location name should be Test")
        XCTAssertEqual(location.latitude, 1.0, "Location latitude should be 1.0")
        XCTAssertEqual(location.longitude, 2.0, "Location longitude should be 2.0")
    }
    
    func testLocationInitNoName() throws {
        let location = Location(latitude: 1.0, longitude: 2.0)
        XCTAssertNotNil(location.id, "Location id should not be nil")
        XCTAssertNil(location.name, "Location name should be nil")
        XCTAssertEqual(location.latitude, 1.0, "Location latitude should be 1.0")
        XCTAssertEqual(location.longitude, 2.0, "Location longitude should be 2.0")
    }
    
    func testLocationCoordinateRangeValidity() throws {
        XCTAssertTrue(Location.areCoordinatesValid(latitude: 0.0, longitude: 0.0), "Valid coordinates should be indicated as valid")
        XCTAssertTrue(Location.areCoordinatesValid(latitude: 90.0, longitude: 180.0), "Valid coordinates should be indicated as valid")
        XCTAssertTrue(Location.areCoordinatesValid(latitude: 90.0, longitude: -180.0), "Valid coordinates should be indicated as valid")
        XCTAssertTrue(Location.areCoordinatesValid(latitude: -90.0, longitude: 180.0), "Valid coordinates should be indicated as valid")
        XCTAssertTrue(Location.areCoordinatesValid(latitude: -90.0, longitude: -180.0), "Valid coordinates should be indicated as valid")
        
        
        XCTAssertFalse(Location.areCoordinatesValid(latitude: 91.0, longitude: 0.0), "Invalid coordinates should be indicated as invalid")
        XCTAssertFalse(Location.areCoordinatesValid(latitude: -91.0, longitude: 0.0), "Invalid coordinates should be indicated as invalid")
        
        XCTAssertFalse(Location.areCoordinatesValid(latitude: 0.0, longitude: 181.0), "Invalid coordinates should be indicated as invalid")
        XCTAssertFalse(Location.areCoordinatesValid(latitude: 0.0, longitude: -181.0), "Invalid coordinates should be indicated as invalid")
    }
    
    // MARK: - Mockable Tests
    func testMockability() throws {
        let location = Location.mock()
        // Ignore the Xcode warning which says "'is' test is always true"
        // Swift compiler is type-checking the protocol conformity,
        // and even though the warning is correct, the test will fail
        // if the protocol conformity is removed from class definition.
        XCTAssertTrue(location is (any Mockable), "Location should be mockable")
    }
    
    func testStub() throws {
        let location = Location.stub()
        XCTAssertNotNil(location.id, "Default stub id should not be nil")
        XCTAssertEqual(location.name, "Amsterdam", "Default stub name should be Amsterdam")
        XCTAssertEqual(location.latitude, 52.3676, "Default stub latitude should be 52.3676")
        XCTAssertEqual(location.longitude, 4.9041, "Default stub longitude should be 4.9041")
    }
    
    func testMock() throws {
        let location = Location.mock()
        XCTAssertNotNil(location.id, "Location id should not be nil")
        XCTAssertNotNil(location.latitude, "Location latitude should not be nil")
        XCTAssertNotNil(location.longitude, "Location longitude should not be nil")
    }
    
    func testMocks() throws {
        let locations = Location.mocks(count: 3)
        XCTAssertEqual(locations.count, 3, "Should return 3 locations")
        locations.forEach { location in
            XCTAssertNotNil(location.id, "Location id should not be nil")
            XCTAssertNotNil(location.latitude, "Location latitude should not be nil")
            XCTAssertNotNil(location.longitude, "Location longitude should not be nil")
        }
    }
    
    // MARK: - Codable Tests
    func testCodingKeys() throws {
        let idKey = "id"
        let nameKey = "name"
        let latitudeKey = "lat"
        let longitudeKey = "long"
        XCTAssertEqual(Location.CodingKeys.id.rawValue, idKey, "Location id key should be \(idKey)")
        XCTAssertEqual(Location.CodingKeys.name.rawValue, nameKey, "Location name key should be \(nameKey)")
        XCTAssertEqual(Location.CodingKeys.latitude.rawValue, latitudeKey, "Location latitude key should be \(latitudeKey)")
        XCTAssertEqual(Location.CodingKeys.longitude.rawValue, longitudeKey, "Location longitude key should be \(longitudeKey)")
    }
    
    func testCodable() throws {
        let location = Location(name: "Test", latitude: 1.0, longitude: 2.0)
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let data = try? encoder.encode(location)
        XCTAssertNotNil(data, "Encoded data should not be nil")
        let decodedLocation = try? decoder.decode(Location.self, from: data!)
        XCTAssertNotNil(decodedLocation, "Decoded location should not be nil")
        XCTAssertEqual(location, decodedLocation, "Decoded location should match the original location")
    }
        
}


