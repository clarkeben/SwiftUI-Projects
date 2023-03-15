//
//  CustomModalPopup.swift
//  Chat AI
//
//  Created by Ben Clarke on 14/03/2023.
//

import SwiftUI

struct CustomModalPopup: View {
    let icon: String
    var iconColour: Color
    let title: String
    @Binding var isShowing: Bool
        
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(iconColour)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                
            }
            .frame(width: 150)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
        .opacity(isShowing ? 1 : 0)
        .animation(.easeInOut(duration: 1), value: isShowing)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isShowing = false
            }
        }
    }
}

struct CustomModalPopup_Previews: PreviewProvider {
    static var previews: some View {
        CustomModalPopup(icon: "checkmark.circle.fill", iconColour: .green, title: "Saved!", isShowing: .constant(true))
    }
}
