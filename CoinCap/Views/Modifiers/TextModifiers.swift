//
//  TextModifiers.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import SwiftUI

// MARK: - Text Modifiers
struct BoldTextModifier: ViewModifier {
    let fontSize: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Poppins-Bold", size: fontSize))
    }
}

struct RegularTextModifier: ViewModifier {
    let fontSize: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Poppins-Regular", size: fontSize))
    }
}

struct AssetChangeColorModifier: ViewModifier {
    let isPositive: Bool
    let fontSize: CGFloat
    
    private let negativeColor: Color = .init(hex: 0xe54560)
    private let positiveColor: Color = .init(hex: 0x1fcc8f)
    
    func body(content: Content) -> some View {
        content
            .modifier(BoldTextModifier(fontSize: fontSize))
            .foregroundStyle(isPositive ? positiveColor : negativeColor)
    }
}

// MARK: - Text Extension
extension Text {
    func boldText(size: CGFloat) -> some View {
        self.modifier(BoldTextModifier(fontSize: size))
    }
    
    func regularText(size: CGFloat) -> some View {
        self.modifier(RegularTextModifier(fontSize: size))
    }
    
    func assetChangeText(isPositive: Bool, size: CGFloat) -> some View {
        self.modifier(AssetChangeColorModifier(isPositive: isPositive, fontSize: size))
    }
}
