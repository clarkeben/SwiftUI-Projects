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
    var showFilterDirection = true
    var completion: () -> Void
    
    @State private var filterAscending = true
    var filterDirectionLabel: String {
        if filterAscending {
            return "↓"
        } else {
            return "↑"
        }
    }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            Button {
                withAnimation {
                    filterAscending.toggle()
                }
               
                completion()
            } label: {
                Text(showFilterDirection ? "\(title) \(filterDirectionLabel)" : title)
                    .font(.system(size: 12))
                    .fontDesign(.rounded)
                    .bold()
                    .foregroundColor(.black)
            }
        }
        .frame(width: 90, height: 40, alignment: .center)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    FilterButton(title: "Volume") {
        
    }
}
