//
//  bottonView.swift
//  skk
//
//  Created by Claudia De Luca on 20/02/24.
//

import SwiftUI

struct ButtonView: View {
    
    @ObservedObject var steps: Steps
    @State var filterSelected: String
    @State var stepSelected: String
    @State var posSelected: String
    @State var lastProduct: Bool = false
     
    var body: some View {
        ZStack{
            BasicUIViewControllerRepresentable(filter: $filterSelected)
                .ignoresSafeArea()
            VStack{
                HStack{
                    ForEach(steps.stepsList.indices, id: \.self) {
                        index in
                        let step = steps.stepsList[index]
                        if step.isSelected == true {
                            Button(action: {
                                filterSelected = step.filte
                                stepSelected = step.name
                                posSelected = step.pos
                            }, label: {
                                
                                Text(step.pos)
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
                }
                
                Spacer()
                
                if posSelected == "7" {
                    VStack {
                        Text("Step " + posSelected + ": " + stepSelected)
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                            .bold(true)
                            .padding(.all)
                            .background(RoundedRectangle(cornerRadius: 20)
                                .fill(Color.gray)
                            .opacity(0.5))
                        Button {
                            
                        } label: {
                            Text("Finish!")
                                .font(.system(size: 20))
                                .foregroundColor(Color.black)
                                .bold(true)
                                .padding(.all)
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.green)
                                    .opacity(0.5))
                        }
                    }
                }
                
                else {
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
        .onAppear {
            print(steps.stepsList)
        }
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
    ButtonView(steps: Steps(), filterSelected: "", stepSelected: "", posSelected: "")
}

