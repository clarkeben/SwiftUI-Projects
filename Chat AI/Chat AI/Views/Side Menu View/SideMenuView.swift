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
    @Binding var itemToDelete: IndexSet
    
    let toggleMenu: () -> Void
    var deleteBtnClicked: () -> Void
    
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
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Text("Chat History")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        Divider()
                            
                        List {
                            ForEach(menuItems) { menuItem in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "message")
                                        Text(menuItem.name)
                                            .font(.system(size: 12))
                                            .lineLimit(2)
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    .padding(10)
                                    Text(menuItem.date, style: .date)
                                        .font(.system(size: 10))
                                        .padding(.leading, 10)
                                }
                            }
                            .onDelete { indexSet in
                                menuItems.remove(atOffsets: indexSet)
                                itemToDelete = indexSet
                            }
                        }
                        .listStyle(.plain)
                        Spacer()
                        
                        ActionButton(width: width-40, systemIcon: "trash", title: "Clear All Message") {
                            deleteBtnClicked()
                        }
                    }
                }
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
                    }.onDelete { indexSet in
                        print(indexSet)
                        //menuItems.remove(atOffsets: indexSet)
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
        let indexSet = Binding.constant(IndexSet(integer: 1))
        
        SideMenuView(width: 320, menuClicked: true, menuItems: items, itemToDelete: indexSet, toggleMenu: {
            print("Menu toggled")
        }, deleteBtnClicked: {
            print("Delete all")
        })
    }
}
