//
//  ContentView.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 31/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = CoinViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.coin?.symbol ?? "😫")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
