//
//  LinksView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI



struct LinksView: View {
    let urlElement: URLElement
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            switch urlElement.type {
            case .wiki:
                if let url = URL(string: urlElement.url) {
             LinkRowView(linkTitle: "Wiki", url: url)
                }
            case .detail:
                if let url = URL(string: urlElement.url) {
                  LinkRowView(linkTitle: "Detail", url: url)
                }
            case .comiclink:
                if let url = URL(string: urlElement.url) {
                  LinkRowView(linkTitle: "Comiclink", url: url)
                }
            }
        }
    }
}

#Preview {
    LinksView(urlElement: URLElement.init(type: .comiclink, url: ""))
}
