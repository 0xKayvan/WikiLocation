//
//  LocationsView.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import SwiftUI

struct LocationsView: View {
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Remote")) {
                    if locationManager.isFetchingRemoteLocations {
                        HStack {
                            ProgressView()
                            Text("Fetching remote locations")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    } else if locationManager.remoteLocations.isEmpty {
                        HStack {
                            Image(systemName: "network.slash")
                            Text("No remote locations available")
                                .font(.subheadline)
                        }
                        .foregroundColor(.secondary)
                    } else {
                        ForEach(locationManager.remoteLocations) { location in
                            LocationCellView(location: location)
                        }
                    }
                }
                
                Section(header: Text("Local")) {
                    if locationManager.localLocations.isEmpty {
                        NavigationLink {
                            // Navigate to AddLocationView
                        } label: {
                            Image(systemName: "plus")
                            Text("Add Local Location")
                        }
                        .foregroundColor(.accentColor)
                    } else {
                        ForEach(locationManager.localLocations) { location in
                            LocationCellView(location: location)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                        .disabled(locationManager.localLocations.isEmpty)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        // Navigate to AddLocationView
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Locations")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationManager.shared)
}
