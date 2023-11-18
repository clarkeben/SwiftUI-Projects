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
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $viewModel.currencyCode) {
                    ForEach(NetworkManager.Currency.allCases, id: \.self) { currency in
                        Text(currency.rawValue)
                    }
                }.onChange(of: viewModel.currencyCode) {
                    Task {
                        try await viewModel.fetchCoin()
                    }
                }
                
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
                        ForEach(viewModel.searchedCoinResults) { coin in
                            CoinRowItem(rank: coin.rank, 
                                        imageURL: coin.image,
                                        name: coin.name,
                                        symbol: coin.symbol,
                                        marketCap: coin.marketCap,
                                        price: coin.price,
                                        currency: viewModel.currencyCode.rawValue,
                                        priceChange: coin.priceChange,
                                        pricePercentageChange: coin.priceChangePercentage)
                        }.listRowSeparator(.hidden)
                    }.listStyle(.insetGrouped)
                }
            }
            .navigationTitle("All Coins")
            .searchable(text: $viewModel.searchedText)
        }
    }
}

#Preview {
    CoinsView()
}
