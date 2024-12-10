//
//  SettingsManager.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import Combine
import Foundation

public class SettingsManager: ObservableObject {
    public static let shared = SettingsManager()
    
    @Published public var isRemoteFetchingEnabled: Bool = !AppStateManager.useMocks
    
    private init() {
        if ProcessInfo.processInfo.environment["REMOTE_FETCHING_ENABLED"] == "true" {
            self.isRemoteFetchingEnabled = true
        }    
    }
}
