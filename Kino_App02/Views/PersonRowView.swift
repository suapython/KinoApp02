//
//  MovieRowView.swift
//  Kino_App02
//
//  Created by jose francisco morales on 01/10/2020.
//

import SwiftUI

struct PersonRowView: View {
    private let viewModel: PersonRowVM
    
    init(viewModel: PersonRowVM) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.headline)
                Text(viewModel.knownForDepartment)
                    .font(.subheadline)
            }
        }
    }
}

 

struct PersonRowView_Previews: PreviewProvider {
    static var previews: some View {
        PersonRowView(viewModel: PersonRowVM(person: examplePerson1) )
    }
}
