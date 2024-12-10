//
//  Mockable.swift
//  WikiLocation
//
//  Created by Kayvan Nouri on 08/12/2024.
//

protocol Mockable {
    associatedtype InstanceType
    
    static func stub() -> InstanceType
    static func mock() -> InstanceType
    static func mocks(count: Int) -> [InstanceType]
}

extension Mockable {
    // default mocks implementation
    static func mocks(count: Int) -> [InstanceType] {
        return (0..<count).map { _ in Self.mock() }
    }
}
