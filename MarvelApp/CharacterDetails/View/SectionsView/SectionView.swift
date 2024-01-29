//
//  SectionView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 29/01/2024.
//

import SwiftUI

struct SectionView: View{
    let title: String
    let items: [CharacterDetails]
    @Binding var showGallery: Bool
    @State private var selectedImageIndex: Int?

    var body: some View{
        VStack(alignment: .leading){
            if !items.isEmpty{
                SectionTitle(title:title)
            }
            ScrollView(.horizontal){
                LazyHStack(alignment: .top){
                    ForEach(items.indices, id: \.self){ index in
                        SectionColumnView(section: items[index])
                            .onTapGesture {
                                selectedImageIndex = index
                                withAnimation(.easeInOut){
                                    showGallery.toggle()
                                }
                            }
                    }
                }
                .fullScreenCover(isPresented: $showGallery, content: {
                    GalleryView(characterDetails: items, selectedImageIndex: selectedImageIndex ?? 0)
                })
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    SectionView(title: "", items: [], showGallery: .constant(true))
}
