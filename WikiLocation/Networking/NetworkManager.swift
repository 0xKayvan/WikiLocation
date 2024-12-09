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
        guard let request = NetworkRequest.fetchLocations.urlRequest else {
            // TODO: throw an error
            return nil
        }
        let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: request)
        
        let publisher = dataTaskPublisher
            .tryMap { data, response -> Data in
                guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}
