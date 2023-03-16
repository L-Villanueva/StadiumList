//
//  Location.swift
//  techTest
//
//  Created by Luis Villanueva Rivero on 3/3/23.
//

import Foundation

struct Locations: Equatable {

    enum MainError: Error, Equatable {
        case genericError(description: String)
    }

    let items: [Location]
    let error: MainError?
}

struct Location: Identifiable, Equatable {
    let id: String
    let title: String
    let coordinates: String
    let image: URL?

    var latLong: [String] {
        let pene = coordinates.split(separator: ",")
        return pene.map { $0.description }
    }
}

extension Locations {
    init(from error: MainError) {
        self.items = []
        self.error = error
    }

    init(from items: [Location]) {
        self.items = items
        self.error = nil
    }

    init() {
        self.items = []
        self.error = nil
    }
}

extension Location {
    static var emptyLocation: Location {
        Location(id: "", title: "", coordinates: "", image: nil)
    }
}
