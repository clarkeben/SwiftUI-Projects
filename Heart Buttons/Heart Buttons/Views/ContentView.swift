//
//  ContentView.swift
//  Heart Buttons
//
//  Created by Ben Clarke on 02/02/2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                HeartButton {
                    // Button pressed
                }
                
                Spacer()
            }
            .navigationTitle("Heart Button")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
