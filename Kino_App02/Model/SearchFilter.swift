//
//  SearchField.swift
//  Kino_App02
//
//  Created by jose francisco morales on 03/10/2020.
//

import Foundation

enum SearchFilter: CaseIterable, Hashable {
    case movie, person
    
    func path() -> String  {
        switch self {
        case .movie: return "movie"
        case .person: return "person"
        }  }
    
     
     
    
    
}
