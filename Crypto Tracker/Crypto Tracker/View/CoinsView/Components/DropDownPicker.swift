//
//  DropDownPicker.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 18/11/2023.
//

import SwiftUI

struct DropDownPicker: View {
    //MARK: - Properties
    @Binding var selectedCurrency: NetworkManager.Currency
    var completion: () -> Void
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            Picker("", selection: $selectedCurrency) {
                ForEach(NetworkManager.Currency.allCases, id: \.self) { currency in
                    Text(currency.rawValue)
                }.onChange(of: selectedCurrency) {
                    completion()
                }
            }
        }
        .frame(width: 80, height: 40)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    DropDownPicker(selectedCurrency: .constant(NetworkManager.Currency.aud)) {
        print("picker tapped")
    }
}
