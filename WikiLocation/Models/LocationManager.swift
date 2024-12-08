//
//  LocationManager.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

class LocationManager {
    public static let shared = LocationManager()
    
    public var localLocations: [Location] = []
    public var remoteLocations: [Location] = []
    
    private init() {}
    
    public func addLocalLocation(location: Location) {
        localLocations.append(location)
    }
    
    public func fetchRemoteLocations() {
        // Fetch remote locations
    }
}
