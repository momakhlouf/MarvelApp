//
//  CharacterInfoView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI

struct CharacterInfoView: View {
    let character: Character
    var body: some View {
        VStack(spacing: 15){
            VStack(alignment: .leading, spacing: 5){
                if !character.name.isEmpty{
                    SectionTitle(title:"NAME")
                    Text(character.name)
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            VStack(alignment: .leading, spacing: 5){
                if !character.description.isEmpty{
                    SectionTitle(title:"DESCRIPTION")
                    Text(character.description)
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        //.padding(.bottom, 15)
    }
}

#Preview {
    CharacterInfoView(character: Character.mockCharacter())
}
