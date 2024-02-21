//
//  Model.swift
//  skk
//
//  Created by Claudia De Luca on 21/02/24.
//

import Foundation

struct steps: Hashable {
    var id = UUID()
    var name: String
    var isSelected: Bool
    var time: String = ""
    var filte: String
}

class Steps {
    var stepsList = [
        steps(name: "cleanser", isSelected: false, time: "0", filte: "rainbow"),
        steps(name: "toner", isSelected: false, time: "0", filte: "wireframeTexture"),
        steps(name: "serum", isSelected: false, time: "0", filte: "prova1"),
        steps(name: "treatment", isSelected: false, time: "0", filte: "rainbow"),
        steps(name: "eyeCream", isSelected: false, time: "0", filte: "wireframeTexture"),
        steps(name: "moisturizer", isSelected: false, time: "0", filte: "prova1"),
        steps(name: "sunScreen", isSelected: false, time: "0", filte: "rainbow")
    ]
}
