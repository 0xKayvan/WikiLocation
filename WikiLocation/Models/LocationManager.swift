//
//  LocationManager.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//
import Foundation
import Combine

class LocationManager {
    public static let shared = LocationManager()
    
    public var localLocations: [Location] = []
    public var remoteLocations: [Location] = []
    
    private var subscriptions = Set<AnyCancellable>()
    
    private init() {
        self.fetchRemoteLocations()
    }
    
    public func addLocalLocation(location: Location) {
        localLocations.append(location)
    }
    
    public func fetchRemoteLocations() {
        // TODO: Move this to a proper class
        guard let url = URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json") else {
            return
        }
        
        let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: url)
        
        dataTaskPublisher
            .tryMap { data, response -> Data in
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = jsonObject as? [String: Any], let nestedJson = dictionary.values.first {
                    return try JSONSerialization.data(withJSONObject: nestedJson, options: [])
                } else {
                    throw URLError(.badServerResponse)
                }
            }
            .decode(type: [Location].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // TODO: Handle error
                    break
                }
            }, receiveValue: { locations in
                self.remoteLocations = locations
            })
            .store(in: &subscriptions)
    }
}
