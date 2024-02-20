//
//  bottonView.swift
//  skk
//
//  Created by Claudia De Luca on 20/02/24.
//

import SwiftUI

struct bottonView: View {
    
    @State private var showScreen = false
    
    var body: some View {
        ZStack {
            Button(action: {
                showScreen.toggle()
            }, label: {
                Text("Click")
            })
            .sheet(isPresented: $showScreen, content:{ BasicUIViewControllerRepresentable(labelText: "Ciao")
            })
            //Text("ewfh3rifgq")
        }
        
    }
}

struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    let labelText: String
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = ViewController()
        vc.labelText = labelText
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}


#Preview {
    bottonView()
}

