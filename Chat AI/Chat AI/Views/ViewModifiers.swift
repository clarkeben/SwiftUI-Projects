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
    let size: Int
    
    func body(content: Content) -> some View {
        content
            .frame(width: width-80, height: 40)
            .foregroundColor(.white)
            .font(.system(size: CGFloat(size), weight: .semibold))
            .background(.black)
            .cornerRadius(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
    }
}

struct TextfieldShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.white)
            .cornerRadius(16)
            .clipped()
            .shadow(color: .gray, radius: 4)
    }
}

// MARK: -  View Extensions
//TODO: - Add markup for the viewModifiers explaining the styling 
extension View {
    func roundedButton(size: Int) -> some View {
        modifier(RoundedButtonViewModifier(size: size))
    }
    
    func dropShadowRoundView() -> some View {
        modifier(TextfieldShadowModifier())
    }
}
