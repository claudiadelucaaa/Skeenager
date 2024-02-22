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
    var body: some View {
        VStack {
            Text("Select your products")
                .font(.system(size: 30))
            Rectangle()
                .frame(width: 300, height: 2)
            
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomePage()
}
