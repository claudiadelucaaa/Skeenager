//
//  bottonView.swift
//  skk
//
//  Created by Claudia De Luca on 20/02/24.
//

import SwiftUI

struct buttonView: View {
    
    @State private var showScreen = false
    
    var body: some View {
        ZStack{
            BasicUIViewControllerRepresentable()
                .ignoresSafeArea()
            
            Button(action: {
                
            }, label: {
                Text("PUTA MADRE")
            })
        }
        
//        ZStack {
//            Button(action: {
//                showScreen.toggle()
//            }, label: {
//                Text("Click")
//            })
//            .sheet(isPresented: $showScreen, content:{ BasicUIViewControllerRepresentable(labelText: "Ciao")
//            })
//            //Text("ewfh3rifgq")
//        }
        
    }
}

struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return ViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}


#Preview {
    buttonView()
}

