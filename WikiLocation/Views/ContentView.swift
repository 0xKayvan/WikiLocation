//
//  ContentView.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import SwiftUI

struct ContentView: View {
    enum Tabs {
        case locations
        case settings
    }
    
    @State var selectedTab: Tabs = .locations
    
    var body: some View {
        TabView {
            Group {
                LocationsView()
                .tabItem {
                    Label("Locations", systemImage: "mappin.and.ellipse")
                }
                .tag(Tabs.locations)
                
                SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(Tabs.locations)
            }
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
    
    public func switchTab(to tab: Tabs) {
        selectedTab = tab
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationManager.shared)
        .environmentObject(SettingsManager.shared)
}
