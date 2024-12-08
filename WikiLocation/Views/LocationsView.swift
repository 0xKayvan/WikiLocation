//
//  LocationsView.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import SwiftUI

struct LocationsView: View {
    private let tempLocations = Location.mocks(count: 5)
    
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
