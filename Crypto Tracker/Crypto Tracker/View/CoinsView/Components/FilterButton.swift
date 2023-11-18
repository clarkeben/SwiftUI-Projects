//
//  FilterButton.swift
//  Crypto Tracker
//
//  Created by Benjamin Clarke on 18/11/2023.
//

import SwiftUI

struct FilterButton: View {
    //MARK: - Properties
    let title: String
    var completion: () -> Void
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            Button {
                
            } label: {
               Text("\(title) ↑")
                    .foregroundColor(.black)
            }
        }
        .frame(width: 90, height: 40, alignment: .center)
        .cornerRadius(5)
        .shadow(radius: 5)
    }
}

#Preview {
    FilterButton(title: "Volume") {
        
    }
}
