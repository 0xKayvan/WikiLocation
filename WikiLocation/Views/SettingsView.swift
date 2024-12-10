//
//  SettingsView.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var settingsManager: SettingsManager
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        NavigationStack {
            List {
                Section("Remote Locations") {
                    Toggle("Remote Fetching", isOn: $settingsManager.isRemoteFetchingEnabled)
                        .accessibilityLabel("remote-fetching-toggle")
                        .onTapGesture {
                            // as strange as it may seem, the toggle does not trigger from the UITests
                            // so we need to manually toggle the value by tapping on the cell
                            settingsManager.isRemoteFetchingEnabled.toggle()
                        }
                }
                Section("Local Locations") {
                    HStack {
                        Image(systemName: "plus")
                            .accessibilityLabel("add-sample-location-image")
                        Button("Add Sample Location") {
                            locationManager.addLocalLocations(Location.mocks(count: 5))
                        }
                        .accessibilityLabel("add-sample-location-button")
                    }
                    .foregroundColor(.primary)
                    
                    HStack {
                        Image(systemName: "trash")
                            .accessibilityLabel("clear-local-locations-image")
                        Button("Clear Local Locations") {
                            // TODO: show confirmation alert
                            locationManager.clearLocalLocations()
                        }
                        .accessibilityLabel("clear-local-locations-button")
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
