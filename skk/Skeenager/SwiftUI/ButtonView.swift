//
//  bottonView.swift
//  skk
//
//  Created by Claudia De Luca on 20/02/24.
//

import SwiftUI

struct ButtonView: View {
    
    var steps = Steps()
    @State var filterSelected: String
    
    var body: some View {
        ZStack{
            BasicUIViewControllerRepresentable(filter: $filterSelected)
                .ignoresSafeArea()
            VStack{
                ForEach(steps.stepsList, id: \.self) {
                    stepList in
                    Button(action: {
                        filterSelected = stepList.filte
                        print(filterSelected)
                    }, label: {
                        Text(stepList.name)
                    })

                }
            }
           
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
    
    @Binding var filter: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return ViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        let vc = uiViewController as! ViewController
        vc.changefilter(nameFilter: filter)
        print("funzione chiamata")
    }
}


#Preview {
    ButtonView(filterSelected: "")
}

