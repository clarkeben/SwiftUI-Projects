//
//  AllCoinsViewModel.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 07/11/2023.
//

import SwiftUI

class CoinViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var currencyCode: NetworkManager.Currency = .gbp
    @Published var searchedCoin = ""
    @Published var searchIsActive = false
    @Published var errorMessage = ""
    
    let coinManager = NetworkManager()
    
    init() {
        Task {
            try await fetchCoin()
        }
    }
    
    func fetchCoin() async throws {
        do {
            let fetchedCoins = try await coinManager.fetchAllCoins(currencyCode: currencyCode, numberOfResults: 100)
            
            DispatchQueue.main.async {
                self.coins = fetchedCoins
            }
            
        } catch let error as NetworkRequestError {
            DispatchQueue.main.async {
                self.handleError(error: error)
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "An unexpected error occurred, please try again!"
            }
        }
    }
    
    private func handleError(error: NetworkRequestError) {
        self.errorMessage = error.description
    }
    
}
