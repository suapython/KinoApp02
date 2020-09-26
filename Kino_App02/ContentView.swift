//
//  ContentView.swift
//  Kino_App02
//
//  Created by jose francisco morales on 22/09/2020.
//

import SwiftUI

struct ContentView: View {
    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
