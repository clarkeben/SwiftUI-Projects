//
//  ContentView.swift
//  Chat AI
//
//  Created by Ben Clarke on 05/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State var showOnboarding = true
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView(showOnboarding: $showOnboarding)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
