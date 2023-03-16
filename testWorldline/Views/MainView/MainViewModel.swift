//
//  MainViewModel.swift
//  techTest
//
//  Created by Luis Villanueva Rivero on 3/3/23.
//

import Combine
import Dependiject

extension MainView {
    @MainActor class ViewModel: ObservableObject {
//      MARK: - Injected dependencies, using DependInject to manage it, if unavailable should be inyected from the previous view manually
        @Store var locationLoad = Factory.shared.resolve(MainStoreLoadProtocol.self)
        @Store var locationDelete = Factory.shared.resolve(MainStoreDeleteProtocol.self)
        @Store var locationRefresh = Factory.shared.resolve(MainStoreRefreshProtocol.self)

//      MARK: - Published properties
        @Published var locations: Locations = .init() {
            didSet {
                showAlert = locations.error != nil
            }
        }

        @Published var isLoading = true
        @Published var showAlert: Bool = false
        @Published var searchText: String = ""

//      MARK: - Computed properties
        var errorDescription: String {
            locations.error?.localizedDescription ?? ""
        }

        var items: [Location] {
            if searchText.isEmpty {
                return locations.items.sortedAlphabeticaly()
            } else {
                return locations.items.filter { $0.title.contains(searchText) }.sortedAlphabeticaly()
            }
        }

//      MARK: - Model methods
        func loadLocations() async {
            self.isLoading = true
            locations = await locationLoad.loadData()
            self.isLoading = false
        }

        func deleteLocation(location: Location) async {
            locations = await locationDelete.deleteData(item: location)
        }

        func refreshLocations() async {
            self.isLoading = true
            // if we dont wait the loading animation is not seen, added for testing purposes
            try? await Task.sleep(nanoseconds: 500_000_000)
            locations = await locationRefresh.deleteAndRefresh()
            self.isLoading = false
        }

//      MARK: - Localizables
        private enum Localizable {
            static let mainTitle = "main_title"
            static let mainDelete = "main_delete"
            static let mainInstructions = "main_instructions"
            static let mainEmptyList = "main_empty_list"
            static let mainTryAgain = "main_try_again"
        }

        var mainTitle: String { Localizable.mainTitle.localized }

        var mainDelete: String { Localizable.mainDelete.localized }

        var mainInstructions: String { Localizable.mainInstructions.localized }

        var mainEmptyList: String { Localizable.mainEmptyList.localized }

        var mainTryAgain: String { Localizable.mainTryAgain.localized }
    }
}
