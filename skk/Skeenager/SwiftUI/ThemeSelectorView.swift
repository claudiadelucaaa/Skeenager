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
        VStack(alignment: .center) {
            
            HStack {
                Image(systemName: "info")
                Spacer()
                Image(systemName: "info")
            }.padding(.all)
                .padding(.bottom,90)
            
            FilterScrollView(filters: Filter())
            
            Button(action: {
                currentView = .products
            }, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundStyle(Color.black)
                        .frame(height: 60)
                    Text("Start")
                        .font(Font.custom("Urbanist-Regular", size: 20))
                        .foregroundStyle(Color.white)
                }.padding(.all)
                
                
            })
            Spacer()
        }
        
    }
}

struct FilterScrollView: View {
    @State var currentIndex: Int = 0
    @GestureState var dragOffset: CGFloat = 0

    var filters: Filter
    //    DA ORA IN POI
    var body: some View {
        VStack {
            Text("Choose your Theme")
                .font(Font.custom("Urbanist-SemiBold", size: 30))
            ZStack{
                ForEach(filters.filterList.indices, id: \.self) { index in
                    let filter = filters.filterList[index]
                    VStack {
                        Image(filter.image)
                            .resizable()
                            .frame(width: 300.0, height: 300.0)
                            .cornerRadius(10)
                            .scaledToFit()
                        
                        // Use the image name as a tag
                        
                        Text(filter.name)
                            .font(Font.custom("Urbanist-Regular", size: 20))
                        
                    }.tag(index)
                        .opacity(currentIndex == index ? 1.0 : 0.5)
                        .scaleEffect(currentIndex == index ? 1.0 : 0.6)
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
