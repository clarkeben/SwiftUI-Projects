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
            static let fontSize = "fontSize"
        }
    }
    
    enum URLs {
        static let findAPIKey = "https://help.openai.com/en/articles/4936850-where-do-i-find-my-secret-api-key"
        static let github = "https://github.com/clarkeben"
    }
    
    enum Links {
        static let gitHub = "https://github.com/clarkeben"
        static let instagramURL = "https://instagram.com/vikingskullapps"
        static let websiteURL = "https://vikingskullapps.com"
        static let contactURL = "https://vikingskullapps.com/contact-me/"
        static let butMeACoffeeURL = "https://www.buymeacoffee.com/clarkeben"
        static let quotoURL = "https://apps.apple.com/gb/app/quoto-inspirational-quotes/id1549455648"
        static let privacyPolicyURL = "https://vikingskullapps.com/apps/muay-thai-app/privacy-policy/"
        static let termsConditionsURL = "https://vikingskullapps.com/apps/muay-thai-app/terms-conditions/"
    }
}
