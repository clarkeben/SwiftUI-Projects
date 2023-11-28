//
//  PriceTimelineViewModel.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 25/11/2023.
//

import Foundation

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
    }
    
    //MARK: - Properties
    @Published var coinData = [CoinDataPoint]()
    @Published var chartAxisMeasure: String = ChartXAxisMeasure.weekly.description
    
    let networkManager: NetworkManager = NetworkManager.shared
    let coin: String
    let currencyCode: String
    
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
            let fetchedTimelines = try await networkManager.getCoinPriceTimeline(coinName: coin, currencyCode: currencyCode)
            
            let fetchedDates = fetchedTimelines.prices.map { self.convertTimestampToDate($0[0]) }
            let formattedDates = fetchedDates.map { self.formatDate($0) }
            
            var coinPriceData = [CoinDataPoint]()
            
            for (index, data) in formattedDates.enumerated() {
                if index < fetchedTimelines.prices.count {
                    let date = formattedDates[index]
                    let price = fetchedTimelines.prices[index][1] // Assuming $0[1] is the price
                    let dataPoint = CoinDataPoint(day: date, cost: price)
                    coinPriceData.append(dataPoint)
                }
            }
            
            DispatchQueue.main.async {
                self.coinData = coinPriceData
            }
            
        } catch let error as NetworkRequestError {
            DispatchQueue.main.async {
                //self.handleError(error: error)
            }
        } catch {
            DispatchQueue.main.async {
                //self.errorMessage = "An unexpected error occurred, please try again!"
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
}
