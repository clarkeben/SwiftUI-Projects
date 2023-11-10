//
//  ContentView.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 31/10/2023.
//

import SwiftUI

struct ContentView: View {
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
        }
    }
}

#Preview {
    ContentView()
}
