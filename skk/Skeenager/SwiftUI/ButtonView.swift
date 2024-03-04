//
//  bottonView.swift
//  skk
//
//  Created by Claudia De Luca on 20/02/24.
//

import SwiftUI

struct ButtonView: View {
    @Binding var selectedStates: [Bool]
    //variabile passata dell'indice del tema 
    @State var selectedIndex: Int?
    var steps: Steps
    var filters: Filter
    @State var filterSelected: String
    @State var stepSelected: String
    @State var posSelected: Int
    @State private var isPushed = false
    
    @Binding var currentView: CurrentView
    @Binding var currentIndex: Int
    
    //Streak Counter
    @State private var lastActualAccessDate: Date?
    @State private var lastRecordedAccessDate: Date?
    @State private var streakCount: Int = UserDefaults.standard.integer(forKey: "streakCount")
    @State private var access: Bool = UserDefaults.standard.bool(forKey: "access")
    
    // Add initializers to initialize all properties
    init(selectedStates: Binding<[Bool]>, steps: Steps, filters: Filter, filterSelected: String, stepSelected: String, posSelected: Int, currentView: Binding<CurrentView>, currentIndex: Binding<Int>) {
        self._selectedStates = selectedStates
        self.steps = steps
        self.filters = filters
        self._filterSelected = State(initialValue: filterSelected)
        self._stepSelected = State(initialValue: stepSelected)
        self._posSelected = State(initialValue: posSelected)
        self._currentView = currentView
        self._currentIndex = currentIndex
        
        // Load last access date from UserDefaults when the view is initialized
        self._lastActualAccessDate = State(wrappedValue: UserDefaults.standard.object(forKey: "lastActualAccessDate") as? Date)
        self._lastRecordedAccessDate = State(wrappedValue: UserDefaults.standard.object(forKey: "lastRecordedAccessDate") as? Date)
    }
    
    var body: some View {
        ZStack{
            BasicUIViewControllerRepresentable(filter: $filterSelected)
                .ignoresSafeArea()
            VStack{
                HStack{
                    ForEach(steps.stepsList.indices, id: \.self) { ind in
                        let step = steps.stepsList[ind]
                        if selectedStates[ind] == true {
                            
                            Button(action: {
                                filterSelected = step.filte
                                stepSelected = step.name
                                posSelected = step.pos
                            }, label: {
                                Text(String(step.pos+1))
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.black)
                                    .bold(true)
                                    .padding(.all)
                                    .background(Circle()
                                        .fill(Color.gray)
                                        .opacity(0.5)
                                        .frame(width: 40.0, height: 40.0))
                            })
                        }
                    }
                }
                
                Spacer()
                
                
                VStack {
                    Text(LocalizedStringKey("Step" + " " + String(posSelected+1) + ": " + stepSelected))
                        .font(.system(size: 20))
                        .foregroundColor(Color.black)
                        .bold(true)
                        .padding(.all)
                        .background(RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray)
                            .opacity(0.5))
                    
                    if posSelected == selectedStates.lastIndex(where: { $0 }) {
                        Button(action: {
                            isPushed.toggle()
                            handleLogin()
                        }, label: {
                            Text(LocalizedStringKey("Finish"))
                                .font(.system(size: 20))
                                .foregroundColor(Color.black)
                                .padding(.all)
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.green)
                                    .opacity(0.5))
                        }).navigationDestination(isPresented: $isPushed) {
                            ThemeSelectorView(currentView: $currentView, currentIndex: $currentIndex, streakCount: $streakCount)
                                .navigationBarBackButtonHidden()
                        }
                    }
                }
            }
        }
    }
    
    func handleLogin() {
        let currentDate = Date()
        // Check if it's the first access or if the last access happened yesterday
        if (lastActualAccessDate == nil  //first access
            || Calendar.current.isDate(lastActualAccessDate!,
                                       inSameDayAs: Calendar.current.date(byAdding: .day,
                                                                          value: -1,
                                                                          to: currentDate)!))
            && (lastRecordedAccessDate != currentDate) {
            streakCount += 1 // Update streak count
            lastRecordedAccessDate = currentDate // Save the current date as the last recorded access date
            print(lastActualAccessDate ?? " ")
            print(lastRecordedAccessDate ?? " ")
            print(currentDate)
            print("funzione login")
        }
        else {
            streakCount = 1 // Reset streak count
            print("funzione login")
        }
        
        lastActualAccessDate = currentDate // Save last actual access date
        UserDefaults.standard.set(streakCount, forKey: "streakCount") // Save streak count
        UserDefaults.standard.set(lastActualAccessDate, forKey: "lastActualAccessDate") // Save last actual access date
        UserDefaults.standard.set(lastRecordedAccessDate, forKey: "lastRecordedAccessDate") // Save last recorded access date
    }
    
}


struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    @Binding var filter: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return ViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        let vc = uiViewController as! ViewController
        vc.changefilter(nameFilter: filter)
        print("funzione chiamata")
    }
}


