//
//  ContentView.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 31/10/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //MARK: - Body
    var body: some View {
        TabView {
            CoinsView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            FavouritesView()
                .tabItem {
                    Label("Faviroutes", systemImage: "heart")
                }
        }.accentColor(.black)
    }
}

#Preview {
    ContentView()
}
