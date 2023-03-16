//
//  MainViewCell.swift
//  testWorldline
//
//  Created by Luis Villanueva Rivero on 15/3/23.
//

import SwiftUI
import Kingfisher

struct MainViewCell: View {

    let image: URL?
    let title: String

    var body: some View {
        Label {
            Text(title)
        } icon: {
            AsyncImage(url: image) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 3))
            } placeholder: {
                Color.gray
            }.frame(width: 40, height: 30)

//          Similar using Kingfisher, right now trying to use new AsyncImage
//
//            KFImage.url(image)
//                .resizing(referenceSize: CGSize(width: 40, height: 30))
//                .roundCorner(radius: Radius.point(5))

        }
    }
}

struct MainViewCell_Previews: PreviewProvider {
    static var previews: some View {
        MainViewCell(image:
                        URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Camp_Nou_aerial_%28cropped%29.jpg/150px-Camp_Nou_aerial_%28cropped%29.jpg"),
                     title: "sssss")
    }
}
