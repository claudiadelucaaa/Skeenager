//
//  HomePage.swift
//  Skeenager
//
//  Created by Raffaele Marino  on 21/02/24.
//

import SwiftUI

struct HomePage: View {
    @State private var isButtonClicked = false
    @State var scale = 0.5
    @State private var selectedStates = Array(repeating: false, count: Steps().stepsList.count)
    @State var currentView: CurrentView = .logo
    @State var currentIndex = 0
    @Binding var streakCount: Int
    
    @Binding var changeView: Bool
    
    var body: some View {
        switch currentView {
        case .logo:
            AppLogo(currentView: $currentView)
        case .theme:
            ThemeSelectorView(currentView: $currentView, currentIndex: $currentIndex, streakCount: $streakCount)
        case .products:
            PageProducts(currentIndex: currentIndex)
        case .ar:
            ButtonView(selectedStates: $selectedStates, steps: Steps(), filters: Filter(), filterSelected: "", stepSelected: "", posSelected: 0, currentView: $currentView, currentIndex: $currentIndex)
        }
    }
}

struct PageProducts: View {
    @State private var selectedStates = Array(repeating: false, count: Steps().stepsList.count)
    @State var currentView: CurrentView = .logo
    @State var currentIndex: Int
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer(minLength: 250)
                Text(LocalizedStringKey("What products do you want to use today?"))
                    .font(Font.custom("Urbanist-SemiBold", size: 35, relativeTo: .title))
                    .frame(width: 350, height: 100)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 150)
                SelectYourProducts(selectedStates: $selectedStates, steps: Steps())
                Spacer(minLength: 150)
                NavigationLink {
                    ButtonView(selectedStates: $selectedStates, steps: Steps(), filters: Filter(), filterSelected: "", stepSelected: "", posSelected: 0, currentView: $currentView, currentIndex: $currentIndex)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 40)
                            .foregroundStyle(Color.black)
                            .frame(height: 60)
                        Text(LocalizedStringKey("Start"))
                            .font(Font.custom("Urbanist-Regular", size: 20))
                            .foregroundStyle(Color.white)
                    }
                }
                Spacer(minLength: 150)
            }.padding(.all)
        }
    }
}

struct OnboardingProducts: View {
    @State private var selectedStates = Array(repeating: false, count: Steps().stepsList.count)

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(LocalizedStringKey("What products do you already have?"))
                .font(Font.custom("Urbanist-SemiBold", size: 35, relativeTo: .title))
//                .frame(width: 350)
                .multilineTextAlignment(.leading)
            Spacer(minLength: 150)
            SelectYourProducts(selectedStates: $selectedStates, steps: Steps())
            Spacer(minLength: 250)
        }.padding(.all)
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
    
    @State var selectedInfo: Bool = false
    @State var showInfo = false
    @State var info: String = ""
    @State var name: String = ""
    @State private var selectedInfoIndex: Int? = nil
    
    var steps: Steps
    let disabled: Color = .white
    
    let numberOfRows = 4
    let buttonsPerRow = 2
    let horizontalSpacing: CGFloat = -20
    
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
            ForEach(steps.stepsList.indices, id: \.self){
                index in
                var step = steps.stepsList[index]
                ZStack{
                    Button(action: {
                        selectedStates[index].toggle()
                        if selectedStates[index] {
                            selectedInfoIndex = index
                            info = step.info
                            step.isSelected = true
                            print(selectedStates[index])
                            print(index)
                        } else {
                            selectedInfoIndex = nil
                        }
                        saveSelectedStates() // Save the selectedStates whenever it changes
                    }, label: {
                        ZStack {
                            Text(LocalizedStringKey(step.name))
                                .font(Font.custom("Urbanist-Regular", size: 20, relativeTo: .body))
                        }
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
        }
    }
}


//#Preview {
//    PageProducts(currentIndex: .constant(0))
//}
