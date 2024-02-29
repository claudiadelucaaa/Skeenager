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
        VStack {
            //                    Image(systemName: item.systemImageName)
            //                        .resizable()
            //                        .aspectRatio(contentMode: .fit)
            //                        .frame(maxWidth: 200, maxHeight: 200)
            //                        .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text(LocalizedStringKey(item.title))
                    .font(Font.custom("Urbanist-Regular", size: 45, relativeTo: .title))
                    .padding(.bottom)
                
                Text(LocalizedStringKey(item.subtitle))
                    .padding(.bottom)
                    .font(Font.custom("Urbanist-Regular", size: 35, relativeTo: .title2))
            }
            .foregroundStyle(Color.black)
            Spacer()
        }
        .padding()
        .background(
            Image(item.background)
                .ignoresSafeArea()
                .scaledToFit())
    }
}

#Preview {
    OnBoardingScreen(item: OnboardingItem(background: "onBoardBack1",
                                          systemImageName: "clock.badge.checkmark",
                                          title: "Titolo Riassuntivo",
                                          subtitle: "Descrizione abbastanza breve della feature."))
    //    OnBoardingScreen(item: OnboardingItem(background: "", systemImageName: "", title: "", subtitle: ""))
}
