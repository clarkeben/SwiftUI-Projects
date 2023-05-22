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
        
    @AppStorage(K.userDefaultKeys.settings.fontSize) var fontSize: Int = 13
    @AppStorage(K.userDefaultKeys.settings.darkModeEnabled) var darkModeEnabled = false

    private let userSettings = UserPreferences.shared
    
    @State private var animateView = false
    
    //MARK: - Body
    var body: some View {
        switch sender {
        case .user:
            HStack(alignment: .top) {
                Text(userSettings.userIcon).font(.largeTitle)
                    .frame(width: 50, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .shadow(radius: 3)
                            .opacity(darkModeEnabled ? 0.4 : 0.2)
                    )
                    .padding(5)
                    .opacity(animateView ? 1 : 0)
                    .offset(x: animateView ? 0 : -120)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("User: \(message)")
                            .font(.system(size: CGFloat(fontSize)-1))
                            .foregroundColor(darkModeEnabled ? .white : .black)
                            .multilineTextAlignment(.leading)
                            .padding(10)
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width-100)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .shadow(radius: 2)
                            .opacity(darkModeEnabled ? 0.4 : 0.2)
                    )
                    Text(date, style: .date)
                        .font(.system(size: 10))
                        .padding(.leading, 5)
                }
                .opacity(animateView ? 1 : 0)
                .offset(x: animateView ? 0 : -100)
            }
            .onAppear() {
                withAnimation(.easeInOut(duration: 0.5)) {
                    animateView = true
                }
            }
            
        case .aiBot:
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("AI Bot: \(message)")
                            .font(.system(size: CGFloat(fontSize)-1))
                            .foregroundColor(darkModeEnabled ? .black : .white)
                            .multilineTextAlignment(.leading)
                            .padding(10)
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width-100)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .shadow(radius: 3)
                            .opacity(darkModeEnabled ? 1.0 : 0.7)
                    )
                    Text(date, style: .date)
                        .font(.system(size: 10))
                        .padding(.leading, 5)
                }
                .opacity(animateView ? 1 : 0)
                .offset(x: animateView ? 0 : 100)
                
                Image("robot-logo2")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .shadow(radius: 5)
                            .opacity(darkModeEnabled ? 1.0 : 0.7)
                    )
                    .padding(5)
                    .opacity(animateView ? 1 : 0)
                    .offset(x: animateView ? 0 : 120)
            }
            .onAppear() {
                withAnimation(.easeInOut(duration: 0.3)) {
                    animateView = true
                }
            }
        }
    }
}

struct ChatCell_Previews: PreviewProvider {
    static var previews: some View {
        ChatCell(sender: .user, message: "Testing whether the string truncates ..... blah blah blah test message here", date: Date.now)
    }
}
