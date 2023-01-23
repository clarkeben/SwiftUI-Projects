//
//  ContentView.swift
//  Login Screen UI
//
//  Created by Ben Clarke on 15/01/2023.
//

import AuthenticationServices
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LoginView().tabItem {
                Text("Login")
            }
            SignupView().tabItem {
                Text("Register")
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
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(Color("darkBlue"))
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
            .frame(width: width-60, height: 50)
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .semibold))
            .background(.blue)
            .cornerRadius(5)
            
            SignInWithAppleButton(.signIn) { request in
                
            } onCompletion: { result in
                
            }
            .frame(width: width-60, height: 50)
            .font(.system(size: 16))
            
            Text("Or, login with..")
                .foregroundColor(.gray)
                .font(.system(size: 12, design: .rounded))
                .padding(40)
            
            HStack {
                Text("New to the app?")
                    .foregroundColor(Color("darkBlue"))
                    .font(.system(size: 12, design: .rounded))
                Button("Register"){
                    
                }
                .font(.system(size: 12, design: .rounded))
            }
        }
    }
}

struct SignupView: View {
    let width = UIScreen.main.bounds.width

    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            
            Image("sign-up2")
                .resizable()
                .frame(width: 150, height: 200)
                
            HStack {
                Text("Register")
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(Color("darkBlue"))
                
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
                   
            }
            .frame(width: width-60, height: 50)
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .semibold))
            .background(.blue)
            .cornerRadius(5)
            
            SignInWithAppleButton(.signUp) { request in
                
            } onCompletion: { result in
                
            }
            .frame(width: width-60, height: 50)
            .font(.system(size: 16))

            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                        Text("Your password needs..")
                            .foregroundColor(.gray)
                            .font(.system(size: 12, design: .rounded))
                    }
                    
                    Text("✅ Include both lower and upper case characters")
                        .foregroundColor(.green)
                        .font(.system(size: 12, design: .rounded))
                        .padding(.top, 5)
                    
                    Text("✅ include at least one number or symbol")
                        .foregroundColor(.green)
                        .font(.system(size: 12, design: .rounded))
                        .padding(.top, 5)
                    
                    
                    Text("✅ be atleast 8 characters long")
                        .foregroundColor(.green)
                        .font(.system(size: 12, design: .rounded))
                        .padding(.top, 5)
                    
                    
                }.padding()
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
