//
//  HomePage.swift
//  Skeenager
//
//  Created by Raffaele Marino  on 21/02/24.
//

import SwiftUI

struct HomePage: View {
    
    @State private var isButtonClicked = false
    
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
                    SelectYourProducts()
                }, label: {
                    Text("Welcome")
                        .font(.system(size: 30))
                        .frame(width: 200, height: 50)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.black, lineWidth: 3)
                                .shadow(radius: 2, x: 0, y: 5)
                        )
                    
                }).padding(.top)
                
                Spacer()
                
                
                
            }.fontDesign(.serif)
        }
    }
}

struct SelectYourProducts: View {
    @State var isPresented = false
    @State var isSelected = false
    @State private var goalTypeFilter: steps? = nil
    @State private var stepSelected: String = "CLEANSER"
    @State private var showInfo: String = ""
    
    let steps = Steps()
    let disabled: Color = .gray
    var body: some View {
        
        VStack {
            Text("Select your products")
                .font(.system(size: 40))
            Rectangle()
                .frame(width: 350, height: 2)
            ForEach(steps.stepsList, id: \.self){
                step in
                Button(action: {
                    isSelected.toggle()
                    if isSelected {
                        stepSelected = step.name
                        showInfo = step.info
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black)
                            .fill(goalTypeFilter == step ? step.color : disabled)
                            .opacity(0.3)
                        
                        HStack {
                            Text(step.name)
                                .font(Font.custom("MyFont", size: 20))
                            
                            Spacer()
                            
                            Image(systemName: "info.circle")
                            
                        }.padding(.horizontal)
                    }
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.2)){
                            if(goalTypeFilter == step){
                                goalTypeFilter = nil
                            }else{
                                goalTypeFilter = step
                            }
                        }
                    }
                    
                    .frame(width: 320.0, height: 60.0)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                })
            }
        }
    }
}

#Preview {
    SelectYourProducts()
}
