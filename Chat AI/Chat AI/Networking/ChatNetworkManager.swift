//
//  ChatNetworkManager.swift
//  Chat AI
//
//  Created by Ben Clarke on 16/02/2023.
//

import Foundation
import OpenAISwift

//class ChatNetworkManager {
//
//    // MARK: - Properties
//    let openAIURL = URL(string: "")
//    var apiKey: String {
//        guard let apiKey = KeychainWrapper.standard.string(forKey: K.Keychain.apiKey) else { return "" }
//        return apiKey
//    }
//
//    func request(request: URLRequest, withSessConfig sessionConfig: URLSessionConfiguration?) -> Data? {
//        let session: URLSession
//        var requestData: Data?
//
//        let task = session.dataTask(with: request as URLRequest) { Data?, URLResponse?, Error? in
//            <#code#>
//        }
//    }
//
//}

struct UserPreferences {
    var apiKey: String {
        guard let apiKey = KeychainWrapper.standard.string(forKey: K.Keychain.apiKey) else { return "" }
        return apiKey
    }
    var maxTokens: Int
}

final class ChatNetworkManager {
    // MARK: - Properties
    static let shared = ChatNetworkManager()
    
    private var client: OpenAISwift?
    
    private let userDefaults = UserDefaults.standard
    
    var apiKey: String {
        guard let apiKey = KeychainWrapper.standard.string(forKey: K.Keychain.apiKey) else { return "" }
        return apiKey
    }
    
    var maxTokens: Int {
        let maxTokens = UserDefaults.standard.integer(forKey: K.userDefaultKeys.settings.maxToken)
        if maxTokens == 0 {
            return 500
        } else {
            return maxTokens
        }
    }
    
    init() {
       setUpNetworkManager()
    }
    
    // MARK: - Methods
    func setUpNetworkManager() {
        client = OpenAISwift(authToken: apiKey)
    }
    
    func request(_ text: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: maxTokens, completionHandler: { result in
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
