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
    
    private let userPreferences = UserPreferences.shared
    private var selectedModel = OpenAIModelType.GPT3.davinci

    init() {
       setUpNetworkManager()
    }
    
    // MARK: - Methods
    func setUpNetworkManager() {
        client = OpenAISwift(authToken: userPreferences.apiKey)
        
        switch userPreferences.model {
        case "davinci": selectedModel = OpenAIModelType.GPT3.davinci
        case "curie": selectedModel = OpenAIModelType.GPT3.curie
        case "babbage": selectedModel = OpenAIModelType.GPT3.babbage
        case "ada": selectedModel = OpenAIModelType.GPT3.ada
        default: selectedModel = OpenAIModelType.GPT3.davinci
        }
    }
    
    func request(_ text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, model: .gpt3(selectedModel), maxTokens: userPreferences.maxTokens, completionHandler: { result in
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
