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
    let date: Date
    
    //MARK: - Body
    var body: some View {
        switch sender {
        case .user:
            HStack(alignment: .top) {
                Text("👨🏽").font(.largeTitle)
                    .frame(width: 50, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .shadow(radius: 3)
                            .opacity(0.4)
                    )
                    .padding(5)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("User: \(message)")
                            .font(.system(size: 13))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding(10)
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width-100)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .shadow(radius: 2)
                            .opacity(0.2)
                    )
                    Text(date, style: .date)
                        .font(.system(size: 10))
                        .padding(.leading, 5)
                }
            }
            
        case .aiBot:
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("AI Bot: \(message)")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(10)
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width-100)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .shadow(radius: 3)
                            .opacity(0.7)
                    )
                    Text(date, style: .date)
                        .font(.system(size: 10))
                        .padding(.leading, 5)
                }
                
                Image("robot-logo2")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .shadow(radius: 5)
                            .opacity(0.7)
                    )
                    .padding(5)
            }
        }
    }
}

struct ChatCell_Previews: PreviewProvider {
    static var previews: some View {
        ChatCell(sender: .aiBot, message: "Testing whether the string truncates ..... blah blah blah test message here", date: Date.now)
    }
}
