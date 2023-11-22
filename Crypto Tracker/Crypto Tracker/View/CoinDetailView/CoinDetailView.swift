//
//  CoinDetailView.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 20/11/2023.
//

import SwiftUI
import Charts

struct DummyBitcoinDataPoint: Identifiable {
    let id = UUID()
    let day: String
    let cost: Double
}

struct CoinDetailView: View {
    //MARK: - Properties
    let coin: Coin
    let currency: String = "usd"
    
    private let data: [DummyBitcoinDataPoint] = [
        DummyBitcoinDataPoint(day: "Mon", cost: 30000.0),
        DummyBitcoinDataPoint(day: "Tue", cost: 31000.0),
        DummyBitcoinDataPoint(day: "Wed", cost: 32000.0),
        DummyBitcoinDataPoint(day: "Thu", cost: 33000.0),
        DummyBitcoinDataPoint(day: "Fri", cost: 34000.0),
        DummyBitcoinDataPoint(day: "Sat", cost: 35000.0),
        DummyBitcoinDataPoint(day: "Sun", cost: 36000.0)
    ]
    
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
                    
                    Text("Last 24 hours: +234.548")
                        .font(.system(size: 12))
                        .fontWeight(.thin)
                }
                
                Spacer()
                
                AsyncImage(url: URL(string: coin.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 60, height: 60, alignment: .center)
                
            }.padding()
            
            Chart {
                ForEach(data) { dataPoint in
                    LineMark(
                        x: .value("Day", dataPoint.day),
                        y: .value("Cost (£)", dataPoint.cost)
                    )
                }
            }
            .frame(height: 200)
            .padding(.horizontal, 5)
            
            Section {
                Text("Market Statistics")
                    .font(.system(size: 12))
                    .fontWeight(.thin)
                
                VStack(alignment: .leading) {
                    Text("Market Cap")
                        .font(.system(size: 10))
                        .fontWeight(.thin)
                    
                    Text("Subtitle")
                        .font(.system(size: 12))
                        .fontDesign(.rounded)
                        .bold()
                        .foregroundColor(.black)
                        
                }
            }.padding()
            
            
            Spacer()
        }
        .navigationTitle("\(coin.name) (\(coin.symbol.uppercased()))")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        CoinDetailView(coin: Coin(id: "bitcoin", symbol: "btc", name: "Bitcoin", rank: 1, image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", price: 21000.00, marketCap: 10000, priceChange: -32.23, priceChangePercentage: -0.03))
    }
    
}
