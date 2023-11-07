//
//  AllCoinsViewModel.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 07/11/2023.
//

import SwiftUI

class AllCoinsViewModel: ObservableObject {
    
    @Published var coins = [Coin]()
    
    init() {
        
    }
    
}


class CoinViewModel: ObservableObject {
    @Published var coin: Coin?
    
    private let coinManager = NetworkManager()
    
    init() {
        Task {
            try await fetchCoin()
        }
    }
    
    func fetchCoin() async throws {
        do {
            self.coin = try await coinManager.fetchCoin(coinName: "Bitcoin")
        } catch NetworkRequestError.errorFetchingData {
            print("DEBUG: Error fetching coins")
        } catch NetworkRequestError.fetchFailed {
            print("DEBUG: fetch failed")
        } catch NetworkRequestError.invalidURL {
            print("DEBUG: invalid URL")
        } catch NetworkRequestError.invalidStatusCode(_) {
            print("DEBUG: invalid status code")
        }
    }
    
}
