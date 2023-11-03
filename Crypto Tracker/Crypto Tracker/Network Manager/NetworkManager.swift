//
//  NetworkManager.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 03/11/2023.
//

import Foundation

struct Coin: Codable {
}

enum NetworkRequestError: Error {
    case invalidURL
    case errorFetchingData
    case fetchFailed
    case invalidStatusCode
}



class NetworkManager {
    enum SupportedCurrencies: String {
        case usd = "usd"
        case gbp = "gbp"
    }
    
    //MARK: - Methods
    func fetchAllCoins(currencyCode: SupportedCurrencies, numberOfResults: Int) async throws -> Coin {
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
                throw NetworkRequestError.invalidStatusCode
            }
            
            let coins = try JSONDecoder().decode(Coin.self, from: data)
            return coins
            
        } catch {
            throw NetworkRequestError.errorFetchingData
        }
    }
    
}
