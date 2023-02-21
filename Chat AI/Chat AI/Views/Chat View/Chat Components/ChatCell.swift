//
//  ChatCell.swift
//  Chat AI
//
//  Created by Ben Clarke on 21/02/2023.
//

import SwiftUI

struct ChatCell: View {
    //MARK: - Properties
    let sender: Response
    let message: String
    
    //MARK: - Body
    var body: some View {
        switch sender {
        case .user:
                HStack(alignment: .top) {
                    Text("👨🏽").font(.largeTitle)
                        .frame(width: 50, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .shadow(radius: 5)
                                .opacity(0.6)
                        )
                        .padding(5)
                    
                    Text(message)
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(width: UIScreen.main.bounds.width-100)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.black)
                                .shadow(radius: 5)
                        )
                }
            
        case .aiBot:
            HStack(alignment: .top) {
                Image("robot-logo2")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.purple)
                            .shadow(radius: 5)
                            .opacity(0.6)
                    )
                    .padding(5)
                
                
                Text("AI Bot: This is a long string example with the various types of strings that there are and there are multiple strings that can be used for multiple purplsed")
                    .foregroundColor(.white)
                    .padding(10)
                    .frame(width: UIScreen.main.bounds.width-100)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .shadow(radius: 5)
                    )
            }
        }
    }
}

struct ChatCell_Previews: PreviewProvider {
    static var previews: some View {
        ChatCell(sender: .user, message: "AI BOT MESSAGE")
    }
}
