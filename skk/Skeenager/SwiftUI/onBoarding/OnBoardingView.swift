//
//  OnBoardingView.swift
//  Skeenager
//
//  Created by Claudia De Luca on 27/02/24.
//

//  OnboardingView.swift
import SwiftUI

struct OnboardingView: View {
    @State private var selectedView = 1
    let maxNumberOfScreens = 3
    // We set this value to false (in case it doesn't already exist)
    @AppStorage(Constants.currentOnboardingVersion) private var hasSeenOnboardingView = false
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedView) {
                // Screen 1
                OnBoardingScreen(item: OnboardingItem(background: "onBoardBack1",
                                                      systemImageName: "clock.badge.checkmark",
                                                      title: "Quick and Accurate",
                                                      subtitle: "Use and unlock lot of filter that will guide your skincare."))
                .tag(1)
                
                // Screen 2
                OnBoardingScreen(item: OnboardingItem(background: "onBoardBack1",
                                                      systemImageName: "dollarsign.circle",
                                                      title: "Select your Products.",
                                                      subtitle: "Track of every step using your products and find new one!"))
                .tag(2)
                
                // Screen 3
                OnBoardingScreen(item: OnboardingItem(background: "onBoardBack1",
                                                      systemImageName: "dollarsign.circle",
                                                      title: "Make money",
                                                      subtitle: "Track of every step using your products and find new one!"))
                .tag(3)
            }
            .ignoresSafeArea()
            .tabViewStyle(.page)
            
            Button {
                if selectedView == maxNumberOfScreens {
                    hasSeenOnboardingView = true
                } else {
                    selectedView += 1
                }
            } label: {
                Text(selectedView == maxNumberOfScreens ? "Done" : "Next")
            }
            .buttonStyle(.bordered)
            .font(Font.custom("Urbanist-Regular", size: 20, relativeTo: .body))
            .foregroundStyle(Color.black)
            .padding(.top, 660)
        }
    }
}
