//
//  ContentView.swift
//  Chat AI
//
//  Created by Ben Clarke on 05/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @AppStorage(K.userDefaultKeys.showOnboarding) private var showOnboarding = true
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ChatView()
                .navigationTitle("Chat")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        IconButton(imageName: "rectangle.on.rectangle") {
                            //TODO: - Show previously previous chats
                        }
                    })
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        NavigationLink(destination: SettingsView()) {
                            NavigationIconLinkButton(imageName: "gear.badge")
                        }.buttonStyle(PlainButtonStyle())
                    })
                }
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView()
        }
        .transition(.scale)
        .animation(.easeInOut, value: showOnboarding)
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
