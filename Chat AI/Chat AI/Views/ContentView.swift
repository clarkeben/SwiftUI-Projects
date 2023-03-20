//
//  ContentView.swift
//  Chat AI
//
//  Created by Ben Clarke on 05/02/2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Chat.title, ascending: true)], animation: .easeInOut)
    var chat: FetchedResults<Chat>
    
    @StateObject private var viewModel = ContentViewModal()
    
    @State var selectedMenuItem: MenuItem? = nil //TODO: - MOVE TO VIEWMODEL AND USE CHAT ARRAY INSTEAD
    @State var selectedChat: Chat? = nil
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                ChatView(viewModel: ChatViewModel(context: viewContext), savedChat: selectedChat)
                    .environment(\.managedObjectContext, viewContext)
                    .navigationTitle(viewModel.title)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading, content: {
                            if !viewModel.menuClicked {
                                IconButton(imageName: "rectangle.on.rectangle") {
                                    viewModel.toggleMenu()
                                }
                            } else {
                                IconButton(imageName: "xmark") {
                                    viewModel.toggleMenu()
                                }
                            }
                        })
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                            NavigationLink(destination: SettingsView()) {
                                NavigationIconLinkButton(imageName: "gear.badge")
                            }
                            .buttonStyle(PlainButtonStyle())
                        })
                    }
                SideMenuView(width: viewModel.width/1.8, menuClicked: viewModel.menuClicked, menuItems: $viewModel.menuItems, itemToDelete: $viewModel.itemToDelete, selectedMenuItem: $selectedMenuItem, toggleMenu: viewModel.toggleMenu, deleteBtnClicked: {
                    viewModel.showAlert.toggle()
                })
                
                if viewModel.itemDeleted {
                    CustomModalPopup(icon: "checkmark.circle.fill", iconColour: .green, title: "Deleted", isShowing: $viewModel.itemDeleted)
                }
            }
            .fullScreenCover(isPresented: $viewModel.showOnboarding) {
                OnboardingView()
            }
            .transition(.scale)
            .animation(.easeInOut, value: viewModel.showOnboarding)
            .onChange(of: viewModel.itemToDelete) { _ in
                deleteMessage(offsets: viewModel.itemToDelete)
            }
            .onChange(of: viewModel.menuClicked) { _ in
                viewModel.loadMenuItems(chat: chat)
            }
            .onChange(of: selectedMenuItem) { _ in
                guard let menuItem = selectedMenuItem else { return }
                viewModel.toggleMenu()
                
                for convo in chat {
                    if menuItem.name == convo.title {
                        selectedChat = convo
                        print(selectedChat)
                    }
                }
            }
            .onAppear() {
                viewModel.loadMenuItems(chat: chat)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Delete all"),
                      message: Text("Would you like to delete all saved conversations, doing this is irreversible"), primaryButton: .cancel(),
                      secondaryButton: .default(Text("Yes!"), action: deleteAllSavedConvos))
            }
        }.accentColor(.black)
    }
    
    //MARK: - Methods
    private func deleteMessage(offsets: IndexSet) {
        withAnimation {
            offsets.map { chat[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.save()
            viewModel.itemDeleted = true
        }
    }
    
    private func deleteAllSavedConvos() {
        for convo in chat {
            viewContext.delete(convo)
        }
        PersistenceController.shared.save()
        viewModel.toggleMenu()
    }
}

//MARK: - ContentViewModal
class ContentViewModal: ObservableObject {
    // MARK: - Properties
    @AppStorage(K.userDefaultKeys.showOnboarding) var showOnboarding = true
    
    @Published var width = UIScreen.main.bounds.width
    @Published var title = "Chat"
    @Published var menuClicked = false
    @Published var menuItems = [MenuItem]()
    @Published var itemToDelete: IndexSet = IndexSet()
    @Published var showAlert = false
    @Published var itemDeleted = false
    
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
    
    func loadMenuItems(chat: FetchedResults<Chat>) {
        menuItems.removeAll()
        
        for convos in chat {
            menuItems.append(MenuItem(name: convos.unwrappedTitle, date: convos.unwrappedDate))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
