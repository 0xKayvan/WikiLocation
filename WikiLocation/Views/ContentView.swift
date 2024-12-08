//
//  ContentView.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Group {
                Text("Locations Tab")
                .tabItem {
                    Label("Locations", systemImage: "mappin.and.ellipse")
                }
                
                Text("Settings Tab")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            }
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
