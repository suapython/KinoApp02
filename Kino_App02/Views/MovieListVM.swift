//
//  MovieVM.swift
//  Kino_App02
//
//  Created by jose francisco morales on 23/09/2020.
//

import Foundation
import Combine

class MovieListVM: ObservableObject {
    
    @Published var category: Endpoint  
    @Published var movies: [MovieRowVM] = []
    
    private var disposables = Set<AnyCancellable>()
     
    init(category: Endpoint) {
        self.category = category
    }
    
}

extension MovieListVM {
    
    func getMovieLists(category: Endpoint) {
        print("endpoint \(category.title())")
        let urlComponents = APIClient().makeURLComponents(path: category.path(), queries: [:])
        getMoviesUrl(urlComponents: urlComponents)
            
    }
    
    func getMoviesUrl(urlComponents: URLComponents) {
         
        APIClient().fetchMovie(with: urlComponents)
            .map { response in
                response.movies.map(MovieRowVM.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    print("failure")
                case .finished:
                    print("finished")
                  break
                }
              },
              receiveValue: { [weak self] value in
                guard let self = self else { return  }
                self.movies = value
                print("value", self.movies)
            })
           .store(in: &disposables)
        
    }
    
    
    
}

