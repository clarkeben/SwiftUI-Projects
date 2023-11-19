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
                HStack(spacing: 10) {
                    FilterButton(title: "Rank") {
                        
                    }
                    
                    FilterButton(title: "Volume", showFilterDirection: false) {
                        
                    }
                    
                    Spacer()
                    
                    DropDownPicker(selectedCurrency: $viewModel.currencyCode) {
                        Task {
                            try await viewModel.fetchCoin()
                        }
                    }
                }
                .padding([.leading, .trailing], 10)
                //.background(Color("lightGrey"))
                
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
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .background(.clear)
                                    .foregroundColor(.white)
                                    .padding(
                                        EdgeInsets(
                                            top: 5,
                                            leading: 10,
                                            bottom: 5,
                                            trailing: 10
                                        )
                                    )
                            )
                        }.listRowSeparator(.hidden)
                    }.listStyle(.grouped)
                }
            }
            .navigationTitle("All Coins")
            .searchable(text: $viewModel.searchedText)
            .accentColor(.black)
        }
    }
}

#Preview {
    CoinsView()
}
