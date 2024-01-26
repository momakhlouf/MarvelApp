//
//  CharacterRowView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import SwiftUI

struct CharacterRowView: View {
    let character : Character
    var body: some View {
        ZStack(alignment: .bottomLeading){
            ImageView(urlString: character.image, width: .infinity, height: 200)
            BackgroundTextShape()
                .overlay(alignment: .center, content: {
                    Text(character.name)
                        .font(.subheadline.bold())
                        .foregroundStyle(.black)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal, 20)
                })
                .padding(8)
        }
    }
}

#Preview {
    CharacterRowView(character: Character.mockCharacter())
}
