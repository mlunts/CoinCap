//
//  OverviewListItemView.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import SwiftUI

struct OverviewListItemView: View {
    private let iconURL: URL?
    private let name: String
    private let symbol: String
    private let price: String
    private let percentageChange: String
    private let isPositivePercentageChange: Bool
    
    enum Constants {
        static let spacing: CGFloat = 16
        static let cornerRadius: CGFloat = 16
        static let leadingPadding: CGFloat = 12
        static let backgroundColor: Color = .white.opacity(0.4)
        
        static let imageHeight: CGFloat = 56
        
        static let titleFontSize: CGFloat = 20
        static let subtitleFontSize: CGFloat = 16
        static let percentageFontSize: CGFloat = 16
        
        static let titleViewHeight: CGFloat = 14
        static let subtitleViewHeight: CGFloat = 11
        static let buttonViewHeight: CGFloat = 24
        
        static let titleViewTopPadding: CGFloat = 4
    }
    
    init(item: Asset) {
        self.iconURL = item.iconURL
        self.name = item.name
        self.symbol = item.symbol
        self.price = item.priceUsd.compactDollarSum
        self.percentageChange = item.percentageChange
        isPositivePercentageChange = item.isPositivePercentageChange
    }
    
    var body: some View {
        HStack(alignment: .top,
               spacing: Constants.spacing) {
            iconView
            
            infoView
        }
        .padding([.vertical, .trailing], Constants.spacing)
        .padding(.leading, Constants.leadingPadding)
        .background(Constants.backgroundColor)
        .cornerRadius(Constants.cornerRadius)
    }
    
    var iconView: some View {
        AsyncImage(url: iconURL) { image in
            image.image?.resizable()
        }
        .frame(width: Constants.imageHeight,
               height: Constants.imageHeight)
    }
    
    var infoView: some View {
        VStack(alignment: .leading,
               spacing: Constants.spacing) {
            titleView
            subtitleView
            buttonView
        }
    }
    
    var titleView: some View {
        HStack {
            Text(name)
                .boldText(size: Constants.titleFontSize)
                .textCase(.uppercase)
            
            Spacer()
            
            Text(price)
                .boldText(size: Constants.subtitleFontSize)
        }
        .frame(height: Constants.titleViewHeight)
        .padding(.top, Constants.titleViewTopPadding)
    }
    
    var subtitleView: some View {
        HStack {
            Text(symbol)
                .regularText(size: Constants.subtitleFontSize)
            
            Spacer()
            
            Text(percentageChange)
                .assetChangeText(isPositive: isPositivePercentageChange,
                                 size: Constants.percentageFontSize)
        }
        .frame(height: Constants.subtitleViewHeight)
    }
    
    var buttonView: some View {
        HStack {
            Spacer()
            Image("arrow")
                .resizable()
                .scaledToFit()
                .frame(height: Constants.buttonViewHeight)
        }
    }
}

#Preview {
    OverviewListItemView(
        item: .preview1
    )
}
