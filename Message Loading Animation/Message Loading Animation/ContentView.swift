//
//  ContentView.swift
//  Message Loading Animation
//
//  Created by Benjamin Clarke on 26/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            if isLoading {
                VStack {
                    LoadingBar(width: 100)
                    LoadingBar(width: 80)
                    LoadingBar(width: 60)
                }
                .transition(.opacity)
                .animation(.default)
            } else {
                Text("Tap to start")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .onTapGesture {
                        withAnimation {
                            isLoading.toggle()
                        }
                    }
            }
        }
        .frame(width: 200, height: 100)
    }
}

struct LoadingBar: View {
    let width: CGFloat
    let height: CGFloat = 20
    
    var body: some View {
        Rectangle()
            .foregroundColor(.gray)
            .frame(width: width, height: height)
            .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
