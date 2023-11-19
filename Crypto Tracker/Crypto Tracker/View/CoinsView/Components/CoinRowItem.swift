//
//  CoinRowItem.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 18/11/2023.
//

import SwiftUI

struct CoinRowItem: View {
    //MARK: - Properties
    let rank: Int
    let imageURL: String
    let name: String
    let symbol: String
    let marketCap: Int
    let price: Double
    let currency: String
    let priceChange: Double
    let pricePercentageChange: Double
    
    var priceChangeText: Text {
        if priceChange > 0.0 {
            return Text("+\(priceChange, specifier: "%.2f") (+\(pricePercentageChange*100, specifier:  "%.2f")%)")
        } else {
            return Text("\(priceChange, specifier: "%.2f") (\(pricePercentageChange*100, specifier:  "%.2f")%)")
        }
    }
    
    //MARK: - Body
    var body: some View {
        HStack {
            Text("\(rank)")
                .foregroundColor(.secondary)
                .padding(5)
            
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40, alignment: .center)
            
            VStack(alignment: .leading) {
                Text("\(name) (\(symbol))")
                    .fontDesign(.rounded)
                    .bold()
                    .foregroundColor(.black)
                Text("\(marketCap)")
                    .font(.system(size: 10))
                    .fontWeight(.thin)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(price, format: .currency(code: currency))
                priceChangeText
                    .foregroundColor(priceChange > 0.0 ? .green : .red)
                    .font(.system(size: 12))

            }
        }.padding([.top, .bottom], 5)
    }
}

#Preview {
    CoinRowItem(rank: 1, imageURL: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", name: "Bitcoin", symbol: "BTC", marketCap: 100000, price: 1080.20, currency: "usd", priceChange: 2309.00, pricePercentageChange: 0.123)
}
