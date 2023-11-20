//
//  CoinDetailView.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 20/11/2023.
//

import SwiftUI

struct CoinDetailView: View {
    //MARK: - Properties
    let coin: Coin
    
    //MARK: - Body
    var body: some View {
        VStack {
            
        }
        .navigationTitle(coin.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        CoinDetailView(coin: Coin(id: "bitcoin", symbol: "btc", name: "Bitcoin", rank: 1, image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", price: 21000.00, marketCap: 10000, priceChange: -32.23, priceChangePercentage: -0.03))
    }
   
}
