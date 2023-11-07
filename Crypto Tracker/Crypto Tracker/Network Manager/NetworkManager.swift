//
//  NetworkManager.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 03/11/2023.
//

import Foundation

enum NetworkRequestError: Error {
    case invalidURL
    case errorFetchingData
    case fetchFailed
    case invalidStatusCode(Int)
}

//MARK: - Network Manager
final class NetworkManager {
    enum SupportedCurrencies: String {
        case usd = "usd"
        case gbp = "gbp"
    }
    
    enum CoinTicker: String {
        case bitcoin = "btc"
        case etherum = "eth"
    }
    
    //MARK: - Methods
    func fetchAllCoins(currencyCode: SupportedCurrencies, numberOfResults: Int) async throws -> [Coin] {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=\(currencyCode.rawValue)&order=market_cap_desc&per_page=\(numberOfResults)&page=1&sparkline=false&price_change_percentage=24h&locale=en"
        
        guard let url = URL(string: urlString) else {
            throw NetworkRequestError.invalidURL
        }
       
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkRequestError.fetchFailed
            }
            
            guard httpResponse.statusCode == 200 else {
                throw NetworkRequestError.invalidStatusCode(httpResponse.statusCode)
            }
            
            let coins = try JSONDecoder().decode([Coin].self, from: data)
            return coins
            
        } catch {
            throw NetworkRequestError.errorFetchingData
        }
    }
    
    func fetchCoin(coinName: String) async throws -> Coin {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coinName.lowercased())") else {
            throw NetworkRequestError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkRequestError.fetchFailed
            }
            
            guard httpResponse.statusCode == 200 else {
                throw NetworkRequestError.invalidStatusCode(httpResponse.statusCode)
            }
            
            let coin = try JSONDecoder().decode(Coin.self, from: data)
            return coin
            
        } catch {
            throw NetworkRequestError.errorFetchingData
        }
    }
    
}
