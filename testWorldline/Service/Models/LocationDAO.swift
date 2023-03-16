//
//  LocationDAO.swift
//  techTest
//
//  Created by Luis Villanueva Rivero on 3/3/23.
//

import Foundation

struct LocationDAO: Codable {
    let id: String?
    let title: String?
    let geocoordinates: String?
    let image: String?
}

extension Location {
    init(from data: LocationDAO) {
        self.id = data.id ?? ""
        self.title = data.title ?? ""
        self.coordinates = data.geocoordinates ?? ""
        self.image = URL(string: data.image ?? "")
    }
}

extension Location {
    init(from data: LocationData) {
        self.id = data.id ?? ""
        self.title = data.title ?? ""
        self.coordinates = data.coordinates ?? ""
        self.image = URL(string: data.image ?? "")
    }
}
