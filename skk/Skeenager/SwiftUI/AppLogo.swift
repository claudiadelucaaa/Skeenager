//
//  AppLogo.swift
//  Skeenager
//
//  Created by Claudia De Luca on 27/02/24.
//

import SwiftUI

struct AppLogo: View {
    @Binding var currentView: CurrentView
    @State var scale = 0.5
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack{
                Text(LocalizedStringKey("Skeenager"))
                    .font(Font.custom("Urbanist-Regular", size: 55, relativeTo: .title))
                    .frame(height: 80)
                
                Rectangle()
                    .frame(width: 300, height: 2)
            }
            .foregroundStyle(Color.black)
            .scaleEffect(scale)
            .onAppear {
                let baseAnimation = Animation.smooth(duration: 1.5)
                let repeated = baseAnimation.repeatCount(1)
                withAnimation(repeated, completionCriteria: .removed) {
                    scale = 1.0
                } completion: {
                    withAnimation {
                        scale = 0.4
                        currentView = .theme
                    }
                }
            }
        }
    }
}
