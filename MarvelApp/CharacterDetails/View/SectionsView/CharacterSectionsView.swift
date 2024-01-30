//
//  ComicsSectionView.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import SwiftUI

struct CharacterSectionsView: View {
    @StateObject var viewModel : CharacterDetailsViewModel
    let character: Character
    
    init(viewModel: CharacterDetailsViewModel , character: Character) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.character = character
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 40){
            SectionView(title: "COMICS", items: viewModel.comics, showGallery: $viewModel.showComicsGallery)
            SectionView(title: "SERIES", items: viewModel.series, showGallery: $viewModel.showSeriesGallery)
            SectionView(title: "EVENTS", items: viewModel.events, showGallery: $viewModel.showEventsGallery)
        }
        .onAppear{
            viewModel.fetchComics(for: character.id)
            viewModel.fetchSeries(for: character.id)
            viewModel.fetchEvents(for: character.id)
        }
    }
}

#Preview {
    CharacterSectionsView(viewModel:DependencyProvider.characterSectionsViewModel, character: Character.mockData.first!)
}


