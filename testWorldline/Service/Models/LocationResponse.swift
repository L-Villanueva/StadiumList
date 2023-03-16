//
//  LocationResponse.swift
//  techTest
//
//  Created by Luis Villanueva Rivero on 13/3/23.
//

import Foundation

struct LocationResponse: Codable {
    let list: [LocationDAO]

    init(data: Data) throws {
      self = try JSONDecoder().decode(LocationResponse.self, from: data)
    }
}
