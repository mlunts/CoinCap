//
//  OverviewListItemView.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import SwiftUI

struct OverviewListItemView: View {
    private let id: String
    private let iconURL: URL?
    private let name: String
    private let symbol: String
    private let price: String
    private let percentageChange: String
    
    enum Constants {
        static let height: CGFloat = 117
        static let spacing: CGFloat = 16
        static let leadingPadding: CGFloat = 12
        
        static let imageHeight: CGFloat = 56
        
        static let titleFontSize: CGFloat = 20
        static let subtitleFontSize: CGFloat = 16
        static let percentageFontSize: CGFloat = 16
        
        static let titleViewHeight: CGFloat = 14
        static let subtitleViewHeight: CGFloat = 11
        static let buttonViewHeight: CGFloat = 24
    }
    
    init(id: String, iconURL: URL?, name: String, symbol: String, price: String, percentageChange: String) {
        self.id = id
        self.iconURL = iconURL
        self.name = name
        self.symbol = symbol
        self.price = price
        self.percentageChange = percentageChange
    }
    
    var body: some View {
        HStack(alignment: .top,
               spacing: Constants.spacing) {
            AsyncImage(url: iconURL) { image in
                image.image?.resizable()
            }
            .frame(width: Constants.imageHeight,
                   height: Constants.imageHeight)
            
            infoView
        }
               .frame(height: Constants.height)
               .padding([.vertical, .trailing], Constants.spacing)
               .padding(.leading, Constants.leadingPadding)
        
    }
    
    var infoView: some View {
        VStack(alignment: .leading,
               spacing: Constants.spacing) {
            titleView
            subtitleView
            buttonView
            Spacer()
        }
    }
    
    var titleView: some View {
        HStack {
            Text(name)
                .font(.custom("Poppins-Bold", size: Constants.titleFontSize))
            
            Spacer()
            
            Text(price)
                .font(.custom("Poppins-Bold", size: Constants.subtitleFontSize))
        }
        .frame(height: Constants.titleViewHeight)
    }
    
    var subtitleView: some View {
        HStack {
            Text(symbol)
                .font(.custom("Poppins-Regular", size: Constants.subtitleFontSize))
            
            Spacer()
            
            Text(percentageChange)
                .font(.custom("Poppins-Bold", size: Constants.percentageFontSize))
                .foregroundColor(percentageChange.hasPrefix("-") ? .red : .green)
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
        id: "bitcoin",
        iconURL: URL(string: "https://assets.coincap.io/assets/icons/btc@2x.png"),
        name: "Bitcoin",
        symbol: "BTC",
        price: "$97,446.39",
        percentageChange: "-0.54%"
    )
}
