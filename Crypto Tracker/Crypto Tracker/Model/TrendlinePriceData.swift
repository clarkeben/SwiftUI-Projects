//
//  TrendlinePriceData.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 25/11/2023.
//

import Foundation

struct TrendlinePriceData: Codable {
    let prices: [[Double]]
    //let marketCaps: [[Double]]
    //let totalVolumes: [[Double]]

    enum CodingKeys: String, CodingKey {
        case prices
        //case marketCaps = "market_caps"
        //case totalVolumes = "total_volumes"
    }
}
