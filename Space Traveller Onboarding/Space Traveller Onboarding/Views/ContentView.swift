//
//  ContentView.swift
//  Space Traveller Onboarding
//
//  Created by Ben Clarke on 10/01/2023.
//

// Mark: - My Socials
/// Instagram: @Vikingskullapps
/// Twitter: @VikingSkullapps

import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Content View! 🧑🏼‍🚀")
            }
            .navigationTitle("Space Traveller")
        }
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $showOnboarding) {
            // Onboarding View
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
