//
//  app.swift
//  skk
//
//  Created by Claudia De Luca on 20/02/24.
//

import Foundation
import SwiftUI

@main
struct ContentView: App {
    @State private var changeView = false // Add a State variable for changeView
    @State private var currentIndex = 0
    @State private var selectedStates = [false]
    @AppStorage(Constants.currentOnboardingVersion) private var hasSeenOnboardingView = false
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboardingView {
                HomePage(currentIndex: currentIndex, changeView: $changeView)
            } else {
                OnboardingView()
            }
        }.environment(\.locale, .current)
    }
}
