//
//  SideMenuView.swift
//  Chat AI
//
//  Created by Ben Clarke on 24/02/2023.
//

import SwiftUI

// MARK: - SideMenuView
struct SideMenuView: View {
    let width: CGFloat
    let menuClicked: Bool
    let toggleMenu: () -> Void
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .blur(radius: 20)
            .opacity(menuClicked ? 1 : 0)
            .animation(Animation.easeIn.delay(0.25), value: menuClicked)
            .onTapGesture {
                toggleMenu()
            }
            
            HStack {
                MenuContentsView()
                    .frame(width: width)
                    .offset(x: menuClicked ? 0 : -width)
                    .animation(.default, value: menuClicked)
                
                Spacer()
            }
        }
    }
}

// MARK: - MenuContentView
struct MenuContentsView: View {
    let menuItems: [MenuItem] = [
        MenuItem(name: "Testing chat length ... test test test, Testing chat length ... test test test, Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test, Testing chat length ... test test test, Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now),
        MenuItem(name: "Testing chat length ... test test test", date: .now)
    ]
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Chat History")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.gray)
                
                Divider()
                
                ScrollView {
                    ForEach(menuItems) { menuItem in
                        HStack {
                            Image(systemName: "message")
                            Text(menuItem.name)
                                .font(.system(size: 12))
                                .lineLimit(2)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }.padding(10)
                    }
                }
                Spacer()
            }
        }
    }
}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(width: 320, menuClicked: true, toggleMenu: {
            print("Menu toggled")
        })
    }
}
