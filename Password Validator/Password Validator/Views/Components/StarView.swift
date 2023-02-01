//
//  StarView.swift
//  Password Validator
//
//  Created by Ben Clarke on 01/02/2023.
//

import SwiftUI

struct StarView: View {
    //MARK: - Properties
    let randomSize = Int.random(in: 5...30)
    let randomColour = [Color.yellow, Color.orange ,Color.red, Color.blue, Color.pink, Color.purple, Color.indigo, Color.mint].randomElement()
    
    //MARK: - Body
    var body: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: CGFloat(randomSize), height: CGFloat(randomSize), alignment: .center)
            .foregroundColor(randomColour)
    }
}

struct StarView_Previews: PreviewProvider {
    static var previews: some View {
        StarView()
    }
}
