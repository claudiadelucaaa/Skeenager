//
//  HomePage.swift
//  Skeenager
//
//  Created by Raffaele Marino  on 21/02/24.
//

import SwiftUI

struct HomePage: View {
    @State private var isButtonClicked = false
    @State var scale = 0.5
    @State private var selectedStates = Array(repeating: false, count: Steps().stepsList.count)
    @State var currentView: CurrentView = .logo
    @State var currentIndex = 0
    
    @Binding var changeView: Bool
    
    var body: some View {
        switch currentView {
        case .logo:
            AppLogo(currentView: $currentView)
        case .theme:
            ThemeSelectorView(currentView: $currentView, currentIndex: $currentIndex)
        case .products:
            PageProducts()
        case .ar:
            ButtonView(selectedStates: $selectedStates, steps: Steps(), filterSelected: "", stepSelected: "", posSelected: 0)
        }
    }
}

struct PageProducts: View {
    @State private var selectedStates = Array(repeating: false, count: Steps().stepsList.count)
    
    var body: some View {
        NavigationStack {
            Text("Select your products")
                .font(Font.custom("Urbanist-SemiBold", size: 30, relativeTo: .title))
                .frame(width: 350)
                .multilineTextAlignment(.center)
            Rectangle()
                .frame(width: 350, height: 1)
            SelectYourProducts(selectedStates: $selectedStates, steps: Steps())
            
            NavigationLink {
                ButtonView(selectedStates: $selectedStates, steps: Steps(), filterSelected: "", stepSelected: "", posSelected: 0)
            } label: {
                Text("Start")
                    .font(Font.custom("Urbanist-Regular", size: 20, relativeTo: .body))
                    .foregroundColor(Color.white)
                    .padding(.all)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black))
            }
        }
    }
}

struct SelectYourProducts: View {
    @Binding var selectedStates: [Bool]
    
    @State var selectedInfo: Bool = false
    @State var showInfo = false
    @State var info: String = ""
    @State var name: String = ""
    @State private var selectedInfoIndex: Int? = nil
    
    var steps: Steps
    let disabled: Color = .gray
    
    var body: some View {
        ForEach(steps.stepsList.indices, id: \.self){
            index in
            var step = steps.stepsList[index]
            ZStack{
                Button(action: {
                    selectedStates[index].toggle()
                    if selectedStates[index] {
                        selectedInfoIndex = index
                        info = step.info
                        step.isSelected = true
                        print(selectedStates[index])
                        print(index)
                    } else {
                        selectedInfoIndex = nil
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black)
                            .fill(selectedStates[index] ? step.color : disabled)
                            .opacity(0.2)
                            .shadow(radius: 5, x: 0, y: 10)
                            .frame(width: 360, height:60)
                        
                        HStack {
                            Text(String(step.pos+1) + ".")
                                .padding(.leading)
                            Text(step.name)
                            Spacer()
                        }.font(Font.custom("Urbanist-Regular", size: 20, relativeTo: .body))
                    }
                    .frame(width: 250.0, height: 60.0)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                })
                HStack {
                    Spacer(minLength: 300)
                    Button(action: {
                        selectedInfo.toggle()
                        selectedInfoIndex = index
                        name = step.name
                        info = step.info
                        showInfo.toggle()
                    }, label: {
                        Image(systemName: "info.circle")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .frame(width: 40, height: 30)
                            .padding()
                    })
                    .sheet(isPresented: $showInfo, content: {
                        VStack {
                            Text(name)
                                .frame(width: 350)
                            Rectangle()
                                .frame(width: 350, height: 2)
                            Text(info)
                                .frame(width: 300)
                        }
                        .font(Font.custom("Urbanist-Regular", size: 20, relativeTo: .body))
                    })
                }
            }
        }
    }
}


//#Preview {
//    HomePage()
//}
