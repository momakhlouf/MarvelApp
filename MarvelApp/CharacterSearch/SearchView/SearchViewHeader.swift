//
//  SearchViewHeader.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 27/01/2024.
//

import SwiftUI

struct SearchViewHeader: View {
    @FocusState var isFocused: Bool
    @Binding var searchText: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                TextField("Search...", text: $searchText)
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
                searchText = ""
            }
            .foregroundStyle(.redMarvel)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchViewHeader( searchText: .constant(""))
}
