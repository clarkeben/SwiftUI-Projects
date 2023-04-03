//
//  ActionButton.swift
//  Chat AI
//
//  Created by Ben Clarke on 28/02/2023.
//

import SwiftUI

struct ActionButton: View {
    //MARK: - Properties
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
                    .foregroundColor(.black)
                    .padding(10)
                Text(title)
                    .font(.system(size: CGFloat(fontSize-2)))
                    .lineLimit(nil)
                    .foregroundColor(.black)
                    .padding(10)
            }
            .frame(width: width)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
            )
        }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(systemIcon: "square.and.arrow.down", title: "Save Chat") { }
    }
}
