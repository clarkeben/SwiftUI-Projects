//
//  ViewModifiers.swift
//  Chat AI
//
//  Created by Ben Clarke on 15/02/2023.
//

import SwiftUI

// MARK: - ViewModifiers
struct RoundedButtonViewModifier: ViewModifier {
    //MARK: - Properties
    @AppStorage(K.userDefaultKeys.settings.darkModeEnabled) var darkModeEnabled = false
    
    private let width = UIScreen.main.bounds.width
    let size: Int
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: width-80, minHeight: 40)
            .foregroundColor(darkModeEnabled ? .black : .white)
            .font(.system(size: CGFloat(size-2), weight: .semibold))
            .background(darkModeEnabled ? .white : .black)
            .cornerRadius(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(darkModeEnabled ? .white : .black)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
    }
}

struct TextfieldShadowModifier: ViewModifier {
    @AppStorage(K.userDefaultKeys.settings.darkModeEnabled) var darkModeEnabled = false

    func body(content: Content) -> some View {
        content
            .padding()
            .background(darkModeEnabled ? .black : .white)
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
