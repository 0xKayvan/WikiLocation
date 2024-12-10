//
//  SnapshotTests.swift
//  WikiLocationTests
//
//  Created by Kayvan Nouri on 10/12/2024.
//

import XCTest
import iOSSnapshotTestCase

@testable import WikiLocation

final class SnapshotTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
//        self.recordMode = true
    }

    func testSnapShotMainView() throws {
        let contentView = ContentView()
            .environmentObject(LocationManager.shared)
            .environmentObject(SettingsManager.shared)
            .environment(\.colorScheme, .light)
        
        let view = createUIView(from: contentView)
        FBSnapshotVerifyView(view)
    }
    
    func testSnapShotSettingsView() throws {
        let settingsView = SettingsView()
            .environmentObject(SettingsManager.shared)
            .environment(\.colorScheme, .light)
        
        let view = createUIView(from: settingsView)
        FBSnapshotVerifyView(view)
    }
    
    func testSnapShotAddLocationView() throws {
        let addLocationView = AddLocationView()
            .environmentObject(LocationManager.shared)
            .environmentObject(SettingsManager.shared)
            .environment(\.colorScheme, .light)
        
        let view = createUIView(from: addLocationView)
        FBSnapshotVerifyView(view)
    }
    

}
