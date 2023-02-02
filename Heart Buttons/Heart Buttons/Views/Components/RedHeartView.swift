//
//  AnimatableHeartView.swift
//  Heart Buttons
//
//  Created by Ben Clarke on 02/02/2023.
//

import SwiftUI

struct RedHeartView: View {
    //MARK: - Properties
    let randomSize = CGFloat.random(in: 5...40)
    
    //MARK: - Body
    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .frame(width: randomSize, height: randomSize)
    }
}

struct AnimatableHeartView_Previews: PreviewProvider {
    static var previews: some View {
        RedHeartView()
    }
}
