//
//  SearchView.swift
//  Kino_App02
//
//  Created by jose francisco morales on 27/09/2020.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchVM
    
    var statesMenu = ["movie", "person"]

    init(viewModel: SearchVM) {
      self.viewModel = viewModel
    }

    
    
    var body: some View {
        NavigationView {
          List {
            
           // picker
            
            searchField
            
            if viewModel.movies.isEmpty {
              emptySection
            } else {
              movieSection
            }
          }
          .listStyle(GroupedListStyle())
          .navigationBarTitle("Search")
          }
        }
}

private extension SearchView {
    
    var picker: some View {
        Picker("", selection: $viewModel.queryOption) {
            ForEach(statesMenu, id: \.self) { value in
                Text(value)
            }
        }.labelsHidden()
        .pickerStyle(SegmentedPickerStyle())
    }
    
    var searchField: some View {
        HStack(alignment: .center) {
            TextField("e.g. Zellig", text: $viewModel.query)
        }
    }
    
    var movieSection: some View {
        Section {
            //VStack {
                //Text("\(viewModel.movies.count)")
                ForEach(viewModel.movies) {movie in
                    Text(movie.title)
               // }
            }
        }
    }
    
    
    var emptySection: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
    }
    
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchVM())
    }
}
