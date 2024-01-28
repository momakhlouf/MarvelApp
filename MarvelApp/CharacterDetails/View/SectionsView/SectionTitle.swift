//
//  SectionTitle.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI

struct SectionTitle: View {
    let title : String
    var body: some View {
        Text(title)
            .foregroundStyle(Color.theme.customRed)
            .font(.caption)
            .fontWeight(.heavy)
    }
}

#Preview {
    SectionTitle(title: "")
}
