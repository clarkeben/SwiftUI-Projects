//
//  CoinDetailGridView.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 23/11/2023.
//

import SwiftUI

struct CoinDetailGridView: View {
    //MARK: - Properties
    private let items: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    let marketCap: Double
    let rank: Int
    let volume24H: Double
    
    let priceHigh: Double
    let priceLow: Double
    let allTimeHigh: Double
    
    //MARK: - Body
    var body: some View {
        VStack {
            LazyVGrid(columns: items, alignment: .center, spacing: 20) {
                CoinDetailGridItem(title: "Market Cap", subtitle: "$\(marketCap)")
                CoinDetailGridItem(title: "Volume (23 hours)", subtitle: "\(volume24H)")
                CoinDetailGridItem(title: "Popularity", subtitle: "#\(rank)")
            }.padding()
            
            LazyVGrid(columns: items, alignment: .center, spacing: 20) {
                CoinDetailGridItem(title: "Low (1 week)", subtitle: "$\(priceHigh)")
                CoinDetailGridItem(title: "High (1 week)", subtitle: "\(priceLow)")
                CoinDetailGridItem(title: "All Time High", subtitle: "\(allTimeHigh)")
            }.padding()
        }
    }
}

struct CoinDetailGridItem: View {
    //MARK: - Properties
    let title: String
    let subtitle: String
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 10))
                .fontWeight(.thin)
                .padding(.bottom, 5)
            
            Text(subtitle)
                .font(.system(size: 12))
                .fontDesign(.rounded)
                .bold()
                .foregroundColor(.black)
            
        }
    }
}

//#Preview {
//    //CoinDetailGridView()
//}
