//
//  DetailViewModel.swift
//  testWorldline
//
//  Created by Luis Villanueva Rivero on 13/3/23.
//

import Combine
import MapKit

extension DetailView {
    @MainActor class ViewModel: ObservableObject {
        let item: Location

        @Published var coordinates: MKCoordinateRegion = .init(.null)
        init(item: Location) {
            self.item = item
            handleLocation()
        }

        func handleLocation() {
            guard let int1 = Double(item.latLong.first ?? ""),
                  let int2 = Double(item.latLong.last ?? "") else { return }

            let center = CLLocationCoordinate2D(latitude: int1,
                                                longitude: int2)
            let span = MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.01),
                                        longitudeDelta: CLLocationDegrees(0.01))
            coordinates = MKCoordinateRegion(center: center, span: span)
        }
    }
}
