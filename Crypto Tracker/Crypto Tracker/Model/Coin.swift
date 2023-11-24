//
//  Coin.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 07/11/2023.
//

import Foundation

struct Coin: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
    let rank: Int
    let marketCap: Int
    let image: String
    let price: Double
    let totalVolume: Double
    let high24h: Double
    let low24h: Double
    let priceChange: Double
    let priceChangePercentage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case rank = "market_cap_rank"
        case marketCap = "market_cap"
        case image
        case price = "current_price"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange = "price_change_24h"
        case priceChangePercentage = "price_change_percentage_24h"
        //case totalSupply = "total_supply"
    }
}
