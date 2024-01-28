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
    @Published var isLoadMore: Bool = true

    var cancellables = Set<AnyCancellable>()
    var service: ServiceProtocol
    
    let limit = 20
    var page = 0
    
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
    
    var noSearchResult: Bool{
        filteredCharacters.isEmpty && !searchText.isEmpty
    }
    
    func fetchCharacters(for searchText: String){
        guard !searchText.isEmpty else{
            return
        }
      //  state = .isLoading
        service.fetchCharacters(for: searchText, page: page, limit: limit)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case.finished:
                    break
                case .failure(let error):
                    self.state = .failed(error: error as! APIError)
                }
            } receiveValue: { [weak self] returnedCharacters in
                for character in returnedCharacters.data.results {
                    self?.filteredCharacters.append(character)
                }
                self?.state = .loaded
                self?.page += 1
                self?.isLoadMore = (returnedCharacters.data.offset + returnedCharacters.data.count < returnedCharacters.data.total) ? true : false
            }
            .store(in: &cancellables)
    }
    
    func loadMore(){
        fetchCharacters(for: searchText)
    }
    
    
}
