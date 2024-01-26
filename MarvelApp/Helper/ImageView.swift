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
       // .frame(width: width, height: height)
       // why I get Invalid frame dimension (negative or non-finite) ?

    }
    
}

#Preview {
    ImageView(urlString: "", width: 1, height: 1)
}
