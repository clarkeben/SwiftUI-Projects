//
//  CustomModalPopup.swift
//  Chat AI
//
//  Created by Ben Clarke on 14/03/2023.
//

import SwiftUI

struct CustomModalPopup: View {
    //MARK : - Properties
    @AppStorage(K.userDefaultKeys.settings.darkModeEnabled) var darkModeEnabled = false
    
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
                    .foregroundColor(darkModeEnabled ? .white : .black)
                
            }
            .frame(width: 150)
            .padding()
            .background(darkModeEnabled ? .black : .white)
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
