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
    var body: some View {
        ZStack {
            Image("onBoard1")
            
            VStack {
                
                FilterScrollView(filters: Filter())
                
                Button(action: {
                    currentView = .products
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
            }.frame(width: 400, height: 900, alignment: .center)
        }
    }
}

struct FilterScrollView: View {
    @State var currentIndex: Int = 0
    @GestureState var dragOffset: CGFloat = 0
    var filters: Filter
    
    var body: some View {
        VStack {
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
                        Image(filter.image)
                            .resizable()
                            .frame(width: 347.0, height: 347.0)
                            .cornerRadius(10)
                            .scaledToFit()
                        
                        Text(LocalizedStringKey(filter.name))
                            .font(Font.custom("Urbanist-Regular", size: 20))
                    }.tag(index)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.0 : 0.4)
                        .offset(x: CGFloat(index - currentIndex) * 240 + dragOffset, y: 0)
                }
            }.gesture(
                DragGesture()
                    .onEnded({ value in
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
                    })
            )
        }
    }
}

#Preview {
    ThemeSelectorView(currentView: .constant(.products), currentIndex: .constant(0))
}
