//
//  String+Localizable.swift
//  testWorldline
//
//  Created by Luis Villanueva Rivero on 16/3/23.
//

import Foundation

extension String {
    var localized: Self { NSLocalizedString(self, comment: "") }
}
