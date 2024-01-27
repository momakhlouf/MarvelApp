//
//  LoadMoreView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 27/01/2024.
//

import SwiftUI

struct LoadMoreView: View {
    var loadMore : () -> ()
    var body: some View {
        Rectangle()
            .frame(height: 70)
            .foregroundStyle(.gray.opacity(0.2))
            .overlay{
                ProgressView()
            }
            .onAppear{
               loadMore()
            }
    }
}

#Preview {
    LoadMoreView(loadMore: {})
}
