//
//  Movie.swift
//  Kino_App02
//
//  Created by jose francisco morales on 22/09/2020.
//

import Foundation

// MARK:   Models

struct MovieResponse: Decodable {
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

 
