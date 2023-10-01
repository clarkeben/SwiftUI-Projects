//
//  PainScaleSlider.swift
//  Pain Scale Slider
//
//  Created by Benjamin Clarke on 30/09/2023.
//

import SwiftUI

struct PainScaleSlider: View {
    //MARK: - Properties
    let gradient = Gradient(colors: [.blue, .green, .yellow, .orange, .pink, .red])
    
    @State private var sliderProgressValue: CGFloat = 0
    @State private var sliderWidth: CGFloat = 0
    @State private var lastDragValue: CGFloat = 0
    
    @State private var painRatingEmojiValue = "⁉️"
    @State private var painRatingLabel = ""
    @State private var painRatingLabelColour: Color = .black
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(painRatingEmojiValue)")
                .font(.title2)
                .offset(x: sliderWidth+25)
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
                    
                    let progress = sliderWidth >= 0 ? sliderWidth : 0
                    sliderProgressValue = progress/3220
                    
                    withAnimation {
                        sliderWidth = translate.width + lastDragValue
                    }
                    
                    updateEmoji()
                                            
                }).onEnded({ value in
                    lastDragValue = sliderWidth
                }))
                
                Text("😖").font(.title)
            }
            HStack {
                Spacer()
                VStack {
                    Text("Pain Scale: \(Int(sliderProgressValue * 100))")
                    Text(painRatingLabel)
                        .foregroundColor(painRatingLabelColour)
                }
                Spacer()
            }
        }
    }
    
    //MARK: - Methods
    private func updateEmoji() {
        let currentValue = Int(sliderProgressValue * 100)
        
        switch currentValue {
        case 0...1:
            painRatingEmojiValue = "😁"
            painRatingLabel = "No pain"
            painRatingLabelColour = .blue
        case 1...2:
            painRatingEmojiValue = "😀"
            painRatingLabel = "Minimal pain"
            painRatingLabelColour = .cyan
        case 2...3:
            painRatingEmojiValue = "😋"
            painRatingLabel = "Mild pain"
            painRatingLabelColour = .green
        case 3...4:
            painRatingEmojiValue = "☺️"
            painRatingLabel = "Uncomfortable pain"
            painRatingLabelColour = .yellow
        case 4...5:
            painRatingEmojiValue = "🙂"
            painRatingLabel = "Moderate pain"
            painRatingLabelColour = .orange
        case 5...6:
            painRatingEmojiValue = "🙁"
            painRatingLabel = "Distracting pain"
            painRatingLabelColour = .orange
        case 6...7:
            painRatingEmojiValue = "😟"
            painRatingLabel = "Distressing pain"
            painRatingLabelColour = .orange

        case 7...8:
            painRatingEmojiValue = "😫"
            painRatingLabel = "Intense pain"
            painRatingLabelColour = .pink
        case 8...9:
            painRatingEmojiValue = "😖"
            painRatingLabel = "Severe pain"
            painRatingLabelColour = .pink
        case 9...100:
            painRatingEmojiValue = "😭"
            painRatingLabel = "Unable to move"
            painRatingLabelColour = .red
        default:
            painRatingEmojiValue = "❌"
        }
    }
}

#Preview {
    PainScaleSlider()
}
