//
//  BackButton.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
            Image(systemName: "chevron.left")
                .font(.system(size: 30).bold())
                .foregroundStyle(.white)
                .onTapGesture{
                    dismiss()
                }
                .padding(.vertical ,50)
                .padding(.horizontal, 25)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.5), radius: 12, x: 0, y: 6)
    }
}

#Preview {
    BackButton()
}
