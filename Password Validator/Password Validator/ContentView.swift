//
//  ContentView.swift
//  Password Validator
//
//  Created by Ben Clarke on 27/01/2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @ObservedObject private var viewModel = PasswordValidatorViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Register")
                    .font(.title)
                
                Text("Please create a secure password including the following criteria below")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                HStack {
                    if viewModel.showPassword {
                        TextField("Password", text: $viewModel.passwordText)
                    } else {
                        SecureField("Password", text: $viewModel.passwordText)
                    }
                    Spacer()
                    Button {
                        withAnimation(.easeInOut) {
                            viewModel.showPassword.toggle()
                        }
                    } label: {
                        Image(systemName: viewModel.showPassword ? "eye" : "eye.slash.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding(10)
                .border(.gray)
                .cornerRadius(2)
                
                
                //TODO: - Add password validation fields
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 20, height: 30)
                    }
                    .frame(width: 60, height: 60)
                    .background(.purple)
                    .clipShape(Circle())
                }
            }
            .padding(10)
            .navigationTitle("Register")
            .onChange(of: viewModel.passwordText) { newValue in
                viewModel.validatePassword()
            }
        }
    }
}

// MARK: - PasswordValidator View Model
class PasswordValidatorViewModel: ObservableObject {
    // Properties
    @Published var passwordText = ""
    @Published var showPassword = false
    
    @Published var isOver12Chars = false
    @Published var containsCapLetters = false
    @Published var containsNumbers = false
    @Published var containsSpecChars = false
    
    // Methods
    func validatePassword() {
        isOver12Chars = passIsOver12Characters(passwordText)
        containsCapLetters = passContainsCapitalLetter(passwordText)
        containsNumbers = passContainsNumbers(passwordText)
        containsSpecChars = passContainsSpecialCharacters(passwordText)
    }
    
    /// Check that the password is over 12 characters long
    private func passIsOver12Characters(_ password: String) -> Bool {
        if password.count >= 12 {
            return true
        } else {
            return false
        }
    }
    
    /// Check that the password contains one capital letter
    private func passContainsCapitalLetter(_ password: String) -> Bool {
        let capitalLetterRegex = ".*[A-Z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", capitalLetterRegex).evaluate(with: password)
    }
    
    /// Check that the password contains one number
    private func passContainsNumbers(_ password: String) -> Bool {
        let numberRegex = ".*[0-9]+.*"
        return NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: password)
    }
    
    /// Check that the password contains a special character
    private func passContainsSpecialCharacters(_ password: String) -> Bool {
        let specialCharRegex = ".*[^A-Za-z0-9].*"
        return NSPredicate(format: "SELF MATCHES %@", specialCharRegex).evaluate(with: password)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
