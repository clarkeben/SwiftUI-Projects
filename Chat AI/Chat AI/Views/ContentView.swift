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
    
    @State private var showAlert = false
    
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
                SideMenuView(width: width/1.8, menuClicked: menuClicked, menuItems: $menuItems, itemToDelete: $itemToDelete, toggleMenu: toggleMenu, deleteBtnClicked: {
                    showAlert.toggle()
                })
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Delete all"),
                      message: Text("Would you like to delete all saved conversations, doing this is irreversible"), primaryButton: .cancel(),
                      secondaryButton: .default(Text("Yes!"), action:                     deleteAllSavedConvos))
            }
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
    
    private func loadMenuItems() {
        menuItems.removeAll()
        
        for message in messages {
            menuItems.append(MenuItem(name: message.message ?? "", date: message.date ?? Date()))
        }
    }
    
    private func deleteMessage(offsets: IndexSet) {
        withAnimation {
            offsets.map { messages[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.save()
        }
    }
    
    private func deleteAllSavedConvos() {
        for message in messages {
            viewContext.delete(message)
        }
        PersistenceController.shared.save()
        toggleMenu()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
