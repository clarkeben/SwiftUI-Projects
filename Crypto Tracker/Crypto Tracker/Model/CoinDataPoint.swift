//
//  CoinDataPoint.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 26/11/2023.
//

import Foundation

struct CoinDataPoint: Identifiable {
    let id = UUID()
    let day: String
    let cost: Double
}
