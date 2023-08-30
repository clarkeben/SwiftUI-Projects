//
//  AvatarCellView.swift
//  Message Loading Animation
//
//  Created by Benjamin Clarke on 04/06/2023.
//

import SwiftUI

struct AvatarCellView: View {
    // MARK: - Properties
    private let darkGrey: Color = Color("DarkGrey")
    private let lightGrey: Color = Color("LightGrey")
    
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
                .animation(.linear(duration: 1.0).repeatForever(autoreverses: true), value: animateGradient)
            )
            .frame(width: 60, height: 60)
            .cornerRadius(10)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                    animateGradient = true
                }
            }
            .preferredColorScheme(.dark)
    }
}

struct AvatarCellView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarCellView()
    }
}
