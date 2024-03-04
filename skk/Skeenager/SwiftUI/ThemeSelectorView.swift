//
//  ThemeSelectorView.swift
//  Skeenager
//
//  Created by Claudia De Luca on 22/02/24.
//

import SwiftUI

struct ThemeSelectorView: View {
    @Binding var currentView: CurrentView
    @Binding var currentIndex: Int
    @Binding var streakCount: Int
    @State var selectedIndex = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                
                VStack {
                    Spacer(minLength: 100)
                    FilterScrollView(streakCounter: $streakCount, selectedIndex: $selectedIndex, filters: Filter())
                    Spacer()
                    NavigationLink(destination: {
                        PageProducts(currentIndex: currentIndex, selectedIndex: selectedIndex)
                            .navigationBarBackButtonHidden()
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 40)
                                .foregroundStyle(Color.black)
                                .frame(height: 60)
                            Text(LocalizedStringKey("Start"))
                                .font(Font.custom("Urbanist-Regular", size: 20))
                                .foregroundStyle(Color.white)
                        }.padding(.all)
                        
                        
                    })
                    Spacer(minLength: 50)
                }.frame(width: 400, height: 900, alignment: .center)
            }
        }
    }
}

struct FilterScrollView: View {
    @State var currentIndex: Int = 0
    @GestureState var dragOffset: CGFloat = 0
    @Binding var streakCounter: Int
    //variabile per selezionare il Tema
    @Binding var selectedIndex: Int
    
    var filters: Filter
    
    var body: some View {
        VStack {
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(Color.gray)
                        .opacity(0.2)
                        .overlay(RoundedRectangle(cornerRadius: 40).stroke( Color.gray))
                    
                    HStack{
                        Image("StreakImage")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Spacer()
                        Text(String(streakCounter))
                            .font(Font.custom("Urbanist-Regular", size: 20))
                    }.padding(.horizontal, 10)
                }.frame(width: 80,height: 41)
                Spacer()
            }.padding(.horizontal)
            Spacer(minLength: 50)
            VStack {
                Text(LocalizedStringKey("Choose your Theme"))
                    .font(Font.custom("Urbanist-SemiBold", size: 30))
                    .foregroundStyle(Color.black)
                
                Text(LocalizedStringKey("Be guided by the theme that represents you the most!"))
                    .font(Font.custom("Urbanist-Regular", size: 20))
                    .foregroundStyle(Color.secondary)
                
            }.frame(width: 300)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            ZStack{
                ForEach(filters.filterList.indices, id: \.self) { index in
                    let filter = filters.filterList[index]
                    VStack {
//                        Button(action: {
//                            //quando si seleziona il tema isLock diventa true
//                            selectedIndex = index
//                            filter.isLock = true
//                            print(filter.isLock)
//                        }, label: {
                            ZStack {
                                Image(filter.image)
                                    .resizable()
                                    .frame(width: 320.0, height: 320.0)
                                    .cornerRadius(10)
                                    .scaledToFit()
                                    .shadow(radius: 10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: selectedIndex == index ? 2 : 0)
                                    )
                                if selectedIndex == index {
                                    Text("Selected")
                                        .frame(width: 80, height: 50)
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                        
                                }
                            }.onTapGesture {
                                selectedIndex = index
                            }
//                        })
                        .simultaneousGesture(DragGesture().onChanged({ value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold {
                                withAnimation {
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } else if value.translation.width < -threshold {
                                withAnimation {
                                    currentIndex = min(filters.filterList.count - 1,
                                                       currentIndex + 1)
                                }
                            }
                        }))
                        
                        Spacer(minLength: 20)
                        Text(LocalizedStringKey(filter.name))
                            .font(Font.custom("Urbanist-Regular", size: 20))
                            .padding(.bottom)
                    }.tag(index)
                        .opacity(currentIndex == index ? 2.0 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.0 : 0.7)
                        .offset(x: CGFloat(index - currentIndex) * 275 + dragOffset, y: 0)
                }
            }//.gesture(
//                            DragGesture()
//                                .onEnded({ value in
//                                    let threshold: CGFloat = 50
//                                    if value.translation.width > threshold {
//                                        withAnimation {
//                                            currentIndex = max(0, currentIndex - 1)
//                                        }
//                                    } else if value.translation.width < -threshold {
//                                        withAnimation {
//                                            currentIndex = min(filters.filterList.count - 1,
//                                                               currentIndex + 1)
//                                        }
//                                    }
//                                })
//                        )
            Spacer(minLength: 50)
        }
    }
}

#Preview {
    ThemeSelectorView(currentView: .constant(.products), currentIndex: .constant(0), streakCount: .constant(0), selectedIndex: 0)
}
