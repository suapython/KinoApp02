//
//  TabView.swift
//  Kino_App02
//
//  Created by jose francisco morales on 27/09/2020.
//

import SwiftUI

struct MenuTabView: View {
    @State private var selectedView: Int = 1
  var body: some View {
        TabView(selection: $selectedView) {
           MovieListContent()
              .tabItem({
                 Image(systemName: "film")
                 Text("Lists")
              }).font(.body).tag(0)
            SearchView(viewModel: SearchVM())
              .tabItem({
                 Image(systemName: "magnifyingglass")
                 Text("Search")
              }).font(.body).tag(1)
        }.font(.title)
     }
  }


struct MenuTabView_Previews: PreviewProvider {
    static var previews: some View {
        MenuTabView()
    }
}
