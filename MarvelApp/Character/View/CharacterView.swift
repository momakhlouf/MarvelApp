//
//  CharacterView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import SwiftUI

struct CharacterView: View {
    @StateObject var viewModel: CharacterViewModel
    
    init(viewModel: CharacterViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        NavigationStack{
            switch viewModel.state {
            case .isLoading:
                ProgressView()
                
            case .failed(let error):
                ErrorView(error: error){
                    viewModel.fetchCharacters()
                }
                
            case .loaded:
                ScrollView{
                    LazyVStack(spacing: 0){
                        ForEach(viewModel.characters){ character in
                            NavigationLink {
                                CharacterDetailsView(character: character)
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                CharacterRowView(character: character)

                            }

                        }
                        if viewModel.isLoadMore{
                            LoadMoreView{
                                viewModel.fetchCharacters()
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .principal) {
                     marvelLogo
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                     searchButton
                    }
                }
            }
        }
    }
}

#Preview {
    CharacterView(viewModel: DependencyProvider.characterViewModel)
}

extension CharacterView{
    var marvelLogo: some View{
        Image(.marvelLogo)
            .resizable()
            .frame(width: 120, height: 40)
    }
    
    var searchButton: some View{
        NavigationLink {
            SearchView(viewModel: DependencyProvider.searchViewModel)
                .navigationBarBackButtonHidden(true)
        } label: {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 20).bold())
                .foregroundStyle(Color.theme.customRed)
        }
    }
}
