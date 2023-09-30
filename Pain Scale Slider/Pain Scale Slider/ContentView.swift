//
//  ContentView.swift
//  Pain Scale Slider
//
//  Created by Benjamin Clarke on 29/09/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            PainScaleSlider()
                .navigationTitle("Pain Scale Slider")
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
