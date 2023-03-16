//
//  FetchLocations.swift
//  testWorldline
//
//  Created by Luis Villanueva Rivero on 15/3/23.
//

import Foundation
import Dependiject

protocol FetchLocationsProtocol: AnyObservableObject {
    func fetchData() async -> Locations
}

class FetchLocations: FetchLocationsProtocol, ObservableObject {

    let url = "https://sergiocasero.es/pois.json"

    func fetchData() async -> Locations {
        do {
            guard let url = URL(string: url) else {
                throw URLError(.badURL)
            }

            let data = try await Petitions.get(url: url)
            
            let result = try LocationResponse(data: data)
            let locationsData = result.list.compactMap { Location(from: $0)}
            return .init(from: locationsData)

        } catch let error {
            return .init(from: .genericError(description: error.localizedDescription))
        }
    }
}
