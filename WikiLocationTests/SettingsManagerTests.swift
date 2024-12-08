//
//  SettingsManagerTests.swift
//  WikiLocationTests
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import XCTest
import Combine

@testable import WikiLocation

final class SettingsManagerTests: XCTestCase {

    var subscriptions = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSettingsManagerInit() throws {
        let settingsManager = SettingsManager.shared
        XCTAssertNotNil(settingsManager, "SettingsManager should not be nil.")
        XCTAssertTrue(settingsManager.isRemoteFetchingEnabled, "Remote fetching should be enabled by default.")
    }

    func testRemoteFetchingObservability() throws {
        let settingsManager = SettingsManager.shared
        settingsManager.$isRemoteFetchingEnabled
            .dropFirst()
            .sink { value in
                XCTAssertFalse(value, "Remote fetching should be disabled.")
            }
            .store(in: &subscriptions)
        settingsManager.isRemoteFetchingEnabled = false
        addTeardownBlock {
            self.subscriptions.removeAll()
        }
    }
    
}
