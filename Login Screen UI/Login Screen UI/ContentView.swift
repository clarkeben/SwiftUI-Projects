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
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
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
