//
//  LocationCellView.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import SwiftUI

struct LocationCellView: View {
    let location: Location
    
    var body: some View {
        VStack(alignment: .leading) {
            if let name = location.name {
                Text(name)
                    .font(.headline)
            }
            HStack {
                Text("Coordinates:")
                    .font(.subheadline)
                Spacer()
                Text("\(location.latitude), \(location.longitude)")
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    LocationCellView(location: Location(name: "Loc 1", latitude: 10.101010, longitude: 20.202020))
}
