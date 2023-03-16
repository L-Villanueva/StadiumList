//
//  MainView.swift
//  techTest
//
//  Created by Luis Villanueva Rivero on 3/3/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(footer: Text(viewModel.mainInstructions)) {
                    if (viewModel.items.isEmpty && !viewModel.isLoading) {
                        Text(viewModel.mainEmptyList)
                    } else {
                        ForEach(viewModel.items) { item in
                            NavigationLink(destination: {
                                DetailView(viewModel: .init(item: item))
                            }, label: {
                                MainViewCell(image: item.image, title: item.title)
                            })
                            .swipeActions(allowsFullSwipe: false, content: {
                                Button(role: .destructive) {
                                    Task {
                                        await viewModel.deleteLocation(location: item)
                                    }
                                } label: {
                                    Text(viewModel.mainDelete)
                                }
                            })
                        }
                    }
                }
            }
            .navigationTitle(viewModel.mainTitle)
            .searchable(text: $viewModel.searchText)
            .alert(viewModel.errorDescription, isPresented: $viewModel.showAlert) {
                Button(viewModel.mainTryAgain, role: .cancel) {
                    Task {
                        await viewModel.loadLocations()
                    }
                }
            }
            .task {
                await viewModel.loadLocations()
            }
            .refreshable {
                await viewModel.refreshLocations()
            }
        }
        .loadable($viewModel.isLoading)
        .background(Constants.ViewTraits.background)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: .init())
    }
}
