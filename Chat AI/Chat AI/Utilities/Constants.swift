//
//  Constants.swift
//  Chat AI
//
//  Created by Ben Clarke on 14/02/2023.
//

import Foundation

enum K {
    enum Keychain {
        static let apiKey = "APIKey"
    }
    
    enum userDefaultKeys {
        static let showOnboarding = "showOnboarding"
        
        enum settings {
            static let maxToken = "maxTokens"
            static let model = "model"
            static let userIcon = "userIcon"
        }
    }
    
    enum URLs {
        static let findAPIKey = "https://help.openai.com/en/articles/4936850-where-do-i-find-my-secret-api-key"
        static let github = "https://github.com/clarkeben"
    }
}
