//
//  LoginView.swift
//  Login Screen UI
//
//  Created by Ben Clarke on 25/01/2023.
//

import AuthenticationServices
import SwiftUI

struct LoginView: View {
    private let width = UIScreen.main.bounds.width
        
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            
            Image("login")
                
            HStack {
                Text("Login")
                    .largeTitle()
                
                Spacer()
            }.padding([.leading, .trailing], 20)
            
            HStack {
                Image(systemName: "envelope.fill")
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
            .blueButton()
            
            SignInWithAppleButton(.signIn) { request in
                
            } onCompletion: { result in
                
            }
            .frame(width: width-60, height: 50)
            .font(.system(size: 16))
            
            HStack {
                Text("New to the app?")
                    .foregroundColor(Color("darkBlue"))
                    .font(.system(size: 12, design: .rounded))
                Button("Register") {
                    
                }
                .font(.system(size: 12, design: .rounded))
            }.padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
