//
//  ContentView.swift
//  Instagram Heart Animation
//
//  Created by Ben Clarke on 22/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var imageLiked = false
    @State private var showHeart = false
    @State private var heartSize: CGFloat = 0
    @State private var heartOffset: CGFloat = 0
    @State private var tapLocation: CGPoint = CGPoint.zero
    @State private var tapCount: Double = 1
    
    var yAxis: Int = Int.random(in: -50...50)
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Text("VikingSkullApps")
                        .font(.system(.caption))
                    
                    Spacer()
                    Image(systemName: "ellipsis")
                        .resizable()
                        .frame(width: 10, height: 3)
                }
                
                Image("IG-image")
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    Button {
                        // Action
                    } label: {
                        Image(systemName: imageLiked ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(imageLiked ? .red : .primary)
                        Text(imageLiked ? "1" : "0")
                            .foregroundColor(.primary)
                    }
                    .padding(3)
                    
                    Image(systemName: "message")
                        .padding(3)
                    
                    Image(systemName: "paperplane")
                        .padding(3)
                    Spacer()
                }
            }
            
            if showHeart {
                HeartView(size: heartSize, tapCount: $tapCount)
                    .offset(x: 0, y: CGFloat(yAxis))
                    .animation(.easeInOut(duration: 1), value: showHeart)
                    .onAppear {
                        heartSize = 1.2
                    }
                    .rotationEffect(.degrees(45))
                    .offset(x: tapLocation.x - UIScreen.main.bounds.width / 2, y: heartOffset)
                    .animation(Animation.easeInOut(duration: 1).delay(1.5), value: showHeart)
            }
        }
        .onTapGesture(count: 2) { location in
            tapLocation = location
            showHeart = true
            
            withAnimation {
                imageLiked = true
                heartOffset = -500
                tapCount += 0.5
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                resetAnimation()
            }
        }
    }
    
    func resetAnimation() {
        showHeart = false
        heartSize = 0
        heartOffset = 0
    }
}


struct HeartView: View {
    var size: CGFloat
    
    @Binding var tapCount: Double
    
    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.red)
            .frame(width: 50 * size * CGFloat(tapCount), height: 50 * size * CGFloat(tapCount))
    }
}

struct HeartView_Previews: PreviewProvider {
    static var previews: some View {
        HeartView(size: 1.0, tapCount: .constant(1))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
