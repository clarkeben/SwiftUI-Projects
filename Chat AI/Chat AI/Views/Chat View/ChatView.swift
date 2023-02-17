//
//  ChatView.swift
//  Chat AI
//
//  Created by Ben Clarke on 06/02/2023.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var viewModel = ChatViewModel()
    
    private let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: screenWidth - 20))]) {
                    ForEach(viewModel.chat, id: \.self) { chat in
                        Text(chat)
                    }.padding([.top], 5)
                }
            }
            
            HStack {
                TextField("Ask a question?", text: $viewModel.userQuery, axis: .vertical)
                Spacer()
                
                IconButton(imageName: "paperplane") {
                    
                }
            }
            .dropShadowRoundView()
        }
        .padding(10)
    }
}

// MARK: - ChatViewModel
class ChatViewModel: ObservableObject {
    @Published var userQuery = ""
    @Published var chat = [String]()
    
    let networkManager: ChatNetworkManager = ChatNetworkManager()
    
    func sendRequest() {
        guard !userQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        networkManager.request(userQuery) { response in
            DispatchQueue.main.async {
                self.chat.append(response)
                self.userQuery = ""
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
