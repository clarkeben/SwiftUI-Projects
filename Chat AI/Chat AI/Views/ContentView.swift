//
//  ContentView.swift
//  Chat AI
//
//  Created by Ben Clarke on 05/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @AppStorage("showOnboarding") private var showOnboarding = true
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ChatView()
                .navigationTitle("Chat")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        IconButton(imageName: "rectangle.on.rectangle") {
                            //TODO: - Persist previous chats
                        }
                    })
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        IconButton(imageName: "gear.badge") {
                            //TODO: - setup settings screen
                        }
                    })
                }
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView()
        }
        .transition(.scale)
        .animation(.easeInOut)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
