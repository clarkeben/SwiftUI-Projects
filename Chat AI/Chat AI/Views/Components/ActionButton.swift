//
//  ActionButton.swift
//  Chat AI
//
//  Created by Ben Clarke on 28/02/2023.
//

import SwiftUI

struct ActionButton: View {
    //MARK: - Properties
    @AppStorage(K.userDefaultKeys.settings.darkModeEnabled) var darkModeEnabled = false

    var width: CGFloat = 150
    var systemIcon: String
    var title: String
    var action: () -> Void
    
    @AppStorage(K.userDefaultKeys.settings.fontSize) var fontSize = 10
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: systemIcon)
                    .foregroundColor(darkModeEnabled ? .white : .black)
                    .padding(10)
                Text(title)
                    .font(.system(size: CGFloat(fontSize-2)))
                    .lineLimit(nil)
                    .foregroundColor(darkModeEnabled ? .white : .black)
                    .padding(10)
            }
            .frame(width: width)
            .background(darkModeEnabled ? .black : .white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(darkModeEnabled ? .white : .black, lineWidth: 2)
            )
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(systemIcon: "square.and.arrow.down", title: "Save Chat") { }
    }
}
