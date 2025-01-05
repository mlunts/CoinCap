//
//  OverviewListView.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import SwiftUI

struct OverviewListView: View {
    let title: String
    let items: [Asset]
    
    
    enum Constants {
        static let spacing: CGFloat = 16
        static let foregroundTextColor: Color = .init(hex: 0x292E33)
        static let titleHeight: CGFloat = 55
        static let padding: CGFloat = 16
        static let gradientColors = [
            Color(hex: 0x6efaf5, opacity: 0.3),
            Color(hex: 0x0a28eb, opacity: 0.3)
        ]
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(title)
                    .boldText(size: 32)
                    .foregroundStyle(Constants.foregroundTextColor)
                    .textCase(.uppercase)
                    .frame(height: Constants.titleHeight)
                
                ScrollView {
                    VStack(spacing: Constants.spacing) {
                        ForEach(items) { asset in
                            OverviewListItemView(item: asset)
                        }
                    }
                }
            }
            .padding(Constants.padding)
            .background(LinearGradient(
                gradient: Gradient(colors: Constants.gradientColors),
                startPoint: .top,
                endPoint: .bottom
            ))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

#Preview {
    OverviewListView(
        title: "Coins",
        items: [
            .preview1,
            .preview2
        ]
    )
}
