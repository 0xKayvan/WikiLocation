//
//  SettingsView.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        NavigationStack {
            List {
                Section("Remote Locations") {
                    Toggle("Remote Fetching", isOn: $settingsManager.isRemoteFetchingEnabled)
                }
                Section("Local Locations") {
                    HStack {
                        Image(systemName: "plus")
                        Button("Add Mock Location") {
                            locationManager.localLocations.append(contentsOf: Location.mocks(count: 5))
                        }
                    }
                    .foregroundColor(.primary)
                    
                    HStack {
                        Image(systemName: "trash")
                        Button("Clear Local Locations") {
                            // TODO: show confirmation alert
                            locationManager.localLocations = []
                        }
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsManager.shared)
}
