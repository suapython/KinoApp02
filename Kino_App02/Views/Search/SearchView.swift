//
//  SearchView.swift
//  Kino_App02
//
//  Created by jose francisco morales on 27/09/2020.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchVM
    init(viewModel: SearchVM) {
      self.viewModel = viewModel
    }

    
    var body: some View {
        NavigationView {
          List {
            
           picker
            
            searchField
            
            if viewModel.movies.isEmpty {
              emptySection
            } else {
                if viewModel.searchFilter == .movie
                { movieSection} else { personSection }
            }
          }
          .listStyle(GroupedListStyle())
          .navigationBarTitle("Search")
          }
        }
}

private extension SearchView {
    
    var picker: some View {
        Picker("", selection: $viewModel.searchFilter ) {
            ForEach(SearchFilter.allCases , id: \.self) { value in
                Text(value.path() )
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
            VStack {
                ForEach(viewModel.movies, content: MovieRowView.init(viewModel:)).onAppear(){ print(viewModel.people)  }
            }
        }
    }
    
    var personSection: some View {
        Section {
            VStack {
                ForEach(viewModel.people, content: PersonRowView.init(viewModel:)).onAppear(){ print(viewModel.movies)  }
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
