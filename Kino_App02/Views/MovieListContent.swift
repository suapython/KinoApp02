//
//  MovieLists.swift
//  Kino_App02
//
//  Created by jose francisco morales on 27/09/2020.
//

import SwiftUI

struct MovieListContent: View {
    var sections: [Endpoint] = [.popular,.topRated,.upcoming,.nowPlaying,.trending]
    
    var body: some View {
        VStack{
            ForEach(sections, id: \.self) { section in
                Section(header: Text(section.title())) {
                MovieListView(viewModel: MovieListVM(category: section))
                        .padding()
                }
            }
        }
    }
}

struct MovieListContent_Previews: PreviewProvider {
    static var previews: some View {
        MovieListContent()
    }
}
