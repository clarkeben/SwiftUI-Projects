//
//  ViewModifiers.swift
//  Chat AI
//
//  Created by Ben Clarke on 15/02/2023.
//

import SwiftUI

// MARK: - ViewModifiers
struct RoundedButtonViewModifier: ViewModifier {
    private let width = UIScreen.main.bounds.width
    
    func body(content: Content) -> some View {
        content
            .frame(width: width-80, height: 40)
            .foregroundColor(.white)
            .font(.system(size: 12, weight: .semibold))
            .background(.black)
            .cornerRadius(10)
    }
}

// MARK: -  View Extensions
extension View {
    func roundedButton() -> some View {
        modifier(RoundedButtonViewModifier())
    }
}
