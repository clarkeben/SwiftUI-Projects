//
//  UserPreferences.swift
//  Chat AI
//
//  Created by Ben Clarke on 21/02/2023.
//

import Foundation

// MARK: - User Preferences
struct UserPreferences {
    // Properties
    static let shared = UserPreferences()
    
    private let keychain = KeychainWrapper.standard
    private let userDefaults = UserDefaults.standard
    
    // Computed Properties
    var apiKey: String {
        guard let apiKey = keychain.string(forKey: K.Keychain.apiKey) else { return "" }
        return apiKey
    }
    
    var model: String {
        guard let model = userDefaults.string(forKey: K.userDefaultKeys.settings.model) else { return "davinci" }
        return model
    }
        
    var maxTokens: Int {
        let maxTokens = userDefaults.integer(forKey: K.userDefaultKeys.settings.maxToken)
        if maxTokens == 0 {
            return 500
        } else {
            return maxTokens
        }
    }
    
    var userIcon: String {
        guard let userIcon = userDefaults.string(forKey: K.userDefaultKeys.settings.userIcon) else { return "😎" }
        return userIcon
    }
}
