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
    @AppStorage(Constants.currentOnboardingVersion) private var hasSeenOnboardingView = false
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboardingView {
                HomePage()
            } else {
                OnboardingView()
            }
        }
    }
}
