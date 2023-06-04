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
                VStack {
                    Text("Loading...")
                        .font(.title)
                        .offset(y: counter >= 4 ? 0 : -20)
                        .animation(.easeOut(duration: 0.5).repeatForever(), value: counter)
                    HStack(alignment: .top) {
                        AvatarCellView()
                            .offset(y: counter >= 3 ? 0 : -20)
                            .animation(.easeOut(duration: 0.5).repeatForever(), value: counter)
                        VStack(alignment: .leading, spacing: 10) {
                            LoadingBarView(isLoading: $isLoading, width: 100)
                                .offset(y: counter >= 3 ? 0 : -20)
                                .animation(.easeOut(duration: 0.5).repeatForever(), value: counter)
                            LoadingBarView(isLoading: $isLoading, width: 80)
                                .offset(y: counter >= 2 ? 0 : -20)
                                .animation(.easeOut(duration: 0.5).repeatForever(), value: counter)
                            LoadingBarView(isLoading: $isLoading, width: 60)
                                .offset(y: counter >= 1 ? 0 : -20)
                                .animation(.easeOut(duration: 0.5).repeatForever(), value: counter)
                        }
                    }
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
            
            if counter == 4 {
                withAnimation {
                    endAnimation = true
                    counter = 0
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
