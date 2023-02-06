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
                    Button {
                        // USER PRESSED SEND
                    } label: {
                        Image(systemName: "paperplane")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(16)
                .clipped()
                .shadow(color: .gray, radius: 7)
            }
            .padding(10)
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button {
                        
                    } label: {
                        //TODO: - Create a viewmodifier for this
                        Image(systemName: "rectangle.on.rectangle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                })
                
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button {
                        
                    } label: {
                        //TODO: - Create a viewmodifier for this
                        Image(systemName: "sparkle.magnifyingglass")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                })
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
