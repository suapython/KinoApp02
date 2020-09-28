//
//  MovieLists.swift
//  Kino_App02
//
//  Created by jose francisco morales on 27/09/2020.
//

import SwiftUI

struct MovieLists: View {
    var sections: [Endpoint] = [.popular,.topRated,.upcoming,.nowPlaying,.trending]
    
    var body: some View {
        VStack{
            ForEach(sections, id: \.self) { section in
                Section(header: Text(section.title())) {
        
        MoviesView(viewModel: MovieVM(category: section))
            .padding()
                }
            }
        }
    }
}

struct MovieLists_Previews: PreviewProvider {
    static var previews: some View {
        MovieLists()
    }
}
