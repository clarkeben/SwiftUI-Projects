//
//  ChatModel.swift
//  Chat AI
//
//  Created by Ben Clarke on 24/02/2023.
//

import Foundation

enum Response: String, CaseIterable {
    case user = "You"
    case aiBot = "AI Bot"
}

struct ChatModel: Identifiable {
    let id = UUID().uuidString
    let responder: Response
    let message: String
    let date: Date
}
