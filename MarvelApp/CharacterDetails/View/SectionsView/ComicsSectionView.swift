//
//  ComicsSectionView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI

struct ComicsSectionView: View {
    @StateObject var viewModel : CharacterSectionsViewModel = CharacterSectionsViewModel(service: DependencyProvider.service)
    @State var showFullImage: Bool = false
    let character: Character
    var body: some View {
        VStack(alignment: .leading, spacing: 50){
            VStack(alignment: .leading){
                if !viewModel.comics.isEmpty{
                    SectionTitle(title:"COMICS")
                }
                ScrollView(.horizontal){
                    LazyHStack{
                        ForEach(viewModel.comics){ comic in
                            SectionColumnView(image: comic.image, title: comic.title ?? "")
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            
            VStack(alignment: .leading){
                if !viewModel.series.isEmpty{
                    SectionTitle(title:"SERIES")
                }
                ScrollView(.horizontal){
                    LazyHStack{
                        ForEach(viewModel.series){ series in
                            SectionColumnView(image: series.image, title: series.title ?? "")
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            
            VStack(alignment: .leading){
                if !viewModel.events.isEmpty{
                    SectionTitle(title:"EVENTS")
                }
                ScrollView(.horizontal){
                    LazyHStack{
                        ForEach(viewModel.events){ event in
                            SectionColumnView(image: event.image, title: event.title ?? "")
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .onAppear{
            viewModel.fetchComics(for: character.id)
            viewModel.fetchSeries(for: character.id)
            viewModel.fetchEvents(for: character.id)
        }
    }
}

#Preview {
    ComicsSectionView(character: Character.mockCharacter())
}
