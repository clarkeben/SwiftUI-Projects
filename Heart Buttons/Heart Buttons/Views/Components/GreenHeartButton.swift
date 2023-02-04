//
//  GreenHeartButton.swift
//  Heart Button
//
//  Created by Ben Clarke on 03/02/2023.
//

import SwiftUI

struct GreenHeartButton: View {
    // MARK: - Properties
    @State private var animateButton = false
    var callback: () -> Void
        
    // MARK: - Body
    var body: some View {
        Button {
            animateButton.toggle()
        } label: {
            ZStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.green)
                    .opacity(animateButton ? 1 : 0)
                    .scaleEffect(animateButton ? 1.0 : 0.1)
                    .animation(.linear, value: animateButton)
                    .frame(width: 100, height: 100, alignment: .center)
                
                Image(systemName: "heart")
                    .resizable()
                    .foregroundColor(.green)
                    .frame(width: 60, height: 60, alignment: .center)
                
                ForEach(0..<8) { item in
                    GreenHeartView()
                        .offset(x: CGFloat.random(in: -150...150), y: CGFloat.random(in: -150...150))
                        .rotationEffect(Angle(degrees: Double.random(in: 0...360)))
                        .scaleEffect(animateButton ? 0.0 : 1)
                        .opacity(animateButton ? 1 : 0.0)
                        .animation(.linear(duration: 0.8), value: animateButton)
                }
                
                Circle()
                    .stroke(.green, lineWidth: 4)
                    .foregroundColor(.clear)
                    .frame(width: 100, height: 100, alignment: .center)
                    .scaleEffect(animateButton ? 1.7 : 0.0)
                    .opacity(animateButton ? 0.0 : 1.0)
                    .animation(Animation.easeInOut(duration: 0.8).repeatCount(2, autoreverses: true).speed(0.5), value: animateButton)
                
                Circle()
                    .stroke(.green, lineWidth: 4)
                    .foregroundColor(.clear)
                    .frame(width: 80, height: 80, alignment: .center)
                    .scaleEffect(animateButton ? 1.7 : 0.0)
                    .opacity(animateButton ? 0.0 : 1.0)
                    .animation(Animation.easeInOut(duration: 0.8).repeatCount(2, autoreverses: true).speed(0.5), value: animateButton)
            }
        }
    }
}

struct GreenHeartButton_Previews: PreviewProvider {
    static var previews: some View {
        GreenHeartButton() { }
    }
}
