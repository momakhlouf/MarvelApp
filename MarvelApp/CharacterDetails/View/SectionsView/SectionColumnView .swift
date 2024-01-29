//
//  SectionColumnView .swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI

struct SectionColumnView: View {
    let section: CharacterDetails
    var body: some View {
        VStack(spacing: 2){
            ImageView(urlString: section.image, width: 110, height: 160)
            Text(section.title ?? "")
                .font(.caption)
                .frame(width: 100)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    SectionColumnView(section: CharacterDetails.mockCharacterDetails())
}
