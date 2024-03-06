//
//  HomePage.swift
//  Skeenager
//
//  Created by Raffaele Marino  on 21/02/24.
//

import SwiftUI

struct HomePage: View {
    @State var currentView: CurrentView = .logo
    
    @Binding var streakCount: Int
        
    var body: some View {
        switch currentView {
        case .logo:
            AppLogo(currentView: $currentView)
        case .theme:
            ThemeSelectorView(streakCount: $streakCount)
        }
    }
}

struct PageProducts: View {
    @State private var selectedStates = Array(repeating: false, count: Steps().rainbowList.count)
    @State var currentView: CurrentView = .logo
    @State var currentIndex: Int
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack{
                    Spacer()
                    
                    VStack(alignment: .leading) {
                    Text(LocalizedStringKey("What products do you want to use today?"))
                        .font(Font.custom("Urbanist-SemiBold", size: 30))
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color.black)
                    
                    Text(LocalizedStringKey("Select your products".uppercased()))
                        .font(Font.custom("Urbanist-Regular", size: 13))
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(Color.gray)
                }.frame(width: 300)
                .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    SelectYourProducts(selectedStates: $selectedStates, steps: Steps()).padding(.horizontal)
                    
                    Spacer()
                    
                    NavigationLink {
                        ButtonView(selectedStates: $selectedStates, currentView: $currentView, currentIndex: _currentIndex, steps: Steps())
                            .navigationBarBackButtonHidden()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 40)
                                .foregroundStyle(Color.black)
                                .frame(height: 60)
                            
                            Text(LocalizedStringKey("Start"))
                                .font(Font.custom("Urbanist-Regular", size: 20))
                                .foregroundStyle(Color.white)
                        }.padding(.all)
                    }
                }
            }
        }
    }
}

struct OnboardingProducts: View {
    @State private var selectedStates = Array(repeating: false, count: Steps().rainbowList.count)
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack{
                Spacer()
                
            VStack {
                Text(LocalizedStringKey("What products do you already have?"))
                    .font(Font.custom("Urbanist-SemiBold", size: 30))
                    .foregroundStyle(Color.black)
                
                Text(LocalizedStringKey("Select your products"))
                    .font(Font.custom("Urbanist-Regular", size: 20))
                    .foregroundStyle(Color.gray)
            }.frame(width: 300)
            .multilineTextAlignment(.center)
                
                Spacer()
                
                SelectYourProducts(selectedStates: $selectedStates, steps: Steps()).padding(.horizontal)
                
                Spacer()
                Spacer()
            }
        }
    }
}


struct OverflowLayout: Layout {
    var spacing = CGFloat(10)
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let containerWidth = proposal.replacingUnspecifiedDimensions().width
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        return layout(sizes: sizes, containerWidth: containerWidth).size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let offsets = layout(sizes: sizes, containerWidth: bounds.width).offsets
        for (offset, subview) in zip(offsets, subviews) {
            subview.place(at: CGPoint(x: offset.x + bounds.minX, y: offset.y + bounds.minY), proposal: .unspecified)
        }
    }
    
    func layout(sizes: [CGSize], containerWidth: CGFloat) -> (offsets: [CGPoint], size: CGSize) {
        var result: [CGPoint] = []
        var currentPosition: CGPoint = .zero
        var lineHeight: CGFloat = 0
        var maxX: CGFloat = 0
        for size in sizes {
            if currentPosition.x + size.width > containerWidth {
                currentPosition.x = 0
                currentPosition.y += lineHeight + spacing
                lineHeight = 0
            }
            
            result.append(currentPosition)
            currentPosition.x += size.width
            maxX = max(maxX, currentPosition.x)
            currentPosition.x += spacing
            lineHeight = max(lineHeight, size.height)
        }
        
        return (result, CGSize(width: maxX, height: currentPosition.y + lineHeight))
    }
}

struct SelectYourProducts: View {
    @Binding var selectedStates: [Bool]
    
    var steps: Steps
    let disabled: Color = .white
    
    private func saveSelectedStates() {
        UserDefaults.standard.set(selectedStates, forKey: "selectedStates")
    }
    
    // Retrieve the selectedStates from UserDefaults
    private func loadSelectedStates() {
        if let savedSelectedStates = UserDefaults.standard.array(forKey: "selectedStates") as? [Bool] {
            selectedStates = savedSelectedStates
        }
    }
    
    var body: some View {
        OverflowLayout(spacing: 16) {
            
            ForEach(steps.rainbowList.indices, id: \.self){
                index in
                var step = steps.rainbowList[index]
                ZStack{
                    Button(action: {
                        selectedStates[index].toggle()
                        
                        if selectedStates[index] {
                            step.isSelected = true
                        }
                        
                        saveSelectedStates() // Save the selectedStates whenever it changes

                    }, label: {
                        Text(LocalizedStringKey(step.name))
                            .font(Font.custom("Urbanist-Regular", size: 20, relativeTo: .body))
                            .foregroundStyle(selectedStates[index] ? .white : .black)
                            .padding()
                            .foregroundColor(selectedStates[index] ? .white : .black)
                            .frame(height: 40)
                            .background(selectedStates[index] ? step.color : disabled)
                            .cornerRadius(40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    })
                }
            }
        }.onAppear {
            loadSelectedStates() // Load the selectedStates when the view appears
        }.padding(.vertical)
    }
}


#Preview {
    PageProducts(currentIndex: 0)
}
