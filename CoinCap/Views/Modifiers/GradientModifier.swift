//
//  GradientModifier.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import SwiftUI

struct GradientModifier: ViewModifier {
    let colors: [Color]
    let startPoint: UnitPoint
    let endPoint: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: colors),
                    startPoint: startPoint,
                    endPoint: endPoint
                )
            )
            .edgesIgnoringSafeArea(.bottom)
    }
}

extension View {
    func applyGradientBackground(colors: [Color] =
                                 [
                                    Color(hex: 0x6efaf5, opacity: 0.3),
                                    Color(hex: 0x0a28eb, opacity: 0.3)
                                 ],
                                 startPoint: UnitPoint = .top,
                                 endPoint: UnitPoint = .bottom) -> some View {
        self.modifier(GradientModifier(colors: colors, startPoint: startPoint, endPoint: endPoint))
    }
}
