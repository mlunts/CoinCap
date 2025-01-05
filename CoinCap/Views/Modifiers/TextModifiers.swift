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

// MARK: - Text Extension
extension Text {
    func boldText(size: CGFloat) -> some View {
        self.modifier(BoldTextModifier(fontSize: size))
    }
    
    func regularText(size: CGFloat) -> some View {
        self.modifier(RegularTextModifier(fontSize: size))
    }
}
