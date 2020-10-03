//
//  Movie.swift
//  Kino_App02
//
//  Created by jose francisco morales on 22/09/2020.
//

import Foundation

struct PersonResponse: Decodable {
    let people: [Person]

    enum CodingKeys: String, CodingKey {
        case people = "results"
    }
}

struct Person: Decodable, Identifiable {
   
    var id = UUID()
    let personId: Int
    let name: String
    let knownForDepartment: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        
        case personId = "id"
        case name
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        
    }
    
}

  
 
