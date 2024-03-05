//
//  bottonView.swift
//  skk
//
//  Created by Claudia De Luca on 20/02/24.
//

import SwiftUI

struct ButtonView: View {
    //for ForEach
    var steps: Steps
    @Binding var selectedStates: [Bool]
    
    //temp var for store -filter; -nameStep; -pos
    @State var filterSelected = ""
    @State var stepSelected = ""
    @State var posSelected = 0
    
    //for navigation
    @State private var isPushed = false
    
    @Binding var currentView: CurrentView
    @State var currentIndex: Int
    
    //Streak Counter
    @State private var lastActualAccessDate: Date?
    @State private var lastRecordedAccessDate: Date?
    @State var streakCount: Int = UserDefaults.standard.integer(forKey: "streakCount")
    
    //for transition
    @GestureState var dragOffset: CGFloat = 0
    
    //Init
    init(selectedStates: Binding<[Bool]>, currentView: Binding<CurrentView>, currentIndex: State<Int>, steps: Steps) {
        self._selectedStates = selectedStates
        self._currentView = currentView
        self.steps = steps
        self._currentIndex = currentIndex
    }
    
    var body: some View {
        ZStack{
            BasicUIViewControllerRepresentable(filter: $filterSelected)
                .ignoresSafeArea()
            ZStack {
                
                ForEach(steps.rainbowList.indices, id: \.self) { ind in
                    let step = steps.rainbowList[ind]
                    VStack {
                        Spacer()
                        if selectedStates[ind] == true {
                            let trueCount = selectedStates.filter { $0 }.count
                            
                            HStack{
                                ZStack {
                                    RoundedRectangle(cornerRadius: 40)
                                        .fill(Color.gray)
                                        .opacity(0.5)
                                    
                                    VStack{
                                        Text(LocalizedStringKey(step.name))
                                        Text(String(step.pos+1) + "|" + String(trueCount))
                                    }.padding(.all)
                                }
                                
                                if ((posSelected+1) == selectedStates.lastIndex(where: { $0 })) || ((posSelected) == selectedStates.count) {
                                    Button {
                                        isPushed.toggle()
                                        handleLogin()
                                    } label: {
                                        Image(systemName: "checkmark")
                                            .padding(.all)
                                            .background(Circle()
                                                .fill(Color.gray)
                                                .opacity(0.5)
                                                .frame(width: 40.0, height: 40.0))
                                    }.navigationDestination(isPresented: $isPushed) {
                                        ThemeSelectorView(streakCount: $streakCount)
                                            .navigationBarBackButtonHidden()
                                    }
                                } else{
                                    Button {
                                        currentIndex += 1
                                        filterSelected = step.filte
                                        posSelected = step.pos
                                    } label: {
                                        Image(systemName: "arrow.forward")
                                            .padding(.all)
                                            .background(Circle()
                                                .fill(Color.gray)
                                                .opacity(0.5)
                                                .frame(width: 40.0, height: 40.0))
                                    }
                                }
                                
                                
                            }.font(Font.custom("Urbanist-SemiBold", size: 20))
                                .frame(width: 350.0, height: 80)
                                .foregroundStyle(Color.black)
                        }
                    }.tag(ind)
                        .opacity(currentIndex == ind ? 2.0 : 0.5)
                    //                        .scaleEffect(currentIndex == ind ? 1.0 : 0.7)
                        .offset(x: CGFloat(ind - currentIndex) * 350 + dragOffset, y: 0)
                }
            }
            .onAppear {
                // Find the index of the first selected step
                if let index = selectedStates.firstIndex(where: { $0 }) {
                    filterSelected = steps.rainbowList[index].filte
                    stepSelected = steps.rainbowList[index].name
                    posSelected = steps.rainbowList[index].pos
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


