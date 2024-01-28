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
    @Published var isLoadMore: Bool = true
    let limit = 20
    var page = 0
    var service: ServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(service: ServiceProtocol){
        self.service = service
        fetchCharacters()
    }
    
    
    func fetchCharacters(){
      // state = .isLoading
        service.fetchCharacters(page: page, limit: limit)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(_):
                    self.state = .failed(error: APIError.unknown)
                }
            } receiveValue: { [weak self] returnedCharacters in
                for character in returnedCharacters.data.results {
                    self?.characters.append(character)
                }
                self?.state = .loaded
                self?.page += 1
               // print("\(self?.characters.count) - \(returnedCharacters.data.offset + returnedCharacters.data.count) - \(returnedCharacters.data.total)")
                self?.isLoadMore = (returnedCharacters.data.offset + returnedCharacters.data.count < returnedCharacters.data.total) ? true : false
            }
            .store(in: &cancellables)
    }
}
