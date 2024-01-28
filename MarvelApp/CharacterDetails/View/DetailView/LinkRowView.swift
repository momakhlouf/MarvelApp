//
//  LinkRowView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI

struct LinkRowView: View {
    let linkTitle: String
    let url: URL
    var body: some View {
        Link(destination: {
            url
        }(), label: {
            HStack{
               Text(linkTitle)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(.horizontal)
            .foregroundStyle(Color.primary)
        })
    }
}

