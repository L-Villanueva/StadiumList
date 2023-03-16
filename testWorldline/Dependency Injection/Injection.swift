//
//  Injection.swift
//  testWorldline
//
//  Created by Luis Villanueva Rivero on 15/3/23.
//

import Dependiject

enum Injection {
    static func inject() {
        Factory.register {
            Service(.singleton, FetchLocationsProtocol.self ) { _ in
                FetchLocations()
            }

            Service(.singleton, MainStoreLoadProtocol.self) { _ in
                MainStoreLoad()
            }

            Service(.singleton, MainStoreDeleteProtocol.self) { _ in
                MainStoreDelete()
            }

            Service(.singleton, MainStoreRefreshProtocol.self) { _ in
                MainStoreRefresh()
            }
        }
    }
}
