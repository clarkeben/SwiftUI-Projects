//
//  ContentView.swift
//  Pain Scale Slider
//
//  Created by Benjamin Clarke on 29/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Properties
    let gradient = Gradient(colors: [.blue, .green, .yellow, .orange, .pink, .red])
    
    @State private var sliderProgressValue: CGFloat = 0
    @State private var sliderWidth: CGFloat = 0
    @State private var lastDragValue: CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Slider Value: \(Int(sliderProgressValue * 100))😖")
                    .offset(x: sliderWidth)
                HStack {
                    Text("😁").font(.title)
                    ZStack(alignment: .bottom) {
                        HStack {
                            Rectangle()
                                .fill(.black)
                                .opacity(0.5)
                                .frame(width: sliderWidth)
                            
                            Rectangle()
                                .fill(Color.white)
                                .opacity(0.15)
                        }
                        .frame(width: UIScreen.main.bounds.width - 80, height: 40)
                        .background(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(20)
                    }
                    .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                        
                        let translate = value.translation

                        withAnimation {
                            sliderWidth = translate.width + lastDragValue
                            //TODO: - Update the emoji
                        }
                        
                        //sliderWidth = sliderWidth > maxWidth ? maxWidth : sliderWidth
                        
                    }).onEnded({ value in
                        //sliderWidth = sliderWidth > maxWidth ? maxWidth : sliderWidth
                        
                        lastDragValue = sliderWidth
                        
                    }))
                    
                    Text("😖").font(.title)
                }
                
            }
            .navigationTitle("Pain Scale Slider")
        }
        .preferredColorScheme(.dark)
    }
    
    private func updateEmoji() {
        let currentValue = Int(sliderProgressValue * 100)
        
        switch currentValue {
        case 0...10:
        case 11..20:
        case 21..30:
        case 31..40:
        case 41..50:
        case 51..60:
        case 61..60:
        }
    }
}

#Preview {
    ContentView()
}
