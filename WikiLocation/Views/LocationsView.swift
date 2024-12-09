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
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    self.didTapOn(location)
                                }
                        }
                    }
                }
                
                Section(header: Text("Local")) {
                    if locationManager.localLocations.isEmpty {
                        NavigationLink {
                            AddLocationView()
                        } label: {
                            Image(systemName: "plus")
                            Text("Add Local Location")
                        }
                        .foregroundColor(.accentColor)
                    } else {
                        ForEach(locationManager.localLocations) { location in
                            LocationCellView(location: location)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    self.didTapOn(location)
                                }
                        }
                        .onDelete(perform: self.removeRows)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddLocationView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Locations")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        locationManager.removeLocalLocation(at: offsets)
    }
    
    func didTapOn(_ location: Location) {
        let schemeURL = "wikipedia://places/?latitude=\(location.latitude)&longitude=\(location.longitude)"
        guard let url = URL(string: schemeURL) else {
            // TODO: show alert
            return
        }
        UIApplication.shared.open(url)
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationManager.shared)
}
