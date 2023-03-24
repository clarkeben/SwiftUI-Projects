//
//  RegularButton.swift
//  Chat AI
//
//  Created by Ben Clarke on 24/03/2023.
//

import SwiftUI

struct RegularButton: View {
    let title: String
    let action: () -> Void
    
    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .roundedButton()
        }
    }
}

struct RegularButton_Previews: PreviewProvider {
    static var previews: some View {
        RegularButton("Test") {
            print("Testing")
        }
    }
}
