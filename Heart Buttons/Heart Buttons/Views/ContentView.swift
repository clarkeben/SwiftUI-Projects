//
//  ContentView.swift
//  Heart Buttons
//
//  Created by Ben Clarke on 02/02/2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var selectedTag = 0
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select button", selection: $selectedTag) {
                    Text("Red Button").tag(0)
                    Text("Green Button").tag(1)
                }.pickerStyle(.segmented)
                
                Spacer()
                
                if selectedTag == 0 {
                    RedHeartButton {
                        // Button pressed
                    }
                } else {
                    GreenHeartButton {
                        // Button pressed
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Heart Button")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
