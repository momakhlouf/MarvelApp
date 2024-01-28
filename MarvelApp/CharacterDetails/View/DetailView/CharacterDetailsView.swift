//
//  CharacterDetailsView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    let character: Character
    var body: some View {
        ScrollView{
            ImageView(urlString: character.image, width: .infinity, height: UIScreen.main.bounds.height * 0.5 )
                .overlay(alignment: .topLeading) {
                    BackButton()
                }
            VStack(alignment: .leading, spacing: 20){
                CharacterInfoView(character: character)
                ComicsSectionView(character: character)
                
                VStack(alignment: .leading, spacing: 5){
                    SectionTitle(title:"RELATED LINKS")
                    VStack(spacing: 20){
                        ForEach(character.urls, id: \.self){ url in
                            LinksView(urlElement: url)
                        }
                    }
                }
            }
            .padding([.horizontal, .top],5)
            .padding(.bottom, 50)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterDetailsView(character: .mockCharacter())
}


