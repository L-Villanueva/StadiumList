//
//  Array+Sort.swift
//  testWorldline
//
//  Created by Luis Villanueva Rivero on 15/3/23.
//

import Foundation

extension Array where Element == Location {
    func sortedAlphabeticaly() -> [Location] {
        return self.sorted(by: { $0.title < $1.title }) 
    }
}
