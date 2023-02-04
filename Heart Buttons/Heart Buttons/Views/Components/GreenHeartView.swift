//
//  GreenHeartView.swift
//  Heart Button
//
//  Created by Ben Clarke on 03/02/2023.
//

import SwiftUI

struct GreenHeartView: View {
    // MARK: - Properties
    let randomSize = Int.random(in: 5...60)
    let randomColour = [Color.yellow, Color.orange ,Color.red, Color.blue, Color.pink, Color.purple, Color.indigo, Color.mint].randomElement()
    
    // MARK: - Body
    var body: some View {
       Image(systemName: "heart.fill")
            .resizable()
            .frame(width: CGFloat(randomSize), height: CGFloat(randomSize), alignment: .center)
            .foregroundColor(randomColour)
    }
}

struct GreenHeartView_Previews: PreviewProvider {
    static var previews: some View {
        GreenHeartView()
    }
}
