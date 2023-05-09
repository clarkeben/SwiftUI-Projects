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
            Image(K.images.logo)
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
            
            RegularButton("Submit") {
                viewModel.showOnboarding = viewModel.saveAPIKey()
            }
            
            Link("Click to generate API Key", destination: URL(string: K.URLs.findAPIKey)!)
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.vertical, 10)
        }
        .alert("Error 🤖", isPresented: $viewModel.showErrorAlert, actions: {
            Button("OK", role: .cancel, action: {})
        }, message: {
            Text("Please ensure that you have added your API key, if not you can obtain a new key by clicking the link below!")
        })
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
    @Published var showErrorAlert = false
    
    @AppStorage(K.userDefaultKeys.showOnboarding) var showOnboarding = true
    
    // Methods
    func saveAPIKey() -> Bool {
        if apiKey != "" {
            KeychainWrapper.standard.set(apiKey, forKey: K.Keychain.apiKey)
            ChatNetworkManager.shared.updateClient(with: apiKey)
            updateRelatedChat()
            return false
        } else {
            showErrorAlert = true
            return true
        }
    }
    
    /// Method to set the related chat userdefault value as true when the app loads for the first time - doing this feeds in the previous conversation to GPT so users have a related conversation
    private func updateRelatedChat() {
        UserDefaults.standard.set(true, forKey: K.userDefaultKeys.settings.enabledRelatedChat)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
