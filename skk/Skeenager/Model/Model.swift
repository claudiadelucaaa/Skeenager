//
//  Model.swift
//  skk
//
//  Created by Claudia De Luca on 21/02/24.
//

import Foundation
import SwiftUI

struct steps: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var pos: Int
    var info: String
    var isSelected: Bool
    var time: String = ""
    var filte: String
    var color: Color = .white
}

class Steps {
    var stepsList = [
        steps(name: "CLEANSER",
              pos: 0,
              info: "In the morning, wash with a gentle face cleanser designed for your skin type. \nUse a wet washcloth to remove.",
              isSelected: false,
              time: "0",
              filte: "rainbow"),
        steps(name: "TONER",
              pos: 1,
              info: "If you’re thinking about skipping this step, think again.  \nOld-school toners were created to restore the skin’s pH after using harsh old-school soaps—but both toners and soaps have improved over the years.  \nToners are not the end of cleansing, they’re the beginning of your skincare mission! \n They prep the skin for hydration, making it better able to absorb products. They can exfoliate, firm, balance the skin—or all three.",
              isSelected: false,
              time: "0",
              filte: "wireframeTexture"),
        steps(name: "SERUM",
              pos: 2,
              info: "Serums are targeted treatments with a light consistency designed to penetrate the skin, so they come next in your routine. \nFor daytime, a lot of dermatologist recommends antioxidant vitamin C. Not only are antioxidants the first line of defense against environmental damage and skin aging, but Vitamin C offers natural photo protection against UVA and UVB rays. \nChosen based on your skin type and condition, these wonder products visibly even skin tone, soothe and support healthy collagen.",
              isSelected: false,
              time: "0",
              filte: "prova1"),
        steps(name: "TREATMENT",
              pos: 3,
              info: "Acne spot treatments were just for teenagers, but most of us struggle with occasional blemishes. \nIf it’s a big blemish, treat it right after your toner. If it’s not so bad, apply spot treatment after serum and before moisturizer.",
              isSelected: false,
              time: "0",
              filte: "faceClouds"),
        steps(name: "EYE CREAM",
              pos: 4,
              info: "Eye cream deserves its own step: it’s formulated especially to hydrate and protect this delicate tissue as well as stay put and not migrate into the eyes. \nEye creams can also firm the skin and address dark circles and puffiness—apply gently, and a little goes a long way!",
              isSelected: false,
              time: "0",
              filte: "eyesClouds"),
        steps(name: "MOISTURIZER",
              pos: 5,
              info: "EVERYONE NEEDS A MOISTURIZER EVEN IF YOU HAVE OILY SKIN! \nYes, the skin produces its own oil (or sebum) to coat and protect the skin, but it’s often no match for damaging UV rays and environmental conditions. \nWhat’s the best time to apply moisturizer? Right now, while the skin is still damp from applying serums. Tailor your moisturizer to your skin type for best results.",
              isSelected: false,
              time: "0",
              filte: "ale"),
        steps(name: "SUNSCREEN",
              pos: 6,
              info: "Sunscreen is the non-negotiable last step of your morning skincare routine. We recommend mineral sunscreen, which works by reflecting UV rays and is perfect for sensitive skin. \nMoisturizers and foundations that advertise SPF don’t contain enough to be effective. To protect your skin and the routine you’ve so carefully applied, don’t skip sunscreen. \nTIP: Apply a half-teaspoon of sunscreen of at least SPF 30 to the face (all the way to the hairline), ears, neck, and décolleté. Reapply throughout the day. \n Or check out our full SPF assortment for a variety of shade and finish options. \nTIP for darker skin tones: Make sure skin is well hydrated before applying SPF, whether sheer or tinted. Moisturized skin helps avoid a chalky cast from mineral sunscreen (which is really the best kind!).",
              isSelected: false,
              time: "0",
              filte: "ale2")
    ]
}

//enum FilterEnum : String, Codable, CaseIterable {
//    case cleanser = "Cleanser"
//    case toner = "Toner"
//    case serum = "Serum"
//    case treatment = "Treatment"
//    case eyeCream = "EyeCream"
//    case moisturizer = "Moisturizer"
//    case sunscreen = "Sunscreen"
//    
//    var filter: String {
//        switch self{
//        case .cleanser:
//            return "rainbow"
//        case .toner:
//            return "rainbow"
//        case .serum:
//            return "rainbow"
//        case .treatment:
//            return "rainbow"
//        case .eyeCream:
//            return "rainbow"
//        case .moisturizer:
//            return "rainbow"
//        case .sunscreen:
//            return "rainbow"
//        }
//    }
//}
//

