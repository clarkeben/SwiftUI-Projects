//
//  IconButton.swift
//  Chat AI
//
//  Created by Ben Clarke on 07/02/2023.
//

import SwiftUI

struct IconButton: View {
    //MARK: - Properties
    @AppStorage(K.userDefaultKeys.settings.darkModeEnabled) var darkModelEnabled = false

    let imageName: String
    
    var width = 20
    var height = 20
    
    var callback: () -> Void
    
    //MARK: - Body
    var body: some View {
        Button {
            callback()
        } label: {
            Image(systemName: imageName)
                .resizable()
                .frame(width: CGFloat(width), height: CGFloat(height))
                .foregroundColor(darkModelEnabled ?  .white : .black)
        }
    }
}

struct NavigationIconLinkButton: View {
    //MARK: - Properties
    @AppStorage(K.userDefaultKeys.settings.darkModeEnabled) var darkModelEnabled = false

    let imageName: String
    var width = 20
    var height = 20
    
    //MARK: - Body
    var body: some View {
        
        Image(systemName: imageName)
            .resizable()
            .frame(width: CGFloat(width), height: CGFloat(height))
            .foregroundColor(darkModelEnabled ? .white : .black)
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(imageName: "rectangle.on.rectangle") {
            
        }
    }
}
