//
//  MovieVM.swift
//  Kino_App02
//
//  Created by jose francisco morales on 23/09/2020.
//

import Foundation
import Combine

class MovieVM: ObservableObject {
    
    @Published var movies: [Movie] = []
    private var disposables = Set<AnyCancellable>()
     
    
    let urlComponents = makeURLComponents(path: "movie/popular", queries: [:])
    
    init() {
        print("init")
        getMovies()
    }
    
}

extension MovieVM {
    
    func getMovies() {
        print("get movies")
        APIClient().fetchMovie(with: urlComponents)
            .map { response in
               // self.movies = response.movies
                print("movies: \(self.movies)")
            }
            .receive(on: DispatchQueue.main)
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
                guard let self = self else { return }
                print("ok", response )
            })
           .store(in: &disposables)
    }
    
}

