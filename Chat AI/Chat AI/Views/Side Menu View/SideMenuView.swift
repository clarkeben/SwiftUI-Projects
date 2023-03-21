//
//  SideMenuView.swift
//  Chat AI
//
//  Created by Ben Clarke on 24/02/2023.
//

import CoreData
import SwiftUI

// MARK: - SideMenuView
struct SideMenuView: View {
    let context: NSManagedObjectContext
    var chatConvos: FetchedResults<Chat>
    
    let width: CGFloat
    let menuClicked: Bool
        
    @Binding var selectedConversation: Chat?
    @Binding var messageDeleted: Bool
    
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
                        
                        if chatConvos.isEmpty {
                            Text("No conversations have been saved!")
                                .font(.system(size: 12))
                                .padding(10)
                        } else {
                            List {
                                ForEach(chatConvos) { menuItem in
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Image(systemName: "message")
                                            Text(menuItem.unwrappedTitle)
                                                .font(.system(size: 12))
                                                .lineLimit(2)
                                                .foregroundColor(.black)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                        .padding(10)
                                        Text(menuItem.unwrappedDate, style: .date)
                                            .font(.system(size: 10))
                                            .padding(.leading, 10)
                                    }
                                    .onTapGesture {
                                        selectedConversation = menuItem
                                    }
                                }
                                .onDelete { indexSet in
                                   deleteMessage(offsets: indexSet)
                                }
                            }
                            .listStyle(.plain)
                        }

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
    
    private func deleteMessage(offsets: IndexSet) {
        withAnimation {
            offsets.map { chatConvos[$0] }.forEach(context.delete)
            PersistenceController.shared.save()
            messageDeleted = true
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


//struct SideMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        let items = Binding.constant([MenuItem(name: "Test 12345", date: Date())])
//        let indexSet = Binding.constant(IndexSet(integer: 1))
//        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//
//        SideMenuView(context: context, chatConvos: <#FetchedResults<Chat>#>, width: 320, menuClicked: true, menuItems: items, itemToDelete: indexSet, selectedMenuItem: .constant(MenuItem(name: "Test", date: Date())), toggleMenu: {
//            print("Menu toggled")
//        }, deleteBtnClicked: {
//            print("Delete all")
//        })
//    }
//}
