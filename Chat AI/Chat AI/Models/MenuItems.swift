//
//  MenuItems.swift
//  Chat AI
//
//  Created by Ben Clarke on 24/02/2023.
//

import Foundation

struct MenuItem: Identifiable, Equatable {
    var id = UUID().uuidString
    var name: String
    var date: Date
}
