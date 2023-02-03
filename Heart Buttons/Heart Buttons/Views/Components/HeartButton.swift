//
//  HeartButton.swift
//  Heart Buttons
//
//  Created by Ben Clarke on 02/02/2023.
//

import SwiftUI

struct HeartButton: View {
    // MARK: - Properties
    @State private var animateButton = false
    var callback: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button {
            animateButton.toggle()
            callback()
        } label: {
            ZStack {
                Image(systemName: animateButton ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.red)
                
                ForEach(0..<10) { index in
                    HeartView()
                        .offset(x: CGFloat.random(in: -30...30),
                            y: animateButton ? -CGFloat(index * 20) : 0)
                        .foregroundColor(animateButton ? .red : .clear)
                        .opacity(animateButton ? 0 : 1)
                        .animation(Animation.easeInOut(duration: 1.3).delay(Double(index) / 20), value: animateButton)
                }
                Circle()
                    .stroke(.red, lineWidth: 4)
                    .frame(width: 100, height: 100, alignment: .center)
                    .scaleEffect(animateButton ? 1.7 : 0)
                    .opacity(animateButton ? 0 : 1)
                    .animation(Animation.easeInOut(duration: 1.0), value: animateButton)
                
                Circle()
                    .stroke(.red, lineWidth: 4)
                    .frame(width: 80, height: 80, alignment: .center)
                    .scaleEffect(animateButton ? 1.7 : 0)
                    .opacity(animateButton ? 0 : 1)
                    .animation(Animation.easeInOut(duration: 1.0), value: animateButton)
            }
        }
    }
}

struct HeartButton_Previews: PreviewProvider {
    static var previews: some View {
        HeartButton() { }
    }
}
