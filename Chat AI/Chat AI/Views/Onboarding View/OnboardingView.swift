//
//  OnboardingView.swift
//  Chat AI
//
//  Created by Ben Clarke on 13/02/2023.
//

import AuthenticationServices
import SwiftUI

struct OnboardingView: View {
    //MARK: - Properties
    @State private var apiKey = ""
    @State private var animateView = false
    
    private let screenHeight = UIScreen.main.bounds.height
    
    //MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            Image("robot-logo2")
                .resizable()
                .frame(height: 200)
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 4)
                .opacity(animateView ? 1 : 0)
                .offset(y: animateView ? 0 : -100)
                .animation(.easeInOut(duration: 1.0).delay(0.2), value: animateView)
            
            Text("Welcome to Chat AI")
                .font(.largeTitle)
                .padding(.bottom, 5)
                .foregroundColor(.gray)
                .bold()
                .opacity(animateView ? 1 : 0)
                .offset(y: animateView ? 0 : -80)
                .animation(.easeInOut(duration: 1.0).delay(0.4), value: animateView)
            
            Text("Powered by GPT-3 API, engaging natural conversations with our AI chatbot.")
                .font(.subheadline)
                .padding(.horizontal, 10)
                .opacity(animateView ? 1 : 0)
                .offset(y: animateView ? 0 : -60)
                .animation(.easeInOut(duration: 1.0).delay(0.6), value: animateView)
            
            Spacer()
            
            Text("Enter API Key:")
                .font(.subheadline)
            
            TextField("Enter API Key", text: $apiKey)
                .dropShadowRoundView()
                .padding(10)
            
            Button("Submit") {
                
            }.roundedButton()
            
            Link("Click to generate API Key", destination: URL(string: "https://help.openai.com/en/articles/4936850-where-do-i-find-my-secret-api-key")!)
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.vertical, 10)
        }
        .onAppear() {
            animateView = true
        }
    }
}

//MARK: - ViewModel
class OnboardingViewModel: ObservableObject {
    // Properties
    @Published var apiKey = ""
    
    // Methods
    private func saveAPIKey() {
        if apiKey != "" {
            KeychainWrapper.standard.set(apiKey, forKey: K.Keychain.apiKey)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
