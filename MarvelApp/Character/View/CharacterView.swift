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
            ScrollView{
                LazyVStack(spacing: 0){
                    ForEach(viewModel.characters){ character in
                        CharacterRowView(character: character)
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Image(.marvelLogo)
                        .resizable()
                        .frame(width: 120, height: 40)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SearchView(viewModel: DependencyProvider.searchViewModel)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20).bold())
                            .foregroundStyle(.redMarvel)
                    }
                }
            }
        }
    }
}

#Preview {
    CharacterView(viewModel: DependencyProvider.characterViewModel)
}
