//
//  FavouriteCoin.swift
//  Crypto Tracker
//
//  Created by Ben Clarke on 14/01/2024.
//

import Foundation
import SwiftData

@Model
class FavouriteCoin {
    var id: String
    var name: String
    var dateSave: Date = Date.now
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
