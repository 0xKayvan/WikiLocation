//
//  NetworkManagerTests.swift
//  WikiLocationTests
//
//  Created by Kayvan Nouri on 09/12/2024.
//

import XCTest
import Combine

@testable import WikiLocation

final class NetworkManagerTests: XCTestCase {

    var subscriptions: Set<AnyCancellable> = []
    
    override func tearDown() {
        subscriptions.removeAll()
        super.tearDown()
    }
    
    func testRequestTypes() throws {
        let requestTypeGet = NetworkRequestTypes.get
        XCTAssertEqual(requestTypeGet.rawValue, "GET", "Request type should be GET")
    }
    
    func testNetworkRequests() throws {
        let request = NetworkRequest.fetchLocations.urlRequest
        XCTAssertNotNil(request, "Request should not be nil")
        XCTAssertEqual(request?.httpMethod, "GET", "Request method should be GET")
        XCTAssertNotNil(request?.url, "Request URL should not be nil")
        XCTAssertEqual(request?.url?.absoluteString, "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json", "Request URL should be correct")
    }
    
    func testFetchLocations() throws {
        let expectedString = """
        {
          "locations": 
          [
            {
              "name": "Amsterdam",
              "lat": 52.3547498,
              "long": 4.8339215
            },
            {
              "name": "Mumbai",
              "lat": 19.0823998,
              "long": 72.8111468
            },
            {
              "name": "Copenhagen",
              "lat": 55.6713442,
              "long": 12.523785
            },
            {
              "lat": 40.4380638,
              "long": -3.7495758
            }
          ]
        }
        """
        let expectationToFulfill = XCTestExpectation(description: "Publisher should complete successfully")
        
        let publisher = NetworkManager.shared.fetchLocations()
        XCTAssertNotNil(publisher, "Publisher should not be nil")
        
        publisher!
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Failed to fetch locations: \(error)")
                }
            } receiveValue: { data in
                let receivedString = String(data: data, encoding: .utf8)
                XCTAssertNotNil(data, "Data should not be nil")
                XCTAssertEqual(receivedString, expectedString, "Received string should match the expected one")
                print(receivedString!)
                expectationToFulfill.fulfill()
            }
            .store(in: &subscriptions)
        
        wait(for: [expectationToFulfill], timeout: 1.0)
    }

}
