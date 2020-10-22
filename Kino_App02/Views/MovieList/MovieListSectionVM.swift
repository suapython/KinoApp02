//
//  MovieVM.swift
//  Kino_App02
//
//  Created by jose francisco morales on 23/09/2020.
//

import Foundation
import Combine

class MovieListSectionVM: ObservableObject {
    
    @Published var category: CategoryEnum  
    @Published var movies: [MovieRowVM] = []
    
    private var disposables = Set<AnyCancellable>()
     
    init(category: CategoryEnum) {
        self.category = category
        getMovieList(category: category)
    }
    
}

extension MovieListSectionVM {
    
    
    func getMovieList(category: CategoryEnum) {
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

