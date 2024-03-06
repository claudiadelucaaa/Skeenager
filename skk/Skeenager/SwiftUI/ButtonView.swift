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
    @State private var shittyCoding = 1
    
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
    
    // prove
    var arrayProvaTemp: [Int] = []
    
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
                
                ForEach(selectedStates.indices.filter { selectedStates[$0] }, id: \.self) { ind in
                    //                    let isSelected = selectedStates[ind]
                    let trueCount = selectedStates.filter { $0 }.count
                    //                    let step = steps.rainbowList[ind]
                    
                    VStack {
                        Spacer()
                        //                        if isSelected {
                        HStack{
                            ZStack {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.white)
                                    .opacity(0.5)
                                
                                VStack{
                                    Text(LocalizedStringKey(steps.rainbowList[ind].name))
                                    Text(String(shittyCoding) + "|" + String(trueCount))
                                }.padding(.all)
                            }
                            
                            
                            if ((shittyCoding) == trueCount) {
                                Button {
                                    isPushed.toggle()
                                    handleLogin()
                                } label: {
                                    Image(systemName: "checkmark")
                                        .padding(.all)
                                        .background(Circle()
                                            .fill(Color.white)
                                            .opacity(0.5)
                                            .frame(width: 40.0, height: 40.0))
                                }.navigationDestination(isPresented: $isPushed) {
                                    ThemeSelectorView(streakCount: $streakCount)
                                        .navigationBarBackButtonHidden()
                                }
                            } else{
                                Button {
                                    if let nextIndex = selectedStates.indices.dropFirst(currentIndex + 1).first(where: { selectedStates[$0] }) {
                                        currentIndex = nextIndex
                                        filterSelected = steps.rainbowList[nextIndex].filte
                                        posSelected = steps.rainbowList[nextIndex].pos
                                    }
                                    shittyCoding += 1
//                                    filterSelected = steps.rainbowList[ind].filte
//                                    posSelected = steps.rainbowList[ind].pos
                                    //                                        print(adjustedIndex)
                                    print(currentIndex)
                                    print("VALUE OF IN \(ind)")
                                } label: {
                                    Image(systemName: "arrow.forward")
                                        .padding(.all)
                                        .background(Circle()
                                            .fill(Color.white)
                                            .opacity(0.5)
                                            .frame(width: 40.0, height: 40.0))
                                }
                            }
                            
                            
                        }.font(Font.custom("Urbanist-SemiBold", size: 20))
                            .frame(width: 350.0, height: 80)
                            .foregroundStyle(Color.black)
                            .opacity(ind == currentIndex ? 1.0 : 0.0)
                        //                        } else {
                        //                            HStack{
                        //                                ZStack {
                        //                                    RoundedRectangle(cornerRadius: 40)
                        //                                        .fill(Color.white)
                        //                                        .opacity(0.5)
                        //
                        //                                    VStack{
                        //                                        Text(LocalizedStringKey(steps.rainbowList[ind+1].name))
                        //                                        Text(String(steps.rainbowList[ind+1].pos) + "|" + String(trueCount))
                        //                                    }.padding(.all)
                        //                                }
                        //
                        //                                if ((posSelected+1) == selectedStates.lastIndex(where: { $0 })) || ((posSelected) == selectedStates.count) {
                        //                                    Button {
                        //                                        isPushed.toggle()
                        //                                        handleLogin()
                        //                                    } label: {
                        //                                        Image(systemName: "checkmark")
                        //                                            .padding(.all)
                        //                                            .background(Circle()
                        //                                                .fill(Color.white)
                        //                                                .opacity(0.5)
                        //                                                .frame(width: 40.0, height: 40.0))
                        //                                    }.navigationDestination(isPresented: $isPushed) {
                        //                                        ThemeSelectorView(streakCount: $streakCount)
                        //                                            .navigationBarBackButtonHidden()
                        //                                    }
                        //                                } else{
                        //                                    Button {
                        //                                        currentIndex += 1
                        //                                        filterSelected = steps.rainbowList[ind+1].filte
                        //                                        posSelected = steps.rainbowList[ind+1].pos
                        ////                                        print(adjustedIndex)
                        //                                        print(currentIndex)
                        //                                    } label: {
                        //                                        Image(systemName: "arrow.forward")
                        //                                            .padding(.all)
                        //                                            .background(Circle()
                        //                                                .fill(Color.white)
                        //                                                .opacity(0.5)
                        //                                                .frame(width: 40.0, height: 40.0))
                        //                                    }
                        //                                }
                        //                            }.font(Font.custom("Urbanist-SemiBold", size: 20))
                        //                                .frame(width: 350.0, height: 80)
                        //                                .foregroundStyle(Color.black)
                        //                                .opacity(ind == currentIndex ? 1.0 : 0.0)
                        //                        }
                    }
                }
            }
            .onAppear {
                // Find the index of the first selected step
                if let index = selectedStates.firstIndex(where: { $0 }) {
                    filterSelected = steps.rainbowList[index].filte
                    stepSelected = steps.rainbowList[index].name
                    posSelected = steps.rainbowList[index].pos
                    currentIndex = index
                }
                print(selectedStates.indices.filter { selectedStates[$0]})
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


