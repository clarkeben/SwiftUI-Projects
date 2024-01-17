//
//  PriceTimelineViewModel.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 25/11/2023.
//

import SwiftUI
import SwiftData

class PriceTimelineViewModel: ObservableObject {
    //MARK: - ChartTimeline Enum
    enum ChartXAxisMeasure: Int, CaseIterable {
        case daily = 1
        case weekly = 7
        case monthly = 30
        case quarterly = 90
        case yearly = 365
        
        var description: String {
            switch self {
            case .daily: return "1D"
            case .weekly: return "1W"
            case .monthly: return "1M"
            case .quarterly: return "3M"
            case .yearly: return "1Y"
            }
        }
        
        var interval: String {
            switch self {
            case .daily: return "hourly"
            case .weekly, .monthly, .quarterly, .yearly: return "daily"
            }
        }
    }
    
    //MARK: - Properties
    @Published var coinData = [CoinDataPoint]()
    @Published var chartAxisMeasure: ChartXAxisMeasure = .weekly {
        didSet {
            Task {
                try await fetchPriceTimelines()
            }
        }
    }
    
    @Published var errorMessage = ""
    
    let networkManager: NetworkManager = NetworkManager.shared
    let coin: String
    let currencyCode: String
    
    // Swift Data
    //@Query(sort: \FavouriteCoin.dateSave) var favouriteCoins: [FavouriteCoin]
    //var favouriteCoins: [FavouriteCoin]
    
    init(coin: String, currencyCode: String) {
        self.coin = coin
        self.currencyCode = currencyCode
        
        Task {
            try await fetchPriceTimelines()
        }
    }
    
    //MARK: - Methods
    func fetchPriceTimelines() async throws {
        do {
            let fetchedTimelines = try await networkManager.getCoinPriceTimeline(coinName: coin, currencyCode: currencyCode, days: chartAxisMeasure.rawValue, interval: chartAxisMeasure.interval)
            
            let fetchedDates = fetchedTimelines.prices.map { self.convertTimestampToDate($0[0]) }
            let formattedDates = fetchedDates.map { self.formatDate($0) }
            
            var coinPriceData = [CoinDataPoint]()
            
            for (index, _) in formattedDates.enumerated() {
                if index < fetchedTimelines.prices.count {
                    let date = formattedDates[index]
                    let price = fetchedTimelines.prices[index][1]
                    let dataPoint = CoinDataPoint(day: date, cost: price)
                    coinPriceData.append(dataPoint)
                }
            }
            
            await updateCoinData(coinPriceData)
            
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
    
    private func convertTimestampToDate(_ timestamp: Double) -> Date {
        return Date(timeIntervalSince1970: timestamp / 1000)
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    private func updateCoinData(_ coinData: [CoinDataPoint]) async {
        await MainActor.run {
            self.coinData = coinData
        }
    }
    
    private func handleError(error: NetworkRequestError) {
        self.errorMessage = error.description
    }
    
    //MARK: - SwiftData Methods
    func persistCoin(coin: FavouriteCoin, context: ModelContext) {
        context.insert(coin)
    }
    
    func deleteSavedCoin(coin: FavouriteCoin, context: ModelContext) {
        context.delete(coin)
    }
}
