//
//  StepsSelectorView.swift
//  Skeenager
//
//  Created by Claudia De Luca on 21/02/24.
//

import SwiftUI

struct StepsSelectorView: View {
    var body: some View {
        VStack {
            Text("PRODUCT")
                .font(Font.custom("MyFont.tff", size: 32, relativeTo: .title))
            Text("_____________________________")
        }
        Spacer()
        ShowSteps()
        Spacer()
        Button(action: {
            
        }, label: {
            Text("Press To Start")
        })
        Spacer()
    }
}

struct ShowSteps: View {
    
    @State var isPresented = false
    @State var isSelected = false
    @State private var goalTypeFilter: steps? = nil

    @State private var stepSelected: String = "CLEANSER"
    @State private var showInfo: String = ""
    
    let steps = Steps()
    let disabled: Color = .gray
    var body: some View {
        
        
        ForEach(steps.stepsList, id: \.self){
            step in
            Button(action: {
                isSelected.toggle()
                if isSelected {
                    stepSelected = step.name
//                    print(stepSelected)
                    showInfo = step.info
//                    print(showInfo)
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black)
                        .fill(goalTypeFilter == step ? step.color : disabled)
                    
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
                 
                .frame(width: 380.0, height: 60.0)
                .foregroundColor(.black)
                .padding(.horizontal)
                .padding(.vertical, 5)
            })
        }
        
        //        ForEach(steps.stepsList, id: \.self){
        //            step in
        //            HStack {
        //                Text(step.name)
        //                    .font(Font.custom("MyFont", size: 20))
        //                Spacer()
        //                Button(action: {
        //                    isPresented.toggle()
        //                }, label: {
        //                    Image(systemName: "info.circle")
        //                })
        //                .sheet(isPresented: $isPresented, content: {
        //                    Text(step.info)
        //                })
        //            }
        //            .padding(.horizontal)
        //        }
    }
}


#Preview {
    StepsSelectorView()
}
