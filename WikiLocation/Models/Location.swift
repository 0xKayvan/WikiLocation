//
//  Location.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import Foundation

class Location: Identifiable {
    public var id: String
    public var name: String?
    public var latitude: Double?
    public var longitude: Double?
    
    init(name: String? = nil, latitude: Double, longitude: Double) {
        self.id = UUID().uuidString
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
