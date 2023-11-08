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
    @Published var searchedCoin = "Bitcoin"
    @Published var errorMessage = ""
    
    private let coinManager = NetworkManager()
    
    init() {
        Task {
            try await fetchCoin()
        }
    }
    
    func fetchCoin() async throws {
        do {
            let fetchedCoin = try await coinManager.fetchCoin(coinName: searchedCoin)
            
            DispatchQueue.main.async {
                self.coin = fetchedCoin
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
