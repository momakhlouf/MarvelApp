//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import Foundation
import Combine

class CharacterViewModel: ObservableObject{
    @Published var characters : [Character] = []
    @Published var state: ResultState = .isLoading
    var service: ServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(service: ServiceProtocol){
        self.service = service
        fetchCharacters()
    }
    
#warning("pagination")

    
    func fetchCharacters(){
        state = .isLoading
        service.fetchCharacters()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { [weak self] returnedCharacters in
//                self?.characters = returnedCharacters.data.results
                self?.state = .loaded(content: returnedCharacters.data.results)
            }
            .store(in: &cancellables)

    }
}
