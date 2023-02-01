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
    
    //MARK: - Body
    var body: some View {
        Text(isValidated ? "✓ \(itemName)" : itemName)
            .font(.system(size: 12))
            .foregroundColor(isValidated ? Color("PassGridTxtColour") : Color.secondary)
            .frame(width: screenWidth/3-10, height: 30)
            .background(Capsule().fill(isValidated ? Color("PassGridBgColour") : Color.gray.opacity(0.5)))
    }
}

struct PasswordGridItem_Previews: PreviewProvider {
    static var previews: some View {
        PasswordGridItem(itemName: "12 Chars", isValidated: .constant(true))
    }
}
