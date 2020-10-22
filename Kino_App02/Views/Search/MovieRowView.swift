//
//  MovieRowView.swift
//  Kino_App02
//
//  Created by jose francisco morales on 01/10/2020.
//

import SwiftUI

struct MovieRowView: View {
    private let viewModel: MovieRowVM
    
    init(viewModel: MovieRowVM) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.headline)
                Text(viewModel.originalTitle)
                    .font(.subheadline)
            }
        }
    }
}

 

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView(viewModel: MovieRowVM(movie: exampleMovie1) )
    }
}
