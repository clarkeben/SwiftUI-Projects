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
                        ForEach(viewModel.coins) { coin in
                            HStack {
                                Text("\(coin.rank)")
                                
                                AsyncImage(url: URL(string: coin.image)) { image in
                                    image.resizable()
                                } placeholder: {
                                    
                                }.frame(width: 40, height: 40, alignment: .center)
                                
                                VStack {
                                    Text("\(coin.name) (\(coin.symbol))")
                                }
                                
                                Spacer()
                                
                                VStack {
                                    Text(coin.price, format: .currency(code: "USD"))
                                }
                            }.padding([.top, .bottom], 5)
                        }.listRowSeparator(.hidden)
                    }.listStyle(.insetGrouped)
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
