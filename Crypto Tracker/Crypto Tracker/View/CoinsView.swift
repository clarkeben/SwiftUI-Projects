//
//  CoinsView.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 09/11/2023.
//

import SwiftUI

struct CoinsView: View {
    
    //MARK: - Properties
    @StateObject var viewModel = CoinViewModel()
    
    @State private var searchedCoin = ""
    @State private var searchIsActive = false

    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.coins.isEmpty {
                    ProgressView {
                        Label {
                            Text("Loading")
                        } icon: {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                        }

                    }
                } else {
                    List {
                        ForEach(viewModel.coins) { coins in
                            Text(coins.name)
                        }
                    }
                }
            }
            .navigationTitle("All Coins")
            .searchable(text: $searchedCoin, isPresented: $searchIsActive)
        }
    }
    
//    var searchResults: [Coin] {
//        return viewModel.coins.filter { $0.name.lowercased() .contains(searchedCoin) }
//    }
}

#Preview {
    CoinsView()
}
