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
    //TODO: - Persist using userdefaults 
    @State private var showOnboarding = true
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Content View! 🧑🏼‍🚀")
            }
            .navigationTitle("Space Traveller")
        }
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView(showOnboardingView: $showOnboarding)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
