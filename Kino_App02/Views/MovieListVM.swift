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
        getMovieList(category: category)
    }
    
}

extension MovieListVM {
    
    
    func getMovieList(category: Endpoint) {
        let urlComponents = APIClient().makeURLComponents(path: category.path(), queries: [:])
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
    
    
    
     
    
    
    
}

