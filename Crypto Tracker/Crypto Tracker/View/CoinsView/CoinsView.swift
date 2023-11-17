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
                                    Text(coin.price, format: .currency(code: viewModel.currencyCode.rawValue))
                                }
                            }.padding([.top, .bottom], 5)
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
