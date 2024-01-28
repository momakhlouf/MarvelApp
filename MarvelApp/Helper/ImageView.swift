//
//  ImageView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import SwiftUI

struct ImageView: View {
    let urlString: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View{
        // we can use kingfisher or SDWebImage
        AsyncImage(url: URL(string: urlString)) { image in
            image
                .resizable()
        } placeholder: {
            Rectangle()
                .foregroundStyle(.gray.opacity(0.2))
                .overlay{
                    ProgressView()
                }
        }
        .frame(maxWidth: width)
        .frame(height: height)
    }
    
}

#Preview {
    ImageView(urlString: "", width: 1, height: 1)
}
