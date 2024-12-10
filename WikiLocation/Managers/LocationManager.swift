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
    
    @Published public private(set) var localLocations: [Location] = [] {
        didSet {
            UserDefaults.locations = self.localLocations
        }
    }
    @Published public private(set) var remoteLocations: [Location] = []
    @Published public private(set) var isFetchingRemoteLocations = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    fileprivate init() {
        self.localLocations = AppStateManager.isUITesting ? [] : UserDefaults.locations
        SettingsManager.shared.$isRemoteFetchingEnabled
            .sink { [weak self] isEnabled in
                guard let self = self else { return }
                if isEnabled {
                    self.fetchRemoteLocations()
                } else if !self.remoteLocations.isEmpty { // to prevent multiple events when already empty
                    self.remoteLocations = []
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
        if self.isFetchingRemoteLocations {
            return
        }
        
        guard let publisher = NetworkManager.shared.fetchLocations() else {
            return
        }
        self.isFetchingRemoteLocations = true
        if !self.remoteLocations.isEmpty { // to prevent multiple events when already empty
            self.remoteLocations.removeAll()
        }
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

class SpyLocationManager: LocationManager {
    var didCallAddLocalLocation = false
    
    override init() {
        super.init()
    }
    
    override func addLocalLocation(_ location: Location) {
        super.addLocalLocation(location)
        didCallAddLocalLocation = true
    }
}
