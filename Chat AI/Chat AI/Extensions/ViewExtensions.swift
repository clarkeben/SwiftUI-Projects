//
//  ViewExtensions.swift
//  Chat AI
//
//  Created by Ben Clarke on 24/02/2023.
//

import Foundation
import SwiftUI
import StoreKit

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    public func rateApp() {
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
    }
    
    public func openURL(url: String) {
        guard let urlToOpen = URL(string: url) else { return }
        UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil)
    }
}

