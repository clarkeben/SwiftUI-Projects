//
//  ContentView.swift
//  Login Screen UI
//
//  Created by Ben Clarke on 15/01/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LoginView().tabItem {
                Text("Login")
            }
            SignupView().tabItem {
                Text("Signup")
            }
        }
    }
}

struct LoginView: View {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            
            Image("login")
            
            HStack {
                Text("Login")
                    .font(.title)
                Spacer()
            }.padding([.leading, .trailing], 20)
            
            HStack {
                Image(systemName: "lock.fill")
                TextField("Email", text: $email)
            }
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(.gray)
            .padding([.leading, .trailing], 20)
            .padding(.bottom, 10)
            
            HStack {
                Image(systemName: "lock.fill")
                SecureField("Password", text: $password)
                Text("Forgot?").foregroundColor(.blue)
            }
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(.gray)
            .padding([.leading, .trailing], 20)
            .padding(.bottom, 20)
            
            Button("Login") {
                ///Action
            }
            .frame(width: width-60, height: 50)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(10)
            
            
            Text("Or, login with..")
                .foregroundColor(.gray)
                .padding(40)
            
            HStack {
                Text("New to the app?")
                Button("Register"){
                    
                }
            }
        }
    }
}

struct SignupView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button {
                ///Action
            } label: {
                Text("Login")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
