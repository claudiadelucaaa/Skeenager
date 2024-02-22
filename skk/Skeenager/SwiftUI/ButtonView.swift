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
            VStack(spacing: 20){
                ForEach(steps.stepsList, id: \.self) {
                    stepList in
                    Button(action: {
                        filterSelected = stepList.filte
                        print(filterSelected)
                    }, label: {
                        VStack {
                            Text("Step " + stepList.pos)
                                .font(.title)
                                .foregroundColor(Color.black)
                                .bold(true)
                            Text(stepList.name)
                                .foregroundColor(Color.black)
                        }
                    })
                    .background(RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(Color.gray)
                        .opacity(0.3)
                        .frame(width: 100.0, height: 70.0))

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

