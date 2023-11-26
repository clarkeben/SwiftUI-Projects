//
//  PriceTimelineViewModel.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 25/11/2023.
//

import Foundation

class PriceTimelineViewModel: ObservableObject {
    //MARK: - Properties
    @Published var dates = [String]()
    @Published var price = [Double]()
    
    let networkManager: NetworkManager
    let coin: String
    let currencyCode: String
    
    init(networkManager: NetworkManager, coin: String, currencyCode: String) {
        self.networkManager = networkManager
        self.coin = coin
        self.currencyCode = currencyCode
        
        Task {
            try await fetchPriceTimelines()
        }
        
        print("DEBUG: \(dates)")
        print("DEBUG: \(price)")
    }
    
    //MARK: - Methods
    private func fetchPriceTimelines() async throws {
        do {
            let fetchedTimelines = try await networkManager.getCoinPriceTimeline(coinName: coin, currencyCode: currencyCode)
            print("DEBUG: \(fetchedTimelines) ☝️")
            
            DispatchQueue.main.async {
                let fetchedDates = fetchedTimelines.prices.map { self.convertTimestampToDate($0[0]) }
                let formattedDates = fetchedDates.map { self.formatDate($0) }
                
                self.dates = formattedDates
                self.price = fetchedTimelines.prices.map { $0[1] }
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
