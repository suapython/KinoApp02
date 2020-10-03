//
//  SearchVM.swift
//  Kino_App02
//
//  Created by jose francisco morales on 27/09/2020.
//

import SwiftUI
import Combine

class SearchVM: ObservableObject, Identifiable {
 
  @Published var query: String = ""
  @Published var searchFilter: SearchFilter = .movie

  @Published var movies: [MovieRowVM] = []
  @Published var people: [PersonRowVM] = []

   
    
  private var disposables = Set<AnyCancellable>()

    init() {
     
    
    $query
      .dropFirst(1) // to avoid the first call with empty string
      .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
        .sink(receiveValue: {value in switch self.searchFilter {
        case .movie:
            self.getMovie(query: value)
        case .person:
            self.getPerson(query: value)} } )
      .store(in: &disposables)
        
  }

  
  
}

extension SearchVM {
    
    
    func getMovie(query: String) {
        let urlComponents = APIClient().makeURLComponents(path: "search/movie", queries:  ["query": query])
        print("url:\(urlComponents)")
        APIClient().fetchMovie(with: urlComponents)
            .map { response in
                response.movies.map(MovieRowVM.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure:
                    print("failure \(completion)")
                    self.movies = []
                case .finished:
                    print("finished")
                  break
                }
              },
              receiveValue: { [weak self] value in
                guard let self = self else { return  }
                self.movies = value
                print("get value \(self.movies)")
            })
           .store(in: &disposables)
        
    }
    
  func getPerson(query: String) {
    let urlComponents = APIClient().makeURLComponents(path: "search/person", queries:  ["query": query])
        print("url:\(urlComponents)")
        APIClient().fetchPerson(with: urlComponents)
            .map { response in
                response.people.map(PersonRowVM.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure:
                    print("failure: \(completion)")
                    self.people = []
                case .finished:
                    print("finished")
                  break
                }
              },
              receiveValue: { [weak self] value in
                guard let self = self else { return  }
                self.people = value
                print("get value \(self.people)")
            })
           .store(in: &disposables)
        
    }
   
    
}


