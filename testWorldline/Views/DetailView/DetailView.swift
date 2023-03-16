//
//  DetailView.swift
//  testWorldline
//
//  Created by Luis Villanueva Rivero on 13/3/23.
//

import SwiftUI
import MapKit

struct DetailView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        VStack {
            AsyncImage(url: viewModel.item.image) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.gray
            }
            
            Spacer()

/*          First time using MapKit, it introduces some errors when the viewChanges are published, to be investigated further */
            
            Map(coordinateRegion: $viewModel.coordinates)
        }
        .navigationTitle(Text(verbatim: viewModel.item.title))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: .init(item: Location(id: "1",
                                                   title: "bernabeu",
                                                   coordinates: "22",
                                                   image: URL(string:
                                                                "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/City_of_Madrid_%2818036089422%29.jpg/150px-City_of_Madrid_%2818036089422%29.jpg"))))
    }
}

