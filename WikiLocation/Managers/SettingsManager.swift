//
//  SettingsManager.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import Combine

public class SettingsManager: ObservableObject {
    public static let shared = SettingsManager()
    
    @Published public var isRemoteFetchingEnabled = true
    
    private init() {}
}
