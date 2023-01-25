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
            RegisterView().tabItem {
                Text("Register")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
