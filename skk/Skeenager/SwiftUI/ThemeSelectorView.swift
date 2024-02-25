//
//  ThemeSelectorView.swift
//  Skeenager
//
//  Created by Claudia De Luca on 22/02/24.
//

import SwiftUI

struct ThemeSelectorView: View {
    var body: some View {
        
        Text("CHOOSE A THEME")
            .fontDesign(.serif)
        FilterScrollView()
    }
}


struct FilterScrollView: View {
    let themeNames = [
        "1",
        "2",
        "3"
    ]
    var body: some View {
        TabView {
            ForEach(themeNames, id: \.self) { themeName in
                Image(themeName)
                    .resizable()
                    .scaledToFit()
                    .tag(themeName) // Use the image name as a tag
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
#Preview {
    ThemeSelectorView()
}
