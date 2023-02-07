//
//  IconButton.swift
//  Chat AI
//
//  Created by Ben Clarke on 07/02/2023.
//

import SwiftUI

struct IconButton: View {
    
    //MARK: - Properties
    let imageName: String
    var callback: () -> Void
    
    var width = 20
    var height = 20
    
    //MARK: - Body
    var body: some View {
        Button {
            callback()
        } label: {
            Image(systemName: imageName)
                .resizable()
                .frame(width: CGFloat(width), height: CGFloat(height))
                .foregroundColor(.black)
        }
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(imageName: "rectangle.on.rectangle") {
            
        }
    }
}
