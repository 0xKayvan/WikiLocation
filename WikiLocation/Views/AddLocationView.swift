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
              Location.areCoordinatesValid(latitude: latitude, longitude: longitude) else {
            self.isFormValid = false
            return
        }
        self.isFormValid = true
    }
    
    
    private func saveAndDismiss() {
        if let latitude = Double(self.latitude),
           let longitude = Double(self.longitude),
           self.locationManager.createAndSaveLocalLocation(name: name, latitude: latitude, longitude: longitude) {
            dismiss()
            return
        }
        //TODO: show alert
    }
}

#Preview {
    AddLocationView()
        .environmentObject(LocationManager.shared)
}
