//
//  SearchViewModel.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject{
    @Published var filteredCharacters : [Character] = []
    @Published var searchText : String = ""
    @Published var state: ResultState = .isLoading
    var cancellables = Set<AnyCancellable>()
    var service: ServiceProtocol
    
    
    init(service: ServiceProtocol){
        self.service = service
        $searchText
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.state = .isLoading
                self?.filteredCharacters = [] // for removing data if searchText is empty
                self?.fetchCharacters(for: text)
            }
            .store(in: &cancellables)
    }
    
    var checkNoSearchResult: Bool{
        filteredCharacters.isEmpty && !searchText.isEmpty
    }
    
    func fetchCharacters(for searchText: String){
        guard !searchText.isEmpty else{
            return
        }
      //  state = .isLoading
        service.fetchCharacters(for: searchText)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case.finished:
                    break
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { [weak self] returnedCharacter in
                self?.filteredCharacters = returnedCharacter.data.results
                 
                self?.state = .loaded(content: returnedCharacter.data.results)
                
            }
            .store(in: &cancellables)

    }
    
    
}
