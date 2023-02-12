//
//  ChatView.swift
//  Chat AI
//
//  Created by Ben Clarke on 06/02/2023.
//

import SwiftUI

struct ChatView: View {
    
    private let screenWidth = UIScreen.main.bounds.width
    @State private var userQuery = ""
    
    private let dummyData = ["Hello who are you?", "I am AI", "What do you do?"]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: screenWidth - 20))]) {
                        ForEach(dummyData, id: \.self) { chat in
                            Text(chat)
                        }.padding([.top], 5)
                    }
                }
                
                HStack {
                    TextField("Ask a question?", text: $userQuery, axis: .vertical)
                    Spacer()
                    
                    IconButton(imageName: "paperplane") {
                        
                    }
                }
                .dropShadowRoundView()
            }
            .padding(10)
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    IconButton(imageName: "rectangle.on.rectangle") {
                        
                    }
                })
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    IconButton(imageName: "gear.badge") {
                        
                    }
                })
            }
        }
    }
}

// MARK: - ChatViewModel
class ChatViewModel: ObservableObject {
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
