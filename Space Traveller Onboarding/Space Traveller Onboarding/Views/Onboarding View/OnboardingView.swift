//
//  OnboardingView.swift
//  Space Traveller Onboarding
//
//  Created by Ben Clarke on 11/01/2023.
//

import SwiftUI

struct OnboardingView: View {
    // Mark: - properties
    
    /// Animation Properties
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var animateLogo = false
    @State private var counter = 0
    @State private var showLogo = true
    
    /// Onboarding properties
    @Binding var showOnboardingView: Bool
    @State var currentTabIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showOnboardingView = false
                    } label: {
                        Text("Skip")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                Spacer()
                
                if showLogo {
                    VStack(alignment: .leading) {
                      Image("icon")
                        .resizable()
                        .frame(width: animateLogo ? 120: 0, height: 120)
                        .offset(y: counter > 2 ? -100 : 0)
                        .opacity(counter > 2 ? 0.0 : 1.0)
                        .animation(.easeInOut(duration: 0.6))
                        
                        Text("Welcome to..")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .offset(y: counter > 2 ? -100 : 0)
                            .opacity(counter > 2 ? 0.0 : 1.0)
                            .animation(.easeInOut(duration: 0.7))
                        
                        Text("SPACE TRAVELLER")
                            .font(.headline)
                            .foregroundColor(Color("LightPurple"))
                            .offset(y: counter > 2 ? -100 : 0)
                            .opacity(counter > 2 ? 0.0 : 1.0)
                            .animation(.easeInOut(duration: 0.8))
                    }
                    .frame(width: animateLogo ? .infinity : 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1), value: animateLogo)
                    
                    Spacer()
                } else {
                    TabView(selection: $currentTabIndex) {
                        OnboardingPageView(currentIndex: $currentTabIndex,
                                           image: "Onboarding0",
                                           titleText: "The Team",
                                           subtitleText: "Find out about the team, and what they've been up to.").tag(0)
                            
                        
                        OnboardingPageView(currentIndex: $currentTabIndex,
                                           image: "Onboarding1",
                                           titleText: "New Planets",
                                           subtitleText: "Explore the planets visited by the team.").tag(1)
                        
                        OnboardingPageView(currentIndex: $currentTabIndex,
                                           image: "Onboarding2",
                                           titleText: "Our Ships",
                                           subtitleText: "View the fleet, and find out what is currently in use as well as their locations.").tag(2)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                    
                    Spacer()
                    
                    PaginationIndexDisplay(currentIndex: $currentTabIndex) {
                        showOnboardingView = false
                    }
                }
            }
            
        }
        .onAppear() {
            animateLogo = true
        }
        .onReceive(timer) { _ in
            counter += 1
            
            if counter > 3 {
                showLogo = false
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingPageView: View {
    @State private var animateView = false
    @Binding var currentIndex: Int
    
    let image: String
    @State var titleText: String
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

struct PaginationIndexDisplay: View {
    @Binding var currentIndex: Int
    
    var buttonAction: () -> Void
    
    var body: some View {
        HStack {
            Capsule()
                .foregroundColor(currentIndex == 0 ? Color("LightPurple") : .gray)
                .frame(width: currentIndex == 0 ? 30 : 10, height: 10)
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1))
            
            Capsule()
                .foregroundColor(currentIndex == 1 ? Color("LightPurple") : .gray)
                .frame(width: currentIndex == 1 ? 30 : 10, height: 10)
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1))
            
            Capsule()
                .foregroundColor(currentIndex == 2 ? Color("LightPurple") : .gray)
                .frame(width: currentIndex == 2 ? 30 : 10, height: 10)
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1))
            
            Spacer()
            
            if currentIndex == 2 {
                Button {
                    buttonAction()
                } label: {
                    Text("Done")
                        .foregroundColor(.black)
                }
                .frame(width: 60, height: 40)
                .background(Color("LightPurple"))
                .cornerRadius(10)
            }
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    
    static var previews: some View {
        OnboardingView(showOnboardingView: .constant(true))
    }
}
