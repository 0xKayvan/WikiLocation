//
//  LocationManager.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//
import Foundation
import Combine

class LocationManager: ObservableObject {
    public static let shared = LocationManager()
    
    @Published public private(set) var localLocations: [Location] = []
    @Published public private(set) var remoteLocations: [Location] = []
    @Published public private(set) var isFetchingRemoteLocations = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    private init() {
        self.fetchRemoteLocations()
        SettingsManager.shared.$isRemoteFetchingEnabled
            .sink { [weak self] isEnabled in
                if isEnabled {
                    self?.fetchRemoteLocations()
                } else {
                    self?.remoteLocations = []
                }
            }
            .store(in: &subscriptions)
    }
    
    // TODO: change to a throwing function
    public func createAndSaveLocalLocation(name: String?, latitude: Double, longitude: Double) -> Bool {
        if !Location.areCoordinatesValid(latitude: latitude, longitude: longitude) {
            return false
        }
        self.addLocalLocation(Location(name: name, latitude: latitude, longitude: longitude))
        return true
    }
    
    public func addLocalLocation(_ location: Location) {
        localLocations.append(location)
    }
    
    public func addLocalLocations(_ locations: [Location]) {
        localLocations.append(contentsOf: locations)
    }
   
    public func clearLocalLocations() {
        localLocations.removeAll()
    }
    
    public func removeLocalLocation(at offsets: IndexSet) {
        localLocations.remove(atOffsets: offsets)
    }
    
    public func fetchRemoteLocations() {
        guard let publisher = NetworkManager.shared.fetchLocations() else {
            return
        }
        self.isFetchingRemoteLocations = true
        publisher
            .tryMap { data in
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = jsonObject as? [String: Any], let nestedJson = dictionary.values.first {
                    return try JSONSerialization.data(withJSONObject: nestedJson, options: [])
                } else {
                    throw URLError(.cannotDecodeContentData)
                }
            }
            .decode(type: [Location].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isFetchingRemoteLocations = false
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
