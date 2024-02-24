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
                    SelectYourProducts(info: "")
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
    @State var showInfo = false
    @State var info: String
    @State private var goalTypeFilter: steps? = nil
    @State private var stepSelected: String = "CLEANSER"
    //    @State private var showInfo: String = ""
    
    let steps = Steps()
    let disabled: Color = .gray
    var body: some View {
        
        VStack {
            Text("Select your products")
                .font(.system(size: 40))
                .frame(width: 350)
                .multilineTextAlignment(.center)
            Rectangle()
                .frame(width: 350, height: 1)
            ForEach(steps.stepsList){
                step in
                ZStack{
                    Button(action: {
                        isSelected.toggle()
                        print("ciao")
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black)
                                .fill(goalTypeFilter == step ? step.color : disabled)
                                .opacity(0.2)
                                .shadow(radius: 5, x: 0, y: 10)
                                .frame(width: 360, height:60)
                            
                            HStack {
                                Text(step.pos + ".")
                                    .padding(.leading)
                                Text(step.name)
                                Spacer()
                            }
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
                        .frame(width: 250.0, height: 60.0)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                    })
                    HStack {
                        Spacer(minLength: 300)
                        Button(action: {
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
                        Spacer()
                    }
                }
                .fontDesign(.serif)
            }
        }
    }
}


#Preview {
    SelectYourProducts(info: "")
}
