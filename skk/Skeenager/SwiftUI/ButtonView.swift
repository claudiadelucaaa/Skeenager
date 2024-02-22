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
    @State var stepSelected: String
    @State var posSelected: String
     
    var body: some View {
        ZStack{
            BasicUIViewControllerRepresentable(filter: $filterSelected)
                .ignoresSafeArea()
            VStack{
                HStack{
                    ForEach(steps.stepsList, id: \.self) {
                        stepList in
                        Button(action: {
                            filterSelected = stepList.filte
                            stepSelected = stepList.name
                            posSelected = stepList.pos
                            
                            
                            //                        print(filterSelected)
                        }, label: {
                            
                            Text(stepList.pos)
                                .font(.system(size: 20))
                                .foregroundColor(Color.black)
                                .bold(true)
                                .padding(.all)
                                .background(Circle()
                                    .fill(Color.gray)
                                    .opacity(0.5)
                                    .frame(width: 40.0, height: 40.0))
                        })
                    }
                }
                
                Spacer()
                
                Text("Step " + posSelected + ": " + stepSelected)
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
                    .bold(true)
                    .padding(.all)
                    .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray)
                        .opacity(0.5))
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
    ButtonView(filterSelected: "", stepSelected: "", posSelected: "")
}

