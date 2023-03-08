//
//  ContentView.swift
//  Chat AI
//
//  Created by Ben Clarke on 05/02/2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var width = UIScreen.main.bounds.width
    
    @AppStorage(K.userDefaultKeys.showOnboarding) var showOnboarding = true
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Message.message, ascending: true)], animation: .easeInOut)
    var messages: FetchedResults<Message>
    
    @State private var title = "Chat"
    @State private var menuClicked = false
    @State private var menuItems = [MenuItem]()
    @State var itemToDelete: IndexSet = IndexSet()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                ChatView(viewModel: ChatViewModel(context: viewContext))
                    .environment(\.managedObjectContext, viewContext)
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
                SideMenuView(width: width/1.8, menuClicked: menuClicked, menuItems: $menuItems, itemToDelete: $itemToDelete, toggleMenu: toggleMenu)
            }
            .fullScreenCover(isPresented: $showOnboarding) {
                OnboardingView()
            }
            .transition(.scale)
            .animation(.easeInOut, value: showOnboarding)
            .accentColor(.black)
            .onChange(of: itemToDelete) { _ in
                deleteMessage(offsets: itemToDelete)
            }
            .onChange(of: menuClicked) { _ in
                loadMenuItems()
            }
            .onAppear() {
                loadMenuItems()
            }
        }
    }
    
    //MARK: - Methods
    func toggleMenu() {
        menuClicked.toggle()
        
        if menuClicked {
            title = ""
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.title = "Chat"
            }
        }
    }
    
    func loadMenuItems() {
        for message in messages {
            menuItems.append(MenuItem(name: message.message ?? "", date: Date()))
        }
    }
    
    private func deleteMessage(offsets: IndexSet) {
        withAnimation {
            offsets.map { messages[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.save()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
