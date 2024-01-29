//
//  CharacterSectionsViewModel.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import Foundation
import Combine

class CharacterDetailsViewModel: ObservableObject{
    
    @Published var comics: [CharacterDetails] = []
    @Published var series: [CharacterDetails] = []
    @Published var events: [CharacterDetails] = []

    @Published var state: ResultState = .isLoading
    @Published var showComicsGallery: Bool = false
    @Published var showSeriesGallery: Bool = false
    @Published var showEventsGallery: Bool = false


    var service: ServiceProtocol
    var cancellables = Set<AnyCancellable>()

    init(service: ServiceProtocol){
        self.service = service
    }
    
    func fetchComics(for characterID: Int){
        service.fetchCharacterRelatedImages(for: characterID, sectionType: .comics)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    self.state = .failed(error.localizedDescription )
                }
            } receiveValue: { [weak self] returned in
                self?.comics = returned.data.results
            }
            .store(in: &cancellables)
    }
    
    func fetchSeries(for characterID: Int){
        service.fetchCharacterRelatedImages(for: characterID, sectionType: .series)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    self.state = .failed(error.localizedDescription )
                }
            } receiveValue: { [weak self] returned in
                self?.series = returned.data.results
            }
            .store(in: &cancellables)
    }
    
    func fetchEvents(for characterID: Int){
        service.fetchCharacterRelatedImages(for: characterID, sectionType: .events)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    self.state = .failed(error.localizedDescription )
                }
            } receiveValue: { [weak self] returned in
                self?.events = returned.data.results
            }
            .store(in: &cancellables)
    }
}
