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
    }
}

#Preview {
    LocationCellView(location: Location.stub())
}
