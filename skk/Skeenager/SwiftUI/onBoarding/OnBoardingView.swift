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
    let maxNumberOfScreens = 2
    // We set this value to false (in case it doesn't already exist)
    @AppStorage(Constants.currentOnboardingVersion) private var hasSeenOnboardingView = false
    
    var body: some View {
        VStack {
            TabView(selection: $selectedView) {
                // Example screen 1
                OnBoardingScreen(item: OnboardingItem(background: "onBoardBack1",
                                                      systemImageName: "clock.badge.checkmark",
                                                      title: "Quick and Accurate",
                                                      subtitle: "Use and unlock lot of filter that will guide your skincare."))
                .tag(1)
                
                // Example screen 2
                OnBoardingScreen(item: OnboardingItem(background: "onBoardBack1",
                                                      systemImageName: "dollarsign.circle",
                                                      title: "Make money",
                                                      subtitle: "With this app you can make money while you sleep."))
                .tag(2)
            }
            // Allows you to swipe through the tabs,
            // if you only have one onboarding screen, the dots at the bottom of the screen that indicate what tab you are on, won't be displayed
            .tabViewStyle(.page)
            // Displays the background behind the tab indicator dots so that they can been seen in light and dark mode
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            Button(selectedView == maxNumberOfScreens ? "Done" : "Next") {
                if selectedView == maxNumberOfScreens {
                    // Save the completedOnboarding state and exit the view
                    hasSeenOnboardingView = true
                } else {
                    selectedView += 1
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.vertical)
        }
    }
}
