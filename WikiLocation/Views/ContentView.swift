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
                LocationsView()
                .tabItem {
                    Label("Locations", systemImage: "mappin.and.ellipse")
                }
                
                SettingsView()
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
        .environmentObject(LocationManager.shared)
        .environmentObject(SettingsManager.shared)
}
