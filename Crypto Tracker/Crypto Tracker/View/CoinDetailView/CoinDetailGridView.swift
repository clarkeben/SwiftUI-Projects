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
    
    let marketCap: Int
    let rank: Int
    let volume24H: Double
    
    let priceHigh: Double
    let priceLow: Double
    //let allTimeHigh: Double
    
    @Binding var currencyCode: String
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: items, alignment: .center, spacing: 20) {
                CoinDetailGridItem(title: "Market Cap", subtitle: "\(marketCap.withCommas())", currencyCode: $currencyCode)
                CoinDetailGridItem(title: "Volume (24 hours)", subtitle: String(format: "%.2f", volume24H), currencyCode: $currencyCode)
                CoinDetailGridItem(title: "Popularity", subtitle: "#\(rank)", currencyCode: $currencyCode)
            }.padding()
            
            LazyVGrid(columns: items, alignment: .center, spacing: 20) {
                CoinDetailGridItem(title: "Low (24 hour)", showCurrency: true, price: priceHigh, currencyCode: $currencyCode)
                CoinDetailGridItem(title: "High (24 hour)", showCurrency: true, price: priceLow, currencyCode: $currencyCode)
                //CoinDetailGridItem(title: "All Time High", subtitle: "\(allTimeHigh)", currencyCode: <#Binding<String>#>)
            }.padding()
        }
    }
}

struct CoinDetailGridItem: View {
    //MARK: - Properties
    let title: String
    
    @State var showCurrency = false
    
    var subtitle: String = ""
    var price: Double = 0.0
    
    @Binding var currencyCode: String
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 12))
                .fontWeight(.thin)
                .padding(.bottom, 5)
            
            if showCurrency {
                Text(price, format: .currency(code: currencyCode))
                    .font(.system(size: 14))
                    .fontDesign(.rounded)
                    .bold()
                    .foregroundColor(.black)
            } else {
                Text(subtitle)
                    .font(.system(size: 14))
                    .fontDesign(.rounded)
                    .bold()
                    .foregroundColor(.black)
            }
        }
    }
}

//#Preview {
//    //CoinDetailGridView()
//}
