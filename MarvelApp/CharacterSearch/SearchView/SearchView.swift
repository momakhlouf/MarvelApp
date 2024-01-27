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
        VStack{
            SearchViewHeader(searchText: $viewModel.searchText)
            switch viewModel.state {
            case .isLoading:
                VStack{
                Spacer()
                ProgressView()
                Spacer()
                }
            case .failed(let error):
                Text(error.localizedDescription)
            case .loaded(_):
                if !viewModel.checkNoSearchResult{
                    ScrollView{
                        LazyVStack(spacing: 0){
                            ForEach(viewModel.filteredCharacters){ character in
                                SearchRowView(character: character)
                            }
                        }
                    }
                }else{
                    EmptyDataView(searchText: $viewModel.searchText)
                }
            }
        }
    }
}

#Preview {
    SearchView(viewModel: DependencyProvider.searchViewModel)
}

