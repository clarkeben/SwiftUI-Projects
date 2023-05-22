//
//  LoadingTextView.swift
//  Chat AI
//
//  Created by Ben Clarke on 23/02/2023.
//

import SwiftUI

struct TypingTextView: View {
    // MARK: - Properties
    let text: String
    @State var animateView = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(text)
                .font(.system(size: 10))
                .mask(Rectangle().offset(x: animateView ? 0 : -150))
            
            Rectangle()
                .fill(.black)
                .opacity(animateView ? 0 : 1)
                .frame(width: 2, height: 10)
                .offset(x: animateView ? 90 : 0 )
        }
        .onAppear() {
            withAnimation(.easeInOut(duration: 1).repeatForever()) {
               animateView = true
            }
        }
    }
}

struct TypingTextView_Previews: PreviewProvider {
    static var previews: some View {
        TypingTextView(text: "Fetching Data...")
    }
}
