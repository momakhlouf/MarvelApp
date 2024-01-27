//
//  EmptyDataView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 27/01/2024.
//

import SwiftUI

struct EmptyDataView: View {
    @Binding var searchText: String
    var body: some View {
        VStack{
            Spacer()
            Image(systemName: "exclamationmark.magnifyingglass")
                .foregroundStyle(.gray)
                .font(.system(size: 90, weight: .medium))
            
            Text("No Results for ''\(searchText)'' ")
                .foregroundStyle(.gray)
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    EmptyDataView(searchText: .constant(""))
}
