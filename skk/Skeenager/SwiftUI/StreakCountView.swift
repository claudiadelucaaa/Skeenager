//
//  StreakCountView.swift
//  Skeenager
//
//  Created by Claudia De Luca on 23/02/24.
//

//import SwiftUI
//
//struct StreakCountView: View {
//    @State private var lastActualAccessDate: Date?
//    @State private var lastRecordedAccessDate: Date?
//    @State private var streakCount: Int = UserDefaults.standard.integer(forKey: "streakCount")
//    @State private var access: Bool = UserDefaults.standard.bool(forKey: "access")
//    
//    init() {
//        // Load last access date from UserDefaults when the view is initialized
//        self._lastActualAccessDate = State(wrappedValue: UserDefaults.standard.object(forKey: "lastActualAccessDate") as? Date)
//        self._lastRecordedAccessDate = State(wrappedValue: UserDefaults.standard.object(forKey: "lastRecordedAccessDate") as? Date)
//    }
//    
//    var body: some View {
//        VStack {
//            Text("Days of Streak: \(streakCount)")
//                .padding()
//            
//            Button("Log In") {
//                handleLogin()
//            }
//        }
//    }
//    
//func handleLogin() {
//        let currentDate = Date()
//        // Check if it's the first access or if the last access happened yesterday
//        if (lastActualAccessDate == nil  //first access
//            || Calendar.current.isDate(lastActualAccessDate!,
//                                       inSameDayAs: Calendar.current.date(byAdding: .day,
//                                                                          value: -1,
//                                                                          to: currentDate)!))
//            && (lastRecordedAccessDate != currentDate) {
//            streakCount += 1 // Update streak count
//            lastRecordedAccessDate = currentDate // Save the current date as the last recorded access date
//            print(lastActualAccessDate ?? " ")
//            print(lastRecordedAccessDate ?? " ")
//            print(currentDate)
//        }
//        else {
//            streakCount = 1 // Reset streak count
//        }
//        
//        lastActualAccessDate = currentDate // Save last actual access date
//        UserDefaults.standard.set(streakCount, forKey: "streakCount") // Save streak count
//        UserDefaults.standard.set(lastActualAccessDate, forKey: "lastActualAccessDate") // Save last actual access date
//        UserDefaults.standard.set(lastRecordedAccessDate, forKey: "lastRecordedAccessDate") // Save last recorded access date
//    }
//}
//
//
//#Preview {
//    StreakCountView()
//}
