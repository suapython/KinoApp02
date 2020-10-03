//
//  MoviesView.swift
//  Kino_App02
//
//  Created by jose francisco morales on 24/09/2020.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var viewModel: MovieListVM
    
    var body: some View {
        VStack{
        List(viewModel.movies) { movieRowVM in
            MovieRowView(viewModel: movieRowVM)
        }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: MovieListVM(category: .popular))
    }
}
 
