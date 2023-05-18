//
//  ContentView.swift
//  Message Loading Animation
//
//  Created by Benjamin Clarke on 26/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        VStack {
            if isLoading {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Loading...")
                        .offset(y:counter >= 5 ? 0 : -40)
                        .animation(.easeOut(duration: 0.5).repeatForever(), value: isLoading)
                    LoadingBar(isLoading: $isLoading, width: 100)
                        .offset(y:counter >= 5 ? 0 : -40)
                    LoadingBar(isLoading: $isLoading, width: 80)
                        .offset(y:counter >= 4 ? 0 : -40)
                    LoadingBar(isLoading: $isLoading, width: 60)
                        .offset(y:counter >= 3 ? 0 : -40)
                }
                .transition(.slide)
                .animation(.easeInOut(duration: 0.7), value: isLoading)
            }
        }
        .frame(width: 200, height: 100)
        .preferredColorScheme(.dark)
        .onAppear() {
            withAnimation {
                isLoading = true
            }
        }
        .onReceive(timer) { timer in
            counter += 1
            
            print(counter)
        }
    }
}

struct LoadingBar: View {
    
    @Binding var isLoading: Bool
    
    let width: CGFloat
    let height: CGFloat = 20
    
    private let darkGrey: Color = Color("DarkGrey")
    private let lightGrey: Color = Color("LightGrey")
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [darkGrey, lightGrey]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .mask(Rectangle())
                .animation(Animation.linear(duration: 0.6).repeatForever(), value: isLoading)
            )
            .frame(width: width, height: height)
            .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
