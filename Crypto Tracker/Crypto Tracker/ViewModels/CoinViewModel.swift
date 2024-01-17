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
    @Published var searchedText = ""
    @Published var errorMessage = ""
    @Published var sortAscending = true
    
    var searchedCoinResults: [Coin] {
        let listToSort = searchedText.isEmpty ? coins : coins.filter { $0.name.lowercased().contains(searchedText.lowercased()) }

        return listToSort.sorted { sortAscending ? $0.rank < $1.rank : $0.rank > $1.rank }
    }
    
    let networkManager = NetworkManager.shared
    
    init() {
        Task {
            try await fetchCoin()
        }
    }
    
    func fetchCoin() async throws {
        do {
            let fetchedCoins = try await networkManager.fetchAllCoins(currencyCode: currencyCode, numberOfResults: 100)
            
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
    
    //TODO: - Rewrite for better efficiency 
    func filterFavCoins(favouriteCoins: [FavouriteCoin]) {
        let favouriteCoinNames = Set(favouriteCoins.map { $0.name })
        coins = coins.filter { favouriteCoinNames.contains($0.name) }
//        var coinsToReturn = [Coin]()
//        
//        for favCoin in favouriteCoins {
//            for coin in coins {
//                if coin.name == favCoin.name {
//                    coins.append(coin)
//                }
//            }
//        }
//        coins = coinsToReturn
    }

}
