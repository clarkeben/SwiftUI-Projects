//
//  FavouritesView.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 10/11/2023.
//

import SwiftUI
import SwiftData

struct FavouritesView: View {
    //MARK: - Properties
    @Environment(\.modelContext) var context
    
    @ObservedObject var viewModel = CoinViewModel()
    @Query(sort: \FavouriteCoin.dateSave) var favouriteCoins: [FavouriteCoin]
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            //TODO: - Handle if there is no content
            VStack {
                if favouriteCoins.isEmpty {
                    ContentUnavailableView("No saved coins", 
                                           systemImage: "bitcoinsign.arrow.circlepath",
                                           description: Text("Please favourite a crypto currency!")
                    )
                } else {
                    List {
                        ForEach(viewModel.coins) { coin in
                            CoinRowItem(rank: coin.rank,
                                        imageURL: coin.image,
                                        name: coin.name,
                                        symbol: coin.symbol,
                                        marketCap: coin.marketCap,
                                        price: coin.price,
                                        currency: viewModel.currencyCode.rawValue,
                                        priceChange: coin.priceChange,
                                        pricePercentageChange: coin.priceChangePercentage,
                                        showCoinRank: false)
                            .buttonStyle(PlainButtonStyle())
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .background(.clear)
                                    .foregroundColor(.white)
                                    .padding(
                                        EdgeInsets(
                                            top: 5,
                                            leading: 10,
                                            bottom: 5,
                                            trailing: 10
                                        )
                                    )
                            )
                        }
                        .onDelete(perform: deleteFavouriteCoin)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.grouped)
                }
            }
            .navigationTitle("Favourite Coins")
            .onAppear() {
                viewModel.filterFavouriteCoins(favouriteCoins)
            }
        }
    }
    
    //MARK: - Methods
    func deleteFavouriteCoin(at offsets: IndexSet) {
        withAnimation {
            offsets.forEach { index in
                let coinToDelete = viewModel.coins[index]
                
                if let matchingFavouriteCoin = favouriteCoins.first(where: { $0.id == coinToDelete.id }) {
                    context.delete(matchingFavouriteCoin)
                }
            }
            
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
            viewModel.filterFavouriteCoins(favouriteCoins)
        }
    }
    
}

#Preview {
    FavouritesView()
}
