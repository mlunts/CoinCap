//
//  ErrorView.swift
//  CoinCap
//
//  Created by Marina Lunts on 06.01.25.
//

import SwiftUI

struct ErrorView: View {
    let text: String
    var body: some View {
        Text(text)
            .regularText(size: 20)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
    }
}

#Preview {
    ErrorView(text: "No Internet Connection")
}
