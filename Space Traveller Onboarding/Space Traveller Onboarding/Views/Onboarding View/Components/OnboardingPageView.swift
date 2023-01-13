//
//  OnboardingPageView.swift
//  Space Traveller Onboarding
//
//  Created by Ben Clarke on 13/01/2023.
//

import SwiftUI

struct OnboardingPageView: View {
    // MARK: - Properties
    @State private var animateView = false
    @Binding var currentIndex: Int
    
    let image: String
    let titleText: String
    let subtitleText: String
    
    var body: some View {
            VStack(alignment: .leading) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .padding()
                    .offset(y: animateView ? 0 : -100)
                    .opacity(animateView ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.8))
                
                Text(titleText)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Text(subtitleText)
                    .font(.headline)
                    .foregroundColor(Color("LightPurple"))
            }
            .padding()
            .preferredColorScheme(.dark)
            .onAppear() {
                animateView = true
            }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(currentIndex: .constant(0), image: "Onboarding0", titleText: "Title text", subtitleText: "Subttitle text")
    }
}
