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
    @State private var selectedStates = [false]
    @State var streakCount: Int = UserDefaults.standard.integer(forKey: "streakCount")
    @AppStorage(Constants.currentOnboardingVersion) private var hasSeenOnboardingView = false
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboardingView {
                HomePage(streakCount: $streakCount)
            } else {
                OnboardingView()
            }
        }.environment(\.locale, .current)
    }
}
