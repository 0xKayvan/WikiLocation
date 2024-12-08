//
//  AddLocationView.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 09/12/2024.
//

import SwiftUI

struct AddLocationView: View {
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var latitude = ""
    @State private var longitude = ""
    @State private var isFormValid = false
    
    var body: some View {
        List {
            Section("Location Info") {
                TextField("Name", text: $name)
                TextField("Latitude", text: $latitude)
                TextField("Longitude", text: $longitude)
            }
            
            
            Section {
                Button("Save") {
                    saveAndDismiss()
                }
                .disabled(!isFormValid)
            }
        }
        .navigationTitle("Add Location")
        .onChange(of: name) {
            self.validateForm()
        }
        .onChange(of: latitude) {
            self.validateForm()
        }
        .onChange(of: longitude) {
            self.validateForm()
        }
    }
    
    private func validateForm() {
        guard let latitude = Double(latitude),
              let longitude = Double(longitude),
              self.isLocationValid(latitude: latitude, longitude: longitude),
              !name.isEmpty else
        {
            self.isFormValid = false
            return
        }
        self.isFormValid = true
    }
    
    private func isLocationValid(latitude: Double, longitude: Double) -> Bool {
        let isLatitudeValid = (-90...90).contains(latitude)
        let isLongitudeValid = (-180...180).contains(longitude)
        return isLatitudeValid && isLongitudeValid
    }
    
    private func saveAndDismiss() {
        let location = Location(name: name, latitude: Double(latitude) ?? 0, longitude: Double(longitude) ?? 0)
        locationManager.addLocalLocation(location)
        dismiss()
    }
}

#Preview {
    AddLocationView()
        .environmentObject(LocationManager.shared)
}
