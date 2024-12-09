//
//  AppStateManager.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 09/12/2024.
//

import Foundation

class AppStateManager {
    static var useMocks: Bool {
        return Bool(ProcessInfo.processInfo.environment["USE_MOCKS"] ?? "") ?? false
    }
}
