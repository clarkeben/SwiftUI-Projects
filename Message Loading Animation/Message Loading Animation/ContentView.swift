//
//  ContentView.swift
//  Message Loading Animation
//
//  Created by Benjamin Clarke on 26/04/2023.
//

import SwiftUI

struct ContentView: View {
    //Properties
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var isLoading = false
    @State private var finishedLoading = false
    @State private var counter = 0
    @State private var endAnimation = false
    
    // Body
    var body: some View {
        VStack {
            if isLoading {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Loading...")
                        .offset(y: counter >= 5 ? 0 : -40)
                        .animation(.easeOut(duration: 0.5).repeatForever(), value: counter)
                    LoadingBarView(isLoading: $isLoading, width: 100)
                        .offset(y: counter >= 4 ? 0 : -40)
                        .animation(.easeOut(duration: 0.5).repeatForever(), value: counter)
                    LoadingBarView(isLoading: $isLoading, width: 80)
                        .offset(y: counter >= 3 ? 0 : -40)
                        .animation(.easeOut(duration: 0.5).repeatForever(), value: counter)
                    LoadingBarView(isLoading: $isLoading, width: 60)
                        .offset(y: counter >= 2 ? 0 : -40)
                        .animation(.easeOut(duration: 0.5).repeatForever(), value: counter)
                }
                .transition(.slide)
                .opacity(endAnimation ? 0 : 1)
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
            
            if counter == 6 {
                withAnimation {
                    endAnimation = true
                    counter = 0
                }
            }
        }
    }
}

// MARK: - LoadingBarView
struct LoadingBarView: View {
    // properties
    @Binding var isLoading: Bool
    
    let width: CGFloat
    let height: CGFloat = 20
    
    private let darkGrey: Color = Color("DarkGrey")
    private let lightGrey: Color = Color("LightGrey")
    
    @State private var barScale: CGFloat = 1.0
    @State private var animateGradient = false
    
    // Body
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [darkGrey, lightGrey]),
                    startPoint: animateGradient ? .leading : .trailing,
                    endPoint: animateGradient ? .trailing : .leading
                )
                .mask(Rectangle())
                .animation(.linear(duration: 1.0).repeatForever(autoreverses: true), value: animateGradient)
            )
            .scaleEffect(x: 1.0, y: barScale)
            .frame(width: width, height: height)
            .cornerRadius(20)
            .animation(.easeInOut(duration: 0.5), value: isLoading)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                    barScale = 0.4
                    animateGradient = true
                }
            }
            .onDisappear {
                barScale = 1.0
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
