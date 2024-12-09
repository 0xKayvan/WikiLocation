//
//  NetworkRequest.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 09/12/2024.
//
import Foundation

enum NetworkRequest {
    case fetchLocations
    
    var urlRequest: URLRequest? {
        switch self {
        case .fetchLocations:
            //TODO: Extract base url
            guard let url = URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json") else {
                return nil
            }
            var request = URLRequest(url: url)
            request.httpMethod = NetworkRequestTypes.get.rawValue
            return request
        }
    }
}

