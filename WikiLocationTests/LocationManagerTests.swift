//
//  LocationManagerTests.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import XCTest
import Combine

@testable import WikiLocation

final class LocationManagerTests: XCTestCase {
    
    var subscriptions: Set<AnyCancellable> = []
    
    override func tearDown() {
        subscriptions.removeAll()
        super.tearDown()
    }
    
    func testLocationManagerInit() throws {
        let locationManager = LocationManager.shared
        XCTAssertNotNil(locationManager.localLocations)
        XCTAssertNotNil(locationManager.remoteLocations)
        XCTAssertEqual(locationManager.localLocations.count, 0, "Local locations should be empty")
        XCTAssertEqual(locationManager.remoteLocations.count, 0, "Remote locations should be empty")
    }
    
    func testAppendLocalLocation() throws {
        let locationManager = LocationManager.shared
        let location = Location(name: "Test", latitude: 1.0, longitude: 2.0)
        locationManager.addLocalLocation(location)
        XCTAssertEqual(locationManager.localLocations.count, 1, "Local locations should have one item")
        addTeardownBlock {
            locationManager.clearLocalLocations()
        }
    }
    
    func testLocalLocationsObservability() throws {
        let locationManager = LocationManager.shared
        let location = Location(name: "Test", latitude: 1.0, longitude: 2.0)
        
        let expectationToFulfill = XCTestExpectation(description: "Publisher should complete successfully")
        
        locationManager.$localLocations
            .dropFirst()
            .sink { receivedLocations in
                XCTAssertEqual(receivedLocations.count, 1, "Local locations should have one item")
                XCTAssertEqual(receivedLocations.first, location, "Received location should be the same as the added location")
                expectationToFulfill.fulfill()
            }
            .store(in: &subscriptions)
        locationManager.addLocalLocation(location)
        
        addTeardownBlock {
            self.subscriptions.removeAll()
            locationManager.clearLocalLocations()
        }
        
        wait(for: [expectationToFulfill], timeout: 10.0)
    }
    
    
    func testRemoteLocationsObservability() throws {
        let locationManager = LocationManager.shared
        
        let expectationToFulfill = XCTestExpectation(description: "Publisher should complete successfully")
        
        locationManager.$remoteLocations
            .dropFirst()
            .sink { receivedLocations in
                print(receivedLocations.count)
                XCTAssertEqual(receivedLocations.count, 4, "Remote locations should have 4 item")
                expectationToFulfill.fulfill()
            }
            .store(in: &subscriptions)

        addTeardownBlock {
            self.subscriptions.removeAll()
        }
        
        // Enabling remote fetching will trigger fetchRemoteLocations
        SettingsManager.shared.isRemoteFetchingEnabled = true
        wait(for: [expectationToFulfill], timeout: 1.0)
    }
    
    func testIsFetchingRemoteLocationsObservability() throws {
        let locationManager = LocationManager.shared
        let expectationToFulfill = XCTestExpectation(description: "Publisher should complete successfully")
        
        locationManager.$isFetchingRemoteLocations
            .dropFirst()
            .sink { isFetching in
                XCTAssertTrue(isFetching, "isFetchingRemoteLocations should be true")
                expectationToFulfill.fulfill()
            }
            .store(in: &subscriptions)

        addTeardownBlock {
            self.subscriptions.removeAll()
        }
        
        // Enabling remote fetching will trigger fetchRemoteLocations
        SettingsManager.shared.isRemoteFetchingEnabled = true
        wait(for: [expectationToFulfill], timeout: 10.0)
    }
    
    func testCreateAndAddLocation() throws {
        let locationManager = SpyLocationManager()
        
        let creationResultThatFails = locationManager.createAndSaveLocalLocation(name: "Test", latitude: 91.0, longitude: 2.0)
        XCTAssertFalse(creationResultThatFails, "Location creation should fail with invalid latitude")
        
        let creationResultThatSucceeds = locationManager.createAndSaveLocalLocation(name: "Test", latitude: 1.0, longitude: 2.0)
        XCTAssertTrue(creationResultThatSucceeds, "Location creation should succeed with valid latitude")
        
        XCTAssertEqual(locationManager.localLocations.count, 1, "Local locations should have one item")
        XCTAssertTrue(locationManager.didCallAddLocalLocation, "addLocalLocation should be called")
        
        addTeardownBlock {
            locationManager.clearLocalLocations()
        }
    }
    
    func testAddLocalLocations() throws {
        let locationManager = LocationManager.shared
        let locations = Location.mocks(count: 3)
        
        locationManager.addLocalLocations(locations)
        XCTAssertEqual(locationManager.localLocations.count, 3, "Local locations should have 3 items")
        
        addTeardownBlock {
            locationManager.clearLocalLocations()
        }
    }
    
    func testFetchRemoteLocations() throws {
        let locationManager = LocationManager.shared
        
        let expectationToFulfill = XCTestExpectation(description: "Publisher should complete successfully")
        
        locationManager.$remoteLocations
            .dropFirst()
            .sink { receivedLocations in
                XCTAssertEqual(receivedLocations.count, 4, "Remote locations should have 4 item")
                expectationToFulfill.fulfill()
            }
            .store(in: &subscriptions)

        addTeardownBlock {
            self.subscriptions.removeAll()
        }
        
        locationManager.fetchRemoteLocations()
        wait(for: [expectationToFulfill], timeout: 1.0)
    }
}
