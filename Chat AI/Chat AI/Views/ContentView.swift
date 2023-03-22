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
    
    @State var selectedConversation: Chat? = nil
        
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                ChatView(viewModel: ChatViewModel(context: viewContext), selectedConversation: $selectedConversation)
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
                SideMenuView(context: viewContext, chatConvos: chat, width: viewModel.width/1.8, menuClicked: viewModel.menuClicked,  selectedConversation: $selectedConversation, messageDeleted: $viewModel.itemDeleted, toggleMenu: viewModel.toggleMenu, deleteBtnClicked: {
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
            .onChange(of: selectedConversation) { _ in
                viewModel.toggleMenu()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Delete all"),
                      message: Text("Would you like to delete all saved conversations, doing this is irreversible"), primaryButton: .cancel(),
                      secondaryButton: .default(Text("Yes!"), action: deleteAllSavedConvos))
            }
        }.accentColor(.black)
    }
    
    //MARK: - Methods
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
