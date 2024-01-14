//
//  Crypto_TrackerApp.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 31/10/2023.
//

import SwiftUI
import SwiftData

@main
struct Crypto_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [FavouriteCoin.self])
    }
}
