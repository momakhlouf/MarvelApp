//
//  SearchView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        NavigationStack {
            VStack{
//                SearchViewHeader(searchText: $viewModel.searchText)
                switch viewModel.state {
                case .isLoading:
                    VStack{
                        Spacer()
                        if !viewModel.searchText.isEmpty{
                            ProgressView()
                        }
                        Spacer()
                        
                    }
                case .failed(let error):
                    ErrorView(error: error) {
                        viewModel.loadMore()
                    }
                case .loaded:
                    if !viewModel.noSearchResult{
                        ScrollView{
                            LazyVStack(spacing: 1){
                                ForEach(viewModel.filteredCharacters){ character in
                                    NavigationLink {
                                        CharacterDetailsView(character: character)
                                            .navigationBarBackButtonHidden(true)
                                    } label: {
                                        SearchRowView(character: character)
                                    }
                                }
                                if viewModel.isLoadMore{
                                    LoadMoreView{
                                        viewModel.loadMore()
                                    }
                                }
                            }
                        }
                    }else{
                        EmptyDataView(searchText: $viewModel.searchText)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    SearchViewHeader(searchText: $viewModel.searchText)
                }
            }
        }
    }
}

#Preview {
    SearchView(viewModel: DependencyProvider.searchViewModel)
}

