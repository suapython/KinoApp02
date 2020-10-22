//
//  MoviesView.swift
//  Kino_App02
//
//  Created by jose francisco morales on 24/09/2020.
//

import SwiftUI

struct MovieListSection: View {
    
    @ObservedObject var viewModel: MovieListSectionVM
    
    var body: some View {
        VStack{
        List(viewModel.movies) { movieRowVM in
            MovieRowView(viewModel: movieRowVM)
        }
        }
    }
}

struct MovieListSection_Previews: PreviewProvider {
    static var previews: some View {
        MovieListSection(viewModel: MovieListSectionVM(category: .popular))
    }
}
 
