//
//  PaginationIndexDisplay.swift
//  Space Traveller Onboarding
//
//  Created by Ben Clarke on 13/01/2023.
//

import SwiftUI

struct PaginationIndexDisplay: View {
    // MARK: - Properties
    @Binding var currentIndex: Int
    
    var buttonAction: () -> Void
    
    var body: some View {
        HStack {
            Capsule()
                .foregroundColor(currentIndex == 0 ? Color("LightPurple") : .gray)
                .frame(width: currentIndex == 0 ? 30 : 10, height: 10)
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1))
            
            Capsule()
                .foregroundColor(currentIndex == 1 ? Color("LightPurple") : .gray)
                .frame(width: currentIndex == 1 ? 30 : 10, height: 10)
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1))
            
            Capsule()
                .foregroundColor(currentIndex == 2 ? Color("LightPurple") : .gray)
                .frame(width: currentIndex == 2 ? 30 : 10, height: 10)
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1))
            
            Spacer()
            
            if currentIndex == 2 {
                Button {
                    buttonAction()
                } label: {
                    Text("Done")
                        .foregroundColor(.black)
                }
                .frame(width: 60, height: 40)
                .background(Color("LightPurple"))
                .cornerRadius(10)
            }
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}

struct PaginationIndexDisplay_Previews: PreviewProvider {
    static var previews: some View {
        PaginationIndexDisplay(currentIndex: .constant(2)){ }
    }
}
