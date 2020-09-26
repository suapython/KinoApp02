//
//  MoviesView.swift
//  Kino_App02
//
//  Created by jose francisco morales on 24/09/2020.
//

import SwiftUI

struct MoviesView: View {
    
    @ObservedObject var viewModel: MovieVM
    
    var body: some View {
        VStack{
        List(viewModel.movies) { movie in
            HStack {
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.originalTitle)
                        .font(.subheadline)
                }
            }
        }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(viewModel: MovieVM(category: .popular))
    }
}
