//
//  OnBoardingScreen.swift
//  Skeenager
//
//  Created by Claudia De Luca on 27/02/24.
//

import SwiftUI

struct OnBoardingScreen: View {
    let item: OnboardingItem
            
        var body: some View {
            ScrollView {
                VStack {
                    Image(systemName: item.systemImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200, maxHeight: 200)
                        .padding(.bottom)
                    
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .bold()
                            .font(.title)
                            .padding(.bottom)
                        
                        Text(item.subtitle)
                            .padding(.bottom)
                    }
                }
                .padding()
            }.background(
                Image(item.background)
                    .ignoresSafeArea()
                    .scaledToFit())
        }
}

#Preview {
    OnBoardingScreen(item: OnboardingItem(background: "onBoardBack1",
                                          systemImageName: "clock.badge.checkmark",
                                          title: "Quick and Accurate",
                                          subtitle: "This app is quick and accuracte with all the measurements."))
//    OnBoardingScreen(item: OnboardingItem(background: "", systemImageName: "", title: "", subtitle: ""))
}
