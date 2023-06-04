//
//  LoadingBarView.swift
//  Message Loading Animation
//
//  Created by Benjamin Clarke on 04/06/2023.
//

import SwiftUI

struct LoadingBarView: View {
    // MARK: - properties
    @Binding var isLoading: Bool
    
    let width: CGFloat
    let height: CGFloat = 20
    
    private let darkGrey: Color = Color("DarkGrey")
    private let lightGrey: Color = Color("LightGrey")
    
    @State private var barScale: CGFloat = 1.0
    @State private var animateGradient = false
    
    // MARK: - Body
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [darkGrey, lightGrey]),
                    startPoint: animateGradient ? .leading : .trailing,
                    endPoint: animateGradient ? .trailing : .leading
                )
                .mask(Rectangle())
                .animation(.linear(duration: 1.5).repeatForever(autoreverses: true), value: animateGradient)
            )
            .scaleEffect(x: 1.0, y: barScale)
            .frame(width: width, height: height)
            .cornerRadius(20)
            .animation(.easeInOut(duration: 0.5), value: isLoading)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                    barScale = 0.4
                    animateGradient = true
                }
            }
            .onDisappear {
                barScale = 1.0
            }
            .preferredColorScheme(.dark)
    }
}

struct LoadingBarView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingBarView(isLoading: .constant(true), width: 100)
    }
}
