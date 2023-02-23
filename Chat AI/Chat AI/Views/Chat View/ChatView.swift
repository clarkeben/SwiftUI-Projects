//
//  ChatView.swift
//  Chat AI
//
//  Created by Ben Clarke on 06/02/2023.
//

import SwiftUI

enum Response: String, CaseIterable {
    case user = "You"
    case aiBot = "AI Bot"
}

struct ChatModel: Identifiable {
    let id = UUID().uuidString
    let responder: Response
    let message: String
    let date: Date
}

struct ChatView: View {
    //MARK: - Properties
    @StateObject var viewModel = ChatViewModel()
    
    private let screenWidth = UIScreen.main.bounds.width
    
    // MARK: - Body
    var body: some View {
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
                            Button(viewModel.dummyQuestions[index]) {
                                viewModel.inspirationRequest(viewModel.dummyQuestions[index])
                            }
                            .roundedButton()
                            .padding()
                        }
                    }
                } else {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: screenWidth - 20))]) {
                        ForEach(viewModel.chat) { chat in
                            ChatCell(sender: chat.responder, message: chat.message, date: chat.date)
                        }
                        .padding([.top], 5)
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
                }
            }
            .dropShadowRoundView()
        }
        .padding(10)
    }
}

// MARK: - ChatViewModel
class ChatViewModel: ObservableObject {
    // Properties
    @Published var userQuery = ""
    @Published var chat = [ChatModel]()
    @Published var showLoadingAnimation = false
    @Published var fetchingData = false
    @Published var animateFetchData = false
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
        "Where are cricket’s ears located?"
    ].shuffled()
    
    let networkManager: ChatNetworkManager = ChatNetworkManager()
    
    // Methods
    func inspirationRequest(_ question: String) {
        userQuery = question
        sendRequest()
    }
    
    func sendRequest() {
        guard !userQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        fetchingData = true
        animateFetchData = true
        
        print("Fetching data, animation set")
        
        chat.append(ChatModel(responder: .user, message: userQuery, date: Date.now))
        
        networkManager.request(userQuery) { response in
            DispatchQueue.main.async {
                self.chat.append(ChatModel(responder: .aiBot, message: response, date: Date.now))
                self.userQuery = ""
                
                self.fetchingData = false
                self.animateFetchData = false
            }
        }
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
