//
//  techTestApp.swift
//  techTest
//
//  Created by Luis Villanueva Rivero on 3/3/23.
//

import SwiftUI

@main
struct techTestApp: App {

    init() {
        Injection.inject()
    }

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: .init())
        }
    }
}
