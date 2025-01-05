//
//  DetailsView.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import SwiftUI

struct DetailsView: View {
    let title: String
    let iconURL: URL?
    @Environment(\.presentationMode) var presentation
    
    enum Constants {
        static let headerHorizontalSpacing: CGFloat = 9
        
        static let horizontalSpacing: CGFloat = 16
        static let spacing: CGFloat = 24
        static let bottomSpacing: CGFloat = 62
        static let cornerRadius: CGFloat = 16
        
        static let imageHeight: CGFloat = 40
    }
    
    
    var body: some View{
        VStack(spacing: Constants.spacing) {
            headerView(text: title, icon: iconURL)
            
            contentView
        }
        .applyGradientBackground()
        .navigationBarBackButtonHidden(true)
    }
    
    func headerView(text: String,
                    icon: URL?) -> some View {
        HStack {
            Button {
                presentation.wrappedValue.dismiss()
            } label: {
                Image("chevron-left")
            }

            Spacer()
            
            Text(text)
                .boldText(size: 32)
                .textCase(.uppercase)
            
            Spacer()
            
            AsyncImage(url: icon) { image in
                image.image?.resizable()
            }
            .frame(width: Constants.imageHeight,
                   height: Constants.imageHeight)
        }
        .padding(Constants.headerHorizontalSpacing)
    }
}

extension DetailsView {
    var contentView: some View {
        VStack {
            infoView(for: .preview1)
            
            Spacer()
        }
        .background(.white.opacity(0.4))
        .cornerRadius(Constants.cornerRadius)
        .padding(.horizontal, Constants.horizontalSpacing)
        .padding(.bottom, Constants.bottomSpacing)
    }
    
    func infoView(for asset: Asset) -> some View {
        VStack(spacing: Constants.spacing) {
            textCell(key: "Price", value: asset.priceUsd.compactDollarSum)
            textCell(key: "Change (24hr)", value: asset.percentageChange,
                     highlightColor: asset.isPositivePercentageChange ? ColorConstants.positiveColor : ColorConstants.negativeColor)
            
            Divider()
                .overlay(ColorConstants.dividerColor)
            
            textCell(key: "Market Cap", value: asset.marketCapUsd.compactDollarSum)
            textCell(key: "Volume (24hr)", value: asset.volumeUsd24Hr.compactDollarSum)
            textCell(key: "Supply", value: asset.supply.compactSum)
        }
        .padding(Constants.spacing)
    }
    
    func textCell(key: String,
                  value: String,
                  highlightColor: Color = ColorConstants.foregroundTextColor) -> some View {
        HStack {
            Text(key)
                .regularText(size: 16)
            
            Spacer()
            
            Text(value)
                .boldText(size: 16, color: highlightColor)
        }
    }
}

#Preview {
    let asset = Asset.preview1
    DetailsView(title: asset.name, iconURL: asset.iconURL)
}
