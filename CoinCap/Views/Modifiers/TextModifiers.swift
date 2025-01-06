//
//  TextModifiers.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import SwiftUI

enum ColorConstants {
    static let foregroundTextColor: Color = .init("gray10")
    static let negativeColor: Color = .init("red10")
    static let positiveColor: Color = .init("lightGreen")
    static let dividerColor: Color = .init("darkBlue")
}

// MARK: - Text Modifiers
struct BoldTextModifier: ViewModifier {
    let fontSize: CGFloat
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Poppins-Bold", size: fontSize))
            .foregroundStyle(color)
    }
}

struct RegularTextModifier: ViewModifier {
    let fontSize: CGFloat
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Poppins-Regular", size: fontSize))
            .foregroundStyle(color)
    }
}

struct AssetChangeColorModifier: ViewModifier {
    let isPositive: Bool
    let fontSize: CGFloat
    
    func body(content: Content) -> some View {
        content
            .modifier(BoldTextModifier(fontSize: fontSize,
                                       color: isPositive ? ColorConstants.positiveColor : ColorConstants.negativeColor))
    }
}

// MARK: - Text Extension
extension Text {
    func boldText(size: CGFloat, color: Color = ColorConstants.foregroundTextColor) -> some View {
        self.modifier(BoldTextModifier(fontSize: size, color: color))
    }
    
    func regularText(size: CGFloat, color: Color = ColorConstants.foregroundTextColor) -> some View {
        self.modifier(RegularTextModifier(fontSize: size, color: color))
    }
    
    func assetChangeText(isPositive: Bool, size: CGFloat) -> some View {
        self.modifier(AssetChangeColorModifier(isPositive: isPositive, fontSize: size))
    }
}
