//
//  SectionColumnView .swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI

struct SectionColumnView: View {
    let image: String
    let title: String
    var body: some View {
        VStack{
            ImageView(urlString: image, width: 100, height: 150)
                .onTapGesture {
                  //  showFullImage = true
                }
//                .fullScreenCover(isPresented: $showFullImage, content: {
//                    GalleryView(comics: viewModel.comics)
//                })
            Text(title)
                .font(.caption)
                .frame(width: 90)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SectionColumnView(image: "", title: "")
}
