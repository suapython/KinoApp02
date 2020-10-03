//
//  MovieAPI.swift
//  Kino_App02
//
//  Created by jose francisco morales on 26/09/2020.
//

import Foundation
import Combine

// MARK:  URL components
 
extension APIClient {
    
    
    struct  urlAPI {
        static let scheme = "https"
        static let host = "api.themoviedb.org"
        static let key = "499287cd9f6093b56e707167eb586d64"
    }
    
    func makeURLComponents(path: String, queries: [String: String]?) -> URLComponents {
        var components = URLComponents()
        components.scheme = urlAPI.scheme
        components.host = urlAPI.host
        components.path = "/3/" + path
        
        components.queryItems = [URLQueryItem(name: "api_key", value: urlAPI.key),
                                 URLQueryItem(name: "language", value: Locale.preferredLanguages[0])]
        if let queries = queries {
            for (_, value) in queries.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        
        return components
    }
}

// MARK: - fetchMovie

extension APIClient {
   
    
    func fetchMovie(with components: URLComponents
    ) -> AnyPublisher<MovieResponse, ErrorType> {
        
    return fetch(with: components)
    }
    
    
    func fetchPerson(with components: URLComponents
    ) -> AnyPublisher<PersonResponse, ErrorType> {
        
    return fetch(with: components)
    }
    
}
        
