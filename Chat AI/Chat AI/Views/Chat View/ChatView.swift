//
//  ChatView.swift
//  Chat AI
//
//  Created by Ben Clarke on 06/02/2023.
//

import SwiftUI
import CoreData
import UniformTypeIdentifiers

struct ChatView: View {
    //MARK: - Properties
    @StateObject var viewModel: ChatViewModel
    
    private let screenWidth = UIScreen.main.bounds.width
    
    @Binding var selectedConversation: Chat?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    if viewModel.chat.isEmpty {
                        VStack {
                            Text("Need some inspiration?")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                                .bold()
                                .padding()
                            
                            ForEach(0...4, id: \.self) { index in
                                RegularButton(viewModel.dummyQuestions[index]) {
                                    viewModel.inspirationRequest(viewModel.dummyQuestions[index])
                                }
                                .padding()
                            }
                        }.onTapGesture {
                            endEditing()
                        }
                    } else {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: screenWidth - 20))]) {
                            ForEach(viewModel.chat) { chat in
                                ChatCell(sender: chat.responder, message: chat.message, date: chat.date)
                                    .contextMenu {
                                        ActionButton(systemIcon: "square.and.arrow.down", title: "Copy Message") {
                                            viewModel.copySelectedMessage(chat.message)
                                        }
                                        ActionButton(systemIcon: "xmark.bin", title: "Delete Message") {
                                            viewModel.deleteSelectedMessage(chat.message)
                                        }
                                    }
                            }
                            .padding([.top], 5)
                            .onTapGesture {
                                endEditing()
                            }
                            
                            if viewModel.chat.count >= 2 {
                                Divider().padding(.horizontal, 5)
                                
                                ActionButton(systemIcon: "square.and.arrow.down", title: "Save Chat") {
                                    viewModel.saveChat()
                                }
                                
                                if viewModel.showingSavedChat {
                                    ActionButton(systemIcon: "xmark.bin", title: "Delete Chat") {
                                        viewModel.deleteSavedChat()
                                    }
                                }
                                
                                ActionButton(systemIcon: "square.and.arrow.up", title: "Share Chat") {
                                    viewModel.shareChat()
                                }
                                
                                ActionButton(systemIcon: "xmark", title: "Clear Chat") {
                                    viewModel.clearChat()
                                }
                            }
                        }
                    }
                }
                
                if viewModel.fetchingData {
                    HStack {
                        TypingTextView(text: "Fetching Data....")
                        Spacer()
                    }
                }
                
                HStack {
                    TextField("Ask a question?", text: $viewModel.userQuery, axis: .vertical)
                    Spacer()
                    
                    IconButton(imageName: "paperplane") {
                        viewModel.sendRequest()
                        endEditing()
                    }
                }
                .dropShadowRoundView()
            }
            .padding(10)
            
            if viewModel.showSavedModal {
                CustomModalPopup(icon: "checkmark.circle.fill", iconColour: .green, title: "Saved", isShowing: $viewModel.showSavedModal)
            }
            
            if viewModel.showDeletedModal {
                CustomModalPopup(icon: "checkmark.circle.fill", iconColour: .green, title: "Deleted", isShowing: $viewModel.showDeletedModal)
            }
            
            /* ---- Testing required for the NetworkConnectionManager
             if viewModel.hasNoNetworkConnection {
                CustomModalPopup(icon: "wifi.slash", iconColour: .red, title: "No Service", isShowing: $viewModel.hasNoNetworkConnection)
            }*/
        }
        .onChange(of: selectedConversation) { _ in
            viewModel.updatedSelectedMessage(selectedConversation)
        }
        .alert("Error fetching data", isPresented: $viewModel.showErrorAlert, actions: {
            Button("OK", role: .cancel, action: {})
        }, message: {
            Text(viewModel.errorMessage)
        })
    }
}

// MARK: - ChatViewModel
class ChatViewModel: ObservableObject {
    // Properties
    private let context: NSManagedObjectContext
    
    @Published var userQuery = ""
    @Published var chat = [ChatModel]()
    @Published var fetchingData = false
    @Published var dummyQuestions: [String] = [
        "What is your name?",
        "What is your earliest memory?",
        "Do you have dreams?",
        "If you were a book, what would it be about?",
        "How many chromosomes are in a cell?",
        "What was the first message sent by morse code?",
        "How many moons does Neptune have?",
        "What is the fifth sign of the zodiac?",
        "How many pounds are in a ton?",
        "What animal’s nickname is 'sea cow'?",
        "What animal breathes through its butt?",
        "Where are cricket’s ears located?",
        "Who is the highest grossing actor?",
        "Where are the hearts of an octopus located?",
        "What is the origins of Hello World?",
        "Who invented the internet?"
    ].shuffled()
    
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    @Published var showSavedModal = false
    @Published var convoSaved = false
    @Published var chatConvo: Chat?
    
    @Published var showingSavedChat = false
    @Published var showDeletedModal = false
    
    @Published var hasNoNetworkConnection = false
    
    @AppStorage(K.userDefaultKeys.settings.fontSize) var fontSize = 14
    @AppStorage(K.userDefaultKeys.settings.enabledRelatedChat) var enabledRelatedChat = true

    
    private let newMessageText = "You've started a new conversation, please ask me something..."
    
    let networkManager: ChatNetworkManager = ChatNetworkManager.shared
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    //MARK: - Public Methods
    func inspirationRequest(_ question: String) {
        userQuery = question
        sendRequest()
    }
    
