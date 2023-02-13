//
//  OnboardingView.swift
//  Chat AI
//
//  Created by Ben Clarke on 13/02/2023.
//

import SwiftUI

struct OnboardingView: View {
    //MARK: - Properties
    @State private var apiKey = ""
    
    //MARK: - Body
    var body: some View {
        VStack {
            Section {
                Text("TITLE")
                Text("Subtitle")
            }
            Section("API Key") {
                TextField("Enter API Key", text: $apiKey)
                    .dropShadowRoundView()
                    .padding(10)
                Button {
                    
                } label: {
                    Text("Submit")
                }

            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
