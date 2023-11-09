//
//  CoinsView.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 09/11/2023.
//

import SwiftUI

struct CoinsView: View {
    
    //MARK: - Properties
    @StateObject var viewModel = CoinViewModel()

    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.coins.isEmpty {
                    Text("ARRAY LOADING")
                } else {
                    Text(viewModel.coins[0].id)
                    Text(viewModel.coins[0].symbol)
                    Text(viewModel.coins[0].name)
                }
            }
            .navigationTitle("All Coins")
        }
    }
}

#Preview {
    CoinsView()
}
