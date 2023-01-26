//
//  Modifiers.swift
//  Login Screen UI
//
//  Created by Ben Clarke on 25/01/2023.
//

import SwiftUI

// MARK: - ViewModifiers

// Large Onboarding Title
struct LargeOnboardingTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.largeTitle, design: .rounded))
            .foregroundColor(Color("darkBlue"))
    }
}

// Blue Onboarding Button
struct BlueButtonOnboarding: ViewModifier {
    private let width = UIScreen.main.bounds.width
    
    func body(content: Content) -> some View {
        content
            .frame(width: width-60, height: 50)
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .semibold))
            .background(.blue)
            .cornerRadius(5)
    }
}

// MARK: -  View Extensions
extension View {
    /// Large text modifier with a rounded design and a dark blue colour
    func largeTitle() -> some View {
        modifier(LargeOnboardingTitleModifier())
    }
    
    /// Rounded blue button modifier with white text and a slight corner radius
    func blueButton() -> some View {
        modifier(BlueButtonOnboarding())
    }
}
