//
//  SearchView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    @FocusState var isFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
                    TextField("Search...", text: $viewModel.searchText)
                        .focused($isFocused, equals: true)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isFocused = true
                            }
                        }
                }
                .frame(height: 40)
                .padding(.horizontal, 5)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(.redMarvel)
            }
            .padding(.horizontal)
            ScrollView{
                LazyVStack(spacing: 0){
                    ForEach(viewModel.filteredCharacters){ character in
                        SearchRowView(character: character)
                    }
                }
                .overlay{
                    #warning("make a no result view , and handle the network loading")
                        Text("no ..dataaaa.")
                            .opacity(viewModel.checkNoSearchResult ? 1 : 0)
                }
            }
        }
    }
}

#Preview {
    SearchView(viewModel: DependencyProvider.searchViewModel)
}
