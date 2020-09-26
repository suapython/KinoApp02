//
//  APIservice.swift
//  Kino_App02
//
//  Created by jose francisco morales on 22/09/2020.
//

import Foundation
import Combine



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


