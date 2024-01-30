//
//  SearchRowView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import SwiftUI

struct SearchRowView: View {
    let character: Character
    var body: some View {
        HStack{
            ImageView(urlString: character.image, width: 70, height: 70)
            Text(character.name)
                    .font(.subheadline.bold())
                    .foregroundStyle(Color.primary)
            Spacer()
        }
        
    }
}

#Preview {
    SearchRowView(character: Character.mockData.first!)
}
