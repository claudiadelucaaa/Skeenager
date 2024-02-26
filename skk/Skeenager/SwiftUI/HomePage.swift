//
//  HomePage.swift
//  Skeenager
//
//  Created by Raffaele Marino  on 21/02/24.
//

import SwiftUI

struct HomePage: View {
    @State private var isButtonClicked = false
    @State private var selectedStates = Array(repeating: false, count: Steps().stepsList.count)
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Skeenager")
                    .font(.system(size: 55))
                    .frame(height: 80)
                
                Rectangle()
                    .frame(width: 300, height: 2)
                
                NavigationLink(destination: {
                    PageProducts()
                        .navigationBarBackButtonHidden(true)
                }, label: {
                    Text("Welcome")
                        .font(.system(size: 30))
                        .frame(width: 200, height: 50)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.black, lineWidth: 3)
                                .shadow(radius: 2, x: 0, y: 5))
                }).padding(.top)
                
                Spacer()
            }.fontDesign(.serif)
        }
    }
}

struct PageProducts: View {
    @State private var selectedStates = Array(repeating: false, count: Steps().stepsList.count)
    
    var body: some View {
        NavigationStack {
            Text("Select your products")
                .font(.system(size: 30))
                .frame(width: 350)
                .multilineTextAlignment(.center)
            Rectangle()
                .frame(width: 350, height: 1)
            SelectYourProducts(selectedStates: $selectedStates, steps: Steps())
            
            NavigationLink {
                ButtonView(selectedStates: $selectedStates, steps: Steps(), filterSelected: "", stepSelected: "", posSelected: 0)
            } label: {
                Text("Start") 
                    .font(.system(size: 20))
                    .foregroundColor(Color.white)
                    .padding(.all)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black))
            }
        }
        .fontDesign(.serif)
    }
}

struct SelectYourProducts: View {
    @Binding var selectedStates: [Bool]
    var steps: Steps
    @State var selectedInfo: Bool = false
    @State var showInfo = false
    @State var info: String = ""
    @State private var selectedInfoIndex: Int? = nil
    //    @State private var stepSelected: String = "CLEANSER"
    
    //    @State var steps = Steps()
    let disabled: Color = .gray
    
    //    init() {
    //        _selectedStates = State(initialValue: Array(repeating: false, count: steps.stepsList.count))
    //
    //    }
    
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
                        }
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
                            Text("INFO")
                                .font(.system(size: 40))
                                .frame(width: 350)
                            Rectangle()
                                .frame(width: 350, height: 2)
                            
                            Text(info)
                                .font(.system(size: 20))
                                .frame(width: 300)
                        }
                    })
                }
            }
            .fontDesign(.serif)
        }
    }
}


#Preview {
    HomePage()
}
