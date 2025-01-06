//
//  TextModifiers.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import SwiftUI

enum ColorConstants {
    static let foregroundTextColor: Color = .init(hex: 0x292E33)
    static let negativeColor: Color = .init(hex: 0xe54560)
    static let positiveColor: Color = .init(hex: 0x1fcc8f)
    static let dividerColor: Color = .init(hex: 0x0a28eb)
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
