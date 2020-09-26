//
//  ContentView.swift
//  Kino_App02
//
//  Created by jose francisco morales on 22/09/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      MoviesView()
            .onAppear {
                let urlComponents = makeURLComponents(path: Endpoint.popular.path(), queries: [:])
                print("url:", urlComponents )
                let components = URLComponents(string: "https://twitter.com/twannl/photo.png?width=200&height=200")!
                print("url2:", components.url! )
        
            
            }
            .padding()
           
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
