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
  @Published var queryOption: String = "movie"

  @Published var movies: [Movie] = []


  private var disposables = Set<AnyCancellable>()

    init() {
     
    
    $query
      .dropFirst(1) // to avoid the first call with empty string
      .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
      //  .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .removeDuplicates()
      .sink(receiveValue: getMovies(query:))
      .store(in: &disposables)
        
     getMovies(query: query)
  }

  
  
}


 
extension SearchVM {
    
    func getMovies(query: String) {
        print("path ______  ","search/" + queryOption)
        let urlComponents = makeURLComponents(path: "search/movie", queries:  ["query": query])
        print("get movies")
        APIClient().fetchMovie(with: urlComponents)
            .map { response in
               self.movies = response.movies
                print("movies: \(self.movies)")
            }
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    print("failure")
                  self.movies = []
                case .finished:
                    print("finished")
                  break
                }
              },
              receiveValue: { [weak self] response in
                guard self != nil else { return }
                print("ok", response )
            })
           .store(in: &disposables)
    }
    
}


