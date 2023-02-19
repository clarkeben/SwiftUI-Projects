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
    @StateObject var viewModel = OnboardingViewModel()
    
    //MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            Image("robot-logo2")
                .resizable()
                .frame(width: 200, height: 180)
                .aspectRatio(contentMode: .fit)
                .shadow(radius: 4)
                .opacity(viewModel.animateView ? 1 : 0)
                .offset(y: viewModel.animateView ? 0 : -100)
                .animation(.easeInOut(duration: 1.0).delay(0.2), value: viewModel.animateView)
            
            Text("Welcome to Chat AI")
                .font(.largeTitle)
                .padding(.bottom, 5)
                .foregroundColor(.gray)
                .bold()
                .opacity(viewModel.animateView ? 1 : 0)
                .offset(y: viewModel.animateView ? 0 : -80)
                .animation(.easeInOut(duration: 1.0).delay(0.4), value: viewModel.animateView)
            
            Text("Powered by GPT-3 API, engaging natural conversations with our AI chatbot.")
                .font(.subheadline)
                .padding(.horizontal, 10)
                .opacity(viewModel.animateView ? 1 : 0)
                .offset(y: viewModel.animateView ? 0 : -60)
                .animation(.easeInOut(duration: 1.0).delay(0.6), value: viewModel.animateView)
            
            Spacer()
            
            Text("Enter API Key:")
                .font(.subheadline)
            
            TextField("Enter API Key", text: $viewModel.apiKey)
                .dropShadowRoundView()
                .padding(10)
            
            Button("Submit") {
                //TODO: - Handle error message!
                viewModel.showOnboarding = viewModel.saveAPIKey()
            }.roundedButton()
            
            Link("Click to generate API Key", destination: URL(string: "https://help.openai.com/en/articles/4936850-where-do-i-find-my-secret-api-key")!)
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.vertical, 10)
        }
        .onAppear() {
            viewModel.animateView = true
        }
    }
}

//MARK: - ViewModel
class OnboardingViewModel: ObservableObject {
    // Properties
    @Published var apiKey = ""
    @Published var animateView = false
    
    @AppStorage(K.userDefaultKeys.showOnboarding) var showOnboarding = true
    
    // Methods
    func saveAPIKey() -> Bool {
        if apiKey != "" {
            KeychainWrapper.standard.set(apiKey, forKey: K.Keychain.apiKey)
            return false
        } else {
            return true
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
