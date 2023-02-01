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
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
        
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Register")
                    .font(.title)
                    .padding(5)
                
                Text("Please create a secure password including the following criteria below")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(5)
                
                HStack {
                    if viewModel.showPassword {
                        TextField("Password", text: $viewModel.passwordText)
                    } else {
                        SecureField("Password", text: $viewModel.passwordText)
                    }
                    Spacer()
                    Button {
                        withAnimation() {
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
                
                LazyVGrid(columns: columns, spacing: 10) {
                    PasswordGridItem(itemName: "12 Chars", isValidated: $viewModel.isOver12Chars)
                    PasswordGridItem(itemName: "1 Capital", isValidated: $viewModel.containsCapLetters)
                    PasswordGridItem(itemName: "1 Number", isValidated: $viewModel.containsNumbers)
                    PasswordGridItem(itemName: "1 Special Char", isValidated: $viewModel.containsSpecChars)
                    PasswordGridItem(itemName: "1 Dash", isValidated: $viewModel.containsDash)
                }.padding(5)
                
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
    @Published var containsDash = false
    
    // Methods
    func validatePassword() {
        isOver12Chars = passIsOver12Characters(passwordText)
        containsCapLetters = passContainsCapitalLetter(passwordText)
        containsNumbers = passContainsNumbers(passwordText)
        containsSpecChars = passContainsSpecialCharacters(passwordText)
        containsDash = passContainsDash(passwordText)
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
    
    private func passContainsDash(_ password: String) -> Bool {
        let dashRegex = ".*[-].*"
        return NSPredicate(format: "SELF MATCHES %@", dashRegex).evaluate(with: password)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
