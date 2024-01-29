//
//  GalleryView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI

struct GalleryView: View {
    @Environment(\.dismiss) var dismiss
    @State var index = 0
    let characterDetails: [CharacterDetails]
    let selectedImageIndex: Int
    
    var body: some View {
        VStack{
            dismissButton
            TabView(selection: $index){
                ForEach(characterDetails.indices, id: \.self) { imageIndex in
                    VStack{
                        AsyncImage(url: URL(string:characterDetails[imageIndex].image)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .padding(30)
                            
                        } placeholder: {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        
                        Text(characterDetails[imageIndex].title ?? "")
                            .font(.subheadline)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .tag(imageIndex)
                    .onAppear {
                        index = selectedImageIndex
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            Text(" \(index + 1) /\(characterDetails.count)")
                .font(.caption)
                .foregroundStyle(.gray)
                .padding()
            
        }
    }
}


#Preview {
    GalleryView(characterDetails: [], selectedImageIndex: 0)
}

extension GalleryView{
    var dismissButton: some View{
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
    }
}
