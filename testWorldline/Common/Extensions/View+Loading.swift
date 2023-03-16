//
//  View+Loading.swift
//  testWorldline
//
//  Created by Luis Villanueva Rivero on 13/3/23.
//

import SwiftUI

extension View {
    func loadable(_ isLoading: Binding<Bool>) -> some View {
        modifier(LoadableView(isLoading: isLoading))
    }
}


struct LoadableView: ViewModifier {
    @Binding var isLoading: Bool

    func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Constants.ViewTraits.background)
                }
            }
            .animation(.easeInOut, value: isLoading)

    }
}
