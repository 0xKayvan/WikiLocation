//
//  UserDefaults+Location.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 09/12/2024.
//

import Foundation

extension UserDefaults {
    static var locationsKey = "locations"
    
    static var locations: [Location] {
        get {
            guard let data = UserDefaults.standard.data(forKey: locationsKey) else {
                return []
            }
            do {
                let locations = try JSONDecoder().decode([Location].self, from: data)
                return locations
            } catch {
                return []
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: locationsKey)
            } catch {
                print("Error saving locations")
            }
        }
    }
    
    static func removeAllLocations() {
        UserDefaults.standard.removeObject(forKey: locationsKey)
    }
}
