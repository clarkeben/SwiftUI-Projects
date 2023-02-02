//
//  ContentView.swift
//  Heart Buttons
//
//  Created by Ben Clarke on 02/02/2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var tagSelection = 0
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Picker("Heart Buttons", selection: $tagSelection) {
                    Text("Ascending Button").tag(0)
                    Text("Ascending Button").tag(0)
                }.pickerStyle(.segmented)
                
                Spacer()
                
                if tagSelection == 0 {
                    HeartButton {
                        
                    }
                } else {
                    
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Heart Buttons")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
