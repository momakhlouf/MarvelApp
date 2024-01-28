//
//  GalleryView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI

struct GalleryView: View {
    @Environment(\.dismiss) var dismiss
    let comics: [Sections]
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(systemName: "xmark")
                    .padding(12)
                    .background{
                        Color.gray.opacity(0.3)
                            .cornerRadius(8)
                    }
                    .padding(20)
                    .onTapGesture {
                        dismiss()
                    }
            }
            ScrollView(.horizontal){
                HStack{
                    ForEach(comics){ comic in
                        VStack(alignment: .center){
                            AsyncImage(url: URL(string: comic.image)) { image in
                                image
                            } placeholder: {
                                Rectangle()
                                    .foregroundStyle(.gray.opacity(0.3))
                            }
                            .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height - 100)
                            Text(comic.title ?? "")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GalleryView(comics: [])
}
