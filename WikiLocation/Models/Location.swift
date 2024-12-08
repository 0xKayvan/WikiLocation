//
//  Location.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

import Foundation

class Location: Identifiable, Mockable {
    public var id: String
    public var name: String?
    public var latitude: Double
    public var longitude: Double
    
    init(name: String? = nil, latitude: Double, longitude: Double) {
        self.id = UUID().uuidString
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // MARK: - Mockable
    static func stub() -> Location {
        return Location(name: "Amsterdam", latitude: 52.3676, longitude: 4.9041)
    }
    
    static func mock() -> Location {
        let locations = [
            Location(name: "Amsterdam", latitude: 52.3676, longitude: 4.9041),
            Location(name: "Rotterdam", latitude: 51.9244, longitude: 4.4777),
            Location(name: "The Hague", latitude: 52.0705, longitude: 4.3007),
            Location(name: "Utrecht", latitude: 52.0907, longitude: 5.1214),
            Location(name: "Eindhoven", latitude: 51.4416, longitude: 5.4697),
            Location(name: "New York City", latitude: 40.7128, longitude: -74.0060),
            Location(name: "Los Angeles", latitude: 34.0522, longitude: -118.2437),
            Location(name: "London", latitude: 51.5074, longitude: -0.1278),
            Location(name: "Tokyo", latitude: 35.6895, longitude: 139.6917),
            Location(name: "Paris", latitude: 48.8566, longitude: 2.3522),
            Location(name: "Sydney", latitude: -33.8688, longitude: 151.2093),
            Location(latitude: 10.00, longitude: -10.00),
            Location(latitude: -10.00, longitude: 10.00),
            Location(latitude: 10.00, longitude: 10.00),
            Location(latitude: -10.00, longitude: -10.00),
            Location(latitude: 0.00, longitude: 0.00)
        ]
        return locations.randomElement()!
    }
    
    static func mocks(count: Int) -> [Location] {
        return (0..<count).map { _ in Self.mock() }
    }
}
