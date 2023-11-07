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
}
