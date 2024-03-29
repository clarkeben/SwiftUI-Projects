//
//  CoinDetailView.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 20/11/2023.
//

import SwiftUI
import SwiftData
import Charts

struct CoinDetailView: View {
    //MARK: - Properties
    @Environment(\.modelContext) var context
    let coin: Coin
    
    @State var currency: String = "usd"
    @StateObject private var viewModel: PriceTimelineViewModel
    
    @State var coinIsFavourite = false
    @State var favouriteCoins: [FavouriteCoin]
        
    init(coin: Coin, currency: String, favouriteCoins: [FavouriteCoin]) {
        self.coin = coin
        self.currency = currency
        self._viewModel = StateObject(wrappedValue: PriceTimelineViewModel(coin: coin.name.lowercased() , currencyCode: currency))
        self.favouriteCoins = favouriteCoins
    }
        
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(coin.name) Price")
                        .font(.system(size: 10))
                        .fontWeight(.thin)
                       
                    Text(coin.price, format: .currency(code: currency))
                        .fontDesign(.rounded)
                        .bold()
                        .foregroundColor(.black)
                    
                    if coin.priceChangePercentage > 0.0 {
                        HStack(spacing: 0) {
                            Text("Last 24 hours: ")
                            Text("+\(coin.priceChangePercentage * 100, specifier: "%.2f")%")
                                .font(.system(size: 12))
                                .foregroundStyle(.green)
                                .fontWeight(.thin)
                        }
                        
                    } else {
                        HStack(spacing: 0) {
                            Text("Last 24 hours: ")
                                .font(.system(size: 12))
                                .fontWeight(.thin)
                            Text("\(coin.priceChangePercentage * 100, specifier: "%.2f")%")
                                .font(.system(size: 12))
                                .foregroundStyle(.red)
                                .fontWeight(.thin)
                        }
                    }
                }
                
                Spacer()
                
                AsyncImage(url: URL(string: coin.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 60, height: 60, alignment: .center)
                
            }.padding()
            
            Picker("", selection: $viewModel.chartAxisMeasure) {
                ForEach(PriceTimelineViewModel.ChartXAxisMeasure.allCases, id: \.self) {
                    Text($0.description)
                }
            }
            .pickerStyle(.segmented)
            .padding([.horizontal], 10)
            
            Chart {
                ForEach(viewModel.coinData) { dataPoint in
                    LineMark(
                        x: .value("Day", dataPoint.day),
                        y: .value("Cost", dataPoint.cost)
                    )
                }
            }
            .frame(height: 200)
            .padding(.horizontal, 5)
            
            Text("Market Statistics")
                .font(.system(size: 14))
                .fontWeight(.thin)
                .padding([.top, .horizontal])

            CoinDetailGridView(marketCap: coin.marketCap,
                               rank: coin.rank,
                               volume24H: coin.priceChange,
                               priceHigh: coin.high24h,
                               priceLow: coin.low24h, 
                               currencyCode: $currency)
            
            Spacer()
        }
        .navigationTitle("\(coin.name) (\(coin.symbol.uppercased()))")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                let coin = FavouriteCoin(id: coin.id, name: coin.name)
                
                if coinIsFavourite {
                    viewModel.deleteSavedCoin(coin: coin, context: context)
                    coinIsFavourite = false
                } else {
                    viewModel.persistCoin(coin: coin, context: context)
                    coinIsFavourite = true
                }
            } label: {
                Image(systemName: coinIsFavourite ? "heart.fill" : "heart")
            }

        }
        .onAppear() {
            isCoinFavourite()
        }
    }
    
    //MARK: - Methods
    private func isCoinFavourite() {
        coinIsFavourite = favouriteCoins.contains(where: { $0.id == coin.id })
    }
}

//MARK: - Preview
struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let favCoins: [FavouriteCoin] = [
            FavouriteCoin(id: "btc", name: "Bitcoin")
        ]

        let sampleCoin = Coin(id: "bitcoin",
                              symbol: "btc",
                              name: "Bitcoin",
                              rank: 1,
                              marketCap: 10000,
                              image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
                              price: 21000.00,
                              totalVolume: 120,
                              high24h: 0.23,
                              low24h: 10000,
                              priceChange: -32.23,
                              priceChangePercentage: -0.03)

        NavigationView {
            CoinDetailView(coin: sampleCoin, currency: "usd", favouriteCoins: favCoins)
        }
    }
}
