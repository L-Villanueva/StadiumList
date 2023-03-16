//
//  MainStore.swift
//  testWorldline
//
//  Created by Luis Villanueva Rivero on 15/3/23.
//

import Dependiject
import SwiftUI

protocol MainStoreLoadProtocol: AnyObservableObject {
    func loadData() async -> Locations
}

protocol MainStoreDeleteProtocol: AnyObservableObject {
    func deleteData(item: Location) async -> Locations
}

protocol MainStoreRefreshProtocol: AnyObservableObject {
    func deleteAndRefresh() async -> Locations
}

class MainStoreLoad: MainStoreLoadProtocol, ObservableObject {

    @Store var fetchLocations = Factory.shared.resolve(FetchLocationsProtocol.self)
    let persistenceController = PersistenceController.shared

    func loadData() async -> Locations {
        let items = persistenceController.load().map {
            Location(from: $0)
        }
        if items.isEmpty {
            let locations = await fetchLocations.fetchData()
            persistenceController.save(for: locations.items)
            return locations
        }
        return Locations(from: items)
    }
}

class MainStoreDelete: MainStoreDeleteProtocol, ObservableObject {

    @Store var loadLocations = Factory.shared.resolve(MainStoreLoadProtocol.self)
    let persistenceController = PersistenceController.shared

    func deleteData(item: Location) async -> Locations {
        persistenceController.delete(item: item)
        return await loadLocations.loadData()
    }
}

class MainStoreRefresh: MainStoreRefreshProtocol, ObservableObject {

    @Store var loadLocations = Factory.shared.resolve(MainStoreLoadProtocol.self)
    let persistenceController = PersistenceController.shared

    func deleteAndRefresh() async -> Locations {
        persistenceController.deleteAll()
        return await loadLocations.loadData()
    }
}
