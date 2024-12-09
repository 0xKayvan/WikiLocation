//
//  NetworkManager.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 09/12/2024.
//

import Foundation
import Combine

class NetworkManager {
    public static let shared = NetworkManager()
    
    private init() {}
    
    func fetchLocations() -> AnyPublisher<Data, Error>? {
        if AppStateManager.useMocks {
            return MockNetworkRequestHandler().fetchLocations()
        } else {
            return NetworkRequestHandler().fetchLocations()
        }
    }
}

protocol NetworkRequestHandlerProtocol {
    func fetchLocations() -> AnyPublisher<Data, Error>?
}

class NetworkRequestHandler: NetworkRequestHandlerProtocol {
    func fetchLocations() -> AnyPublisher<Data, Error>? {
        guard let request = NetworkRequest.fetchLocations.urlRequest else {
            // TODO: throw an error
            return nil
        }
        let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: request)
        
        let publisher = dataTaskPublisher
            .tryMap { data, response -> Data in
                //TODO: move the magic number 200 into an enum
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

class MockNetworkRequestHandler: NetworkRequestHandlerProtocol {
    func fetchLocations() -> AnyPublisher<Data, Error>? {
        let sampleData = """
        {
          "locations": 
          [
            {
              "name": "Amsterdam",
              "lat": 52.3547498,
              "long": 4.8339215
            },
            {
              "name": "Mumbai",
              "lat": 19.0823998,
              "long": 72.8111468
            },
            {
              "name": "Copenhagen",
              "lat": 55.6713442,
              "long": 12.523785
            },
            {
              "lat": 40.4380638,
              "long": -3.7495758
            }
          ]
        }
        """.data(using: .utf8)!
        return Just(sampleData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
