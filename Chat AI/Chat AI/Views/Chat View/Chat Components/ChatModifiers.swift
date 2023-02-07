//
//  ChatModifiers.swift
//  Chat AI
//
//  Created by Ben Clarke on 07/02/2023.
//

import Foundation
import SwiftUI

// MARK: - ViewModifiers
struct TextfieldShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.white)
            .cornerRadius(16)
            .clipped()
            .shadow(color: .gray, radius: 7)
    }
}

// MARK: - View Extensions
extension View {
    func dropShadowRoundView() -> some View {
        modifier(TextfieldShadowModifier())
    }
}
