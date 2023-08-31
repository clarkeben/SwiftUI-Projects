//
//  ContentView.swift
//  Instagram Heart Animation
//
//  Created by Ben Clarke on 22/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showHeart = false
    @State private var heartSize: CGFloat = 0
    //@State private var heartOffset: CGFloat = 0
    @State private var heartOffset: CGSize = CGSize.zero
    @State private var tapLocation: CGPoint = CGPoint.zero

    
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
            }
            
            if showHeart {
                HeartView(size: heartSize)
                    .offset(x: 0, y: CGFloat(yAxis))
                    .animation(.easeInOut(duration: 1), value: showHeart)
                    .onAppear {
                        heartSize = 1.2
                    }
                    .rotationEffect(.degrees(45))
                    .offset(x: heartOffset.width, y: heartOffset.height)
                    .animation(Animation.easeInOut(duration: 1).delay(1.5), value: showHeart)
            }
        }
        .onTapGesture(count: 2) { location in
            tapLocation = location
            
            showHeart = true
            
            withAnimation {
                heartOffset = CGSize(width: tapLocation.x - UIScreen.main.bounds.width / 2, height: tapLocation.y - UIScreen.main.bounds.height / 2)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                resetAnimation()
            }
        }
    }
    
    func resetAnimation() {
        showHeart = false
        heartSize = 0
        heartOffset = CGSize.zero
    }
}


struct HeartView: View {
    var size: CGFloat
    
    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.red)
            .frame(width: 50 * size, height: 50 * size)
    }
}

struct HeartView_Previews: PreviewProvider {
    static var previews: some View {
        HeartView(size: 1.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
