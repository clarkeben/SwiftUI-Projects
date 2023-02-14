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
    
    private let screenHeight = UIScreen.main.bounds.height
    
    //MARK: - Body
    var body: some View {
        VStack {
            Image("robot")
                .resizable()
                .scaledToFill()
                .frame(height: screenHeight/4)
            
            Spacer()
            
            Text("Welcome...")
                .font(.largeTitle)
            
            Text("Subtitle")
                .font(.subheadline)
            
            TextField("Enter API Key", text: $apiKey)
                .dropShadowRoundView()
                .padding(10)
            
            Button {
                
            } label: {
                Text("Submit")
            }
            
            Spacer()
            
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
