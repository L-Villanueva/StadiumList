//
//  URLPetitions.swift
//  testWorldline
//
//  Created by Luis Villanueva Rivero on 16/3/23.
//

import Foundation

struct Petitions {
    static func get(url: URL) async throws -> Data{
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return data
    }
}
