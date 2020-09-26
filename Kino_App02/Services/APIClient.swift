//
//  APIservice.swift
//  Kino_App02
//
//  Created by jose francisco morales on 22/09/2020.
//

import Foundation
import Combine


// MARK:  URL components

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
    print("urL_______", components.url)
  if let queries = queries {
        for (_, value) in queries.enumerated() {
            components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
        }
    }
   
  return components
}

// MARK:  API client

class APIClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
}


extension APIClient {
    
    func fetch<T>(
        with components: URLComponents
    ) -> AnyPublisher<T, ErrorType> where T: Decodable {
    
        guard let url = components.url else {
            let error = ErrorType.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}


// MARK:  JSON decode


func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, ErrorType> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}

enum ErrorType: Error {
    case parsing(description: String)
    case network(description: String)
}


// MARK: - fetchMovie

extension APIClient {
    
    func fetchMovie(with components: URLComponents
    ) -> AnyPublisher<MovieResponse, ErrorType> {
        
    return fetch(with: components)
    }
}
        
