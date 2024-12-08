//
//  LocationsView.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import SwiftUI

struct LocationsView: View {
    private let tempLocations = [
        Location(name: "Loc 1", latitude: 10.101010, longitude: 20.202020),
        Location(name: "Loc 2", latitude: -10.101010, longitude: -20.202020),
        Location(name: "Loc 3", latitude: 0.0, longitude: 0.0),
        Location(latitude: 90.0, longitude: 180.0)
    ]
    var body: some View {
        NavigationStack {
            List {
                ForEach(tempLocations) { location in
                    LocationCellView(location: location)
                }
            }
            .navigationTitle("Locations")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    LocationsView()
}
