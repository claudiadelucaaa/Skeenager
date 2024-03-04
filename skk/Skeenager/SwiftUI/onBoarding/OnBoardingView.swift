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
    @State private var selectedStates = Array(repeating: false, count: Steps().rainbowList.count)
    let maxNumberOfScreens = 3
    @State var currentIndex = 0
    // We set this value to false (in case it doesn't already exist)
    @AppStorage(Constants.currentOnboardingVersion) private var hasSeenOnboardingView = false
    
    var body: some View {
        ZStack {
            
            TabView(selection: $selectedView) {
                // Screen 1
                OnBoardingScreen(item: OnboardingItem(background: "onBoard0",
                                                      systemImageName: "clock.badge.checkmark",
                                                      title: "Skin Filter",
                                                      subtitle: "Use and unlock lot of filter that will guide your skincare."))
                .tag(1)
                
                // Screen 2
                OnBoardingScreen(item: OnboardingItem(background: "onBoard1",
                                                      systemImageName: "dollarsign.circle",
                                                      title: "Select your Products.",
                                                      subtitle: "Track of every step using your products and find new one!"))
                .tag(2)
                
//                // Screen 3
                OnboardingProducts()
                .tag(3)
            }
            .ignoresSafeArea()
            .tabViewStyle(.page)
            VStack{
                Spacer()
                
                Button {
                    if selectedView == maxNumberOfScreens {
                        hasSeenOnboardingView = true
                    } else {
                        selectedView += 1
                    }
                } label: {
                    if selectedView == maxNumberOfScreens {
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 40)
                                .foregroundStyle(Color.black)
                                .frame(height: 60)
                            
                            Text(LocalizedStringKey("Start"))
                                .font(Font.custom("Urbanist-Regular", size: 20))
                                .foregroundStyle(Color.white)
                        }.padding(.all)
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView(currentIndex: 1)
}
