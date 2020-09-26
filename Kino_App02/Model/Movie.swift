//
//  Movie.swift
//  Kino_App02
//
//  Created by jose francisco morales on 22/09/2020.
//

import Foundation


struct Movie: Decodable, Identifiable {
    var id = UUID()
    let movieId: Int
    let originalTitle: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case originalTitle = "original_title"
        case title
    }
}

