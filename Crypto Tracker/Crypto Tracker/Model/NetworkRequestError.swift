//
//  NetworkRequestError.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 08/11/2023.
//

import Foundation

enum NetworkRequestError: Error {
    case invalidURL
    case requestFailed
    case invalidStatusCode(statusCode: Int)
    case parsingFailed
    
    var description: String {
        switch self {
        case .invalidURL: return "Error fetching the data as the URL is invalid"
        case .requestFailed: return "Request failed, please check internet connection and try again"
        case .parsingFailed: return "Error parsing the JSON data"
        case .invalidStatusCode(let statusCode): return "Invalid status code \(statusCode)"
        }
    }
}