    func sendRequest() {
        guard !userQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        fetchingData = true
        
        chat.append(ChatModel(responder: .user, message: userQuery, date: Date.now))
        
        var query = returnRelatedMessages(userQuery: userQuery)
        
        //TODO: - Further testing required
        //checkNetworkStatus()
        
        makeRequest(with: query)
    }
    
    
    func clearChat() {
        chat.removeAll()
        chat.append(ChatModel(responder: .aiBot, message: newMessageText, date: Date()))
        
        convoSaved = false
        chatConvo = nil
        showingSavedChat = false
    }
    
    func saveChat() {
        if chat[0].message == newMessageText {
            chat.removeFirst()
        }
        
        // Check if conversation is already saved
        if convoSaved {
            updateSavedChat()
        } else {
            let conversation = Chat(context: context)
            conversation.title = chat[0].message
            conversation.date = chat[0].date
            
            for i in 0..<chat.count {
                let newMessage = Message(context: context)
                newMessage.message = chat[i].message
                newMessage.sender = chat[i].responder.rawValue
                newMessage.date = chat[i].date
                
                conversation.addToMessage(newMessage)
            }
            PersistenceController.shared.save()
            chatConvo = conversation
        }
        
        showSavedModal = true
        convoSaved = true
    }
    
    /// Method for when a user wants to share the current conversation
    func shareChat() {
        var messages = [String]()
        
        for convo in chat {
            switch convo.responder {
            case .user: messages.append("Question: \n\(convo.message)")
            case .aiBot: messages.append("Answer: \n\(convo.message)")
            }
        }
        
        let activityVC = UIActivityViewController(activityItems: messages, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
    ///Method to delete selected message when a message is long pressed 
    func deleteSelectedMessage(_ message: String) {
        for i in 0..<chat.count {
            if message == chat[i].message {
                chat.remove(at: i)
            }
        }
    }
    
    /// Method for copying a selected message to the paste board
    func copySelectedMessage(_ message: String) {
        UIPasteboard.general.setValue(message, forPasteboardType: "public.plain-text")
    }
    
    /// Update if the user has selected a prior conversation using the sidebar
    func updatedSelectedMessage(_ chatConvo: Chat?) {
        guard let convo = chatConvo else { return }
        
        self.chatConvo = chatConvo
        
        chat = convo.messageArray.map { message in
            if message.unwrappedSender == Response.user.rawValue {
                return ChatModel(responder: .user, message: message.unwrappedMessage, date: message.unwrappedDate)
            } else {
                return ChatModel(responder: .aiBot, message: message.unwrappedMessage, date: message.unwrappedDate)
            }
        }
        
        chat.sort(by: { $0.date < $1.date })
        
        showingSavedChat = true
    }
    
    /// Delete the current saved Chat in CoreData
    func deleteSavedChat() {
        guard let convo = chatConvo else { return }
        
        context.delete(convo)
        PersistenceController.shared.save()
        
        showDeletedModal = true
        showingSavedChat = false
        
        withAnimation {
            chat.removeAll()
        }
    }
    
    //MARK: - Private Methods
    private func makeRequest(with query: String) {
        networkManager.request(query) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                defer {
                    self.userQuery = ""
                    self.fetchingData = false
                }
                
                switch result {
                case .success(let response):
                    self.chat.append(ChatModel(responder: .aiBot, message: response, date: Date.now))
                case .failure(let error):
                    self.showErrorAlert = true
                    self.errorMessage = "Please check your network connection, if that does not work please try generating a new API key. 🤖"
                    print(error.localizedDescription, "⚡️⚡️⚡️")
                }
            }
        }
    }
    
    ///Check if the user has enabled related mssaged and is so updated the query string
    private func returnRelatedMessages(userQuery: String) -> String{
        if enabledRelatedChat && chat.count > 2 {
            var questionString = "Hello there! As part of this conversation, we have a prior exchange between you (the AI Bot) and the User (asking the questions). Please refer to the messages below to refresh your memory. Additionally, we have a follow-up question for you that pertains to the previous messages. We kindly request that you answer the question in the context of the previous conversation. \n Here is the prior conversation:\n"
            
            for message in chat {
                questionString += "\(message.responder): \(message.message)\n"
            }
            
            questionString += "Here is the latest question: \(userQuery)"
            
            return questionString
        } else {
            return userQuery
        }
    }
    
    /// Private method for updating the current conversation if the user has already saved it using CoreData
    private func updateSavedChat() {
        guard let conversation = chatConvo else {
            return
        }
        
        conversation.message = []
        
        for i in 0..<chat.count {
            let newMessage = Message(context: context)
            newMessage.message = chat[i].message
            newMessage.sender = chat[i].responder.rawValue
            newMessage.date = chat[i].date
            
            conversation.addToMessage(newMessage)
        }
        
        PersistenceController.shared.save()
    }
    
    /// Private Method to check the current Network Status of the app updating a boolean value to true if there is no connection
    private func checkNetworkStatus() {
        let networkManager = NetworkMonitorManager.shared
        
        networkManager.startMonitoring { isConnected in
            DispatchQueue.main.async {
                self.hasNoNetworkConnection = !isConnected
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        let viewModel = ChatViewModel(context: context)
        let chat = Chat(context: context)
        return ChatView(viewModel: viewModel, selectedConversation: .constant(chat))
    }
}
