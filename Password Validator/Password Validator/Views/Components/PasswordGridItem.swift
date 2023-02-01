//
//  PasswordGridItem.swift
//  Password Validator
//
//  Created by Ben Clarke on 01/02/2023.
//

import SwiftUI

struct PasswordGridItem: View {
    //MARK: - Properties
    var itemName: String
    @Binding var isValidated: Bool
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Text(isValidated ? "✓ \(itemName)" : itemName)
                .font(.system(size: 12))
                .foregroundColor(isValidated ? Color("PassGridTxtColour") : Color.secondary)
                .frame(width: screenWidth/3-10, height: 30)
                .background(Capsule().fill(isValidated ? Color("PassGridBgColour") : Color.gray.opacity(0.5)))
                .animation(.easeInOut, value: isValidated)
            
            ForEach(0..<6) { item in
                StarView()
                    .position(x: CGFloat.random(in: 1...80), y: CGFloat.random(in: 1...80))
                    .rotationEffect(Angle(degrees: Double.random(in: 0...360)))
                    .scaleEffect(isValidated ? 0.0 : 1.0)
                    .animation(.easeInOut(duration: 0.4), value: isValidated)
                    .opacity(isValidated ? 0.9 : 0.0)
            }
        }
    }
}

struct PasswordGridItem_Previews: PreviewProvider {
    static var previews: some View {
        PasswordGridItem(itemName: "12 Chars", isValidated: .constant(true))
    }
}
