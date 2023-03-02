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
    @Binding var menuItems: [MenuItem]
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
                MenuContentsView(menuItems: menuItems)
                    .frame(width: width)
                    .offset(x: menuClicked ? 0 : -width)
                    .animation(.default, value: menuClicked)
                
                Spacer()
            }
        }.onAppear(){
            print(menuItems.count)
        }
    }
}

// MARK: - MenuContentView
struct MenuContentsView: View {
    var menuItems = [MenuItem]()
    
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
        let items = Binding.constant([MenuItem(name: "Test 12345", date: Date())])

        SideMenuView(width: 320, menuClicked: true, menuItems: items, toggleMenu: {
            print("Menu toggled")
        })
    }
}
