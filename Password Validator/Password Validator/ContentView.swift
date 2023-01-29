//
//  ContentView.swift
//  Password Validator
//
//  Created by Ben Clarke on 27/01/2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var passwordText = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Register")
                    .font(.title)
                
                Text("Please create a secure password including the following criteria below")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                HStack {
                    TextField("Password", text: $passwordText)
                    Spacer()
                    Image(systemName: "eye")
                        .foregroundColor(.gray)
                }
                .padding(10)
                .border(.gray)
                .cornerRadius(2)

                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 40)
                    }
                    .frame(width: 60, height: 60)
                    .background(.purple)
                    .clipShape(Circle())
                }
            }
            .padding(10)
            .navigationTitle("Register")
        }
    }
}

// MARK: - PasswordValidator View Model
class PasswordValidatorViewModel: ObservableObject {
    // Properties
    @Published var passwordText = ""
    @Published var showPassword = false
    
    
    
    // Methods
    /// Check that the password is over 12 characters long
    private func isOver12Characters(_ password: String) -> Bool {
        if password.count >= 12 {
            return true
        } else {
            return false
        }
    }
    
    /// Check that the password contains one capital letter
    private func containsCapitalLetter() -> Bool {
         
        return false
    }
    
    /// Check that the password contains one number
    private func containsNumbers() -> Bool {
        
        return false
    }
    
    /// Check that the password contains a special character
    private func containsSpecialCharacters() -> Bool {
        
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
