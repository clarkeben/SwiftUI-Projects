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

    @Query(sort: \FavouriteCoin.dateSave) var favouriteCoins: [FavouriteCoin]
    
    //MARK: - Body
    var body: some View {
        List {
            ForEach(favouriteCoins) { coin in
                Text(coin.name)
            }
            .onDelete(perform: { indexSet in
                for index in indexSet {
                    context.delete(favouriteCoins[index])
                }
            })
        }
    }
}

#Preview {
    FavouritesView()
}
