//
//  ChatNetworkManager.swift
//  Chat AI
//
//  Created by Ben Clarke on 16/02/2023.
//

import Foundation
import OpenAISwift

// MARK: - ChatNetworkManager
final class ChatNetworkManager {
    // MARK: - Properties
    private var client: OpenAISwift?
    
    let userPreferences = UserPreferences.shared
    
    init() {
       setUpNetworkManager()
    }
    
    // MARK: - Methods
    func setUpNetworkManager() {
        client = OpenAISwift(authToken: userPreferences.apiKey)
    }
    
    func request(_ text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: userPreferences.maxTokens, completionHandler: { result in
            switch result {
            case .success(let success):
                let modelOutput = success.choices.first?.text ?? ""
                completion(modelOutput)
            case .failure(let error):
                //TODO: - Handle error
                let error = error.localizedDescription
            }
        })
    }
}
