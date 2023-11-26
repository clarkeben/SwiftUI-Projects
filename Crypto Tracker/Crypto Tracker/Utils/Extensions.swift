//
//  Extensions.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 25/11/2023.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

