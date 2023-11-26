//
//  NetworkManager.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 03/11/2023.
//

import Foundation

//MARK: - Network Manager
final class NetworkManager {
    enum Currency: String, CaseIterable {        
        case usd = "usd"
        case eur = "eur"
        case jpy = "jpy"
        case gbp = "gbp"
        case aud = "aud"
        case cad = "cad"
        case chf = "chf"
        case cny = "cny"
        case sek = "sek"
        case nzd = "nzd"
    }

    enum CoinTicker: String {
        case bitcoin = "btc"
        case ethereum = "eth"
    }
    
    //MARK: - Methods
    func fetchAllCoins(currencyCode: Currency, numberOfResults: Int) async throws -> [Coin] {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=\(currencyCode.rawValue)&order=market_cap_desc&per_page=\(numberOfResults)&page=1&sparkline=false&price_change_percentage=24h&locale=en"
        
        guard let url = URL(string: urlString) else {
            throw NetworkRequestError.invalidURL
        }
       
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkRequestError.requestFailed
            }
            
            guard httpResponse.statusCode == 200 else {
                throw NetworkRequestError.invalidStatusCode(statusCode: httpResponse.statusCode)
            }
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                return coins
            } catch {
                throw NetworkRequestError.parsingFailed
            }
            
        } catch {
            throw NetworkRequestError.requestFailed
        }
    }
    
    func fetchCoin(coinName: String) async throws -> Coin {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coinName.lowercased())") else {
            throw NetworkRequestError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkRequestError.requestFailed
            }
            
            guard httpResponse.statusCode == 200 else {
                throw NetworkRequestError.invalidStatusCode(statusCode: httpResponse.statusCode)
            }
            
            let coin = try JSONDecoder().decode(Coin.self, from: data)
            return coin
            
        } catch {
            throw NetworkRequestError.requestFailed
        }
    }
    
    func getCoinPriceTimeline(coinName: String, currencyCode: Currency.RawValue) async throws -> TrendlinePriceData {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coinName)/market_chart?vs_currency=\(currencyCode)&days=7&interval=daily") else {
            throw NetworkRequestError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkRequestError.requestFailed
            }
            
            guard httpResponse.statusCode == 200 else {
                throw NetworkRequestError.invalidStatusCode(statusCode: httpResponse.statusCode)
            }
            
            let priceTimeline = try JSONDecoder().decode(TrendlinePriceData.self, from: data)
            
            return priceTimeline
            
        } catch {
            throw NetworkRequestError.requestFailed
        }
    }
        
}
