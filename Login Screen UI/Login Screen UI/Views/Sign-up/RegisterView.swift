//
//  RegisterView.swift
//  Login Screen UI
//
//  Created by Ben Clarke on 25/01/2023.
//

import AuthenticationServices
import SwiftUI

struct RegisterView: View {
    //MARK: - Properties
    let width = UIScreen.main.bounds.width
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordIsValid = false
    
    //MARK: - Views
    var body: some View {
        VStack {
            
            Image("register")
                .resizable()
                .frame(width: 150, height: 250)
            
            HStack {
                Text("Register")
                    .largeTitle()
                
                Spacer()
            }.padding([.leading, .trailing], 20)
            
            HStack {
                Image(systemName: "person.fill")
                TextField("Name", text: $name)
            }
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(.gray)
            .padding([.leading, .trailing], 20)
            .padding(.bottom, 10)
            
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
            }
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 1).padding(.top, 35))
            .foregroundColor(.gray)
            .padding([.leading, .trailing], 20)
            .padding(.bottom, 10)
            
            Button("Register") {
                //TODO: - Register User
            }
            .blueButton()
            
            //TODO: - Handle signup with Apple
            SignInWithAppleButton(.signUp) { request in } onCompletion: { result in }
            .frame(width: width-60, height: 50)
            .font(.system(size: 16))
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
