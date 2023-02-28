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
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var width = UIScreen.main.bounds.width
    
    @State private var title = "Chat"
    @State private var menuClicked = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                ChatView()
                    .navigationTitle(title)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading, content: {
                            if !menuClicked {
                                IconButton(imageName: "rectangle.on.rectangle") {
                                    toggleMenu()
                                }
                            } else {
                                IconButton(imageName: "xmark") {
                                    toggleMenu()
                                }
                            }
                        })
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                            NavigationLink(destination: SettingsView()) {
                                NavigationIconLinkButton(imageName: "gear.badge")
                            }.buttonStyle(PlainButtonStyle())
                        })
                    }
                SideMenuView(width: width/1.8, menuClicked: menuClicked, toggleMenu: toggleMenu)
            }
            .fullScreenCover(isPresented: $showOnboarding) {
                OnboardingView()
            }
            .transition(.scale)
            .animation(.easeInOut, value: showOnboarding)
            .accentColor(.black)
        }
    }
    
    //MARK: - Methods
    private func toggleMenu() {
        menuClicked.toggle()
    
        if menuClicked {
            title = ""
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.title = "Chat"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
