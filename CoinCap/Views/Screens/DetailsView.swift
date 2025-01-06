//
//  DetailsView.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import SwiftUI
import ComposableArchitecture

struct DetailsView: View {
    @Environment(\.presentationMode) private var presentation
    private let store: StoreOf<DetailsReducer>
    
    init(for asset: Asset) {
        store = Store(
            initialState: .init(
                asset: asset
            ), reducer: {
                DetailsReducer()
            }
        )
    }
    
    enum Constants {
        static let headerHorizontalSpacing: CGFloat = 9
        static let horizontalSpacing: CGFloat = 16
        static let spacing: CGFloat = 24
        static let bottomSpacing: CGFloat = 62
        static let cornerRadius: CGFloat = 16
        static let imageHeight: CGFloat = 40
        
        static let textSize: CGFloat = 16
        static let headerTextSize: CGFloat = 32
        static let backgroundOpacity: CGFloat = 0.4
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: Constants.spacing) {
                headerView(text: viewStore.asset.name,
                           icon: viewStore.asset.iconURL)
                
                contentView
            }
            .applyGradientBackground()
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private func headerView(text: String,
                            icon: URL?) -> some View {
        HStack {
            Button {
                presentation.wrappedValue.dismiss()
            } label: {
                Image("chevron-left")
            }
            
            Spacer()
            
            Text(text)
                .boldText(size: Constants.headerTextSize)
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

private extension DetailsView {
    var contentView: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                switch viewStore.response {
                case .success(let asset):
                    infoView(for: asset)
                case .failure:
                    Text(viewStore.errorMessage ?? "")
                case nil:
                    ZStack(alignment: .top) {
                        infoView(for: viewStore.asset)
                        loadingView
                    }
                }
                
                Spacer()
            }
            .background(Color.white.opacity(Constants.backgroundOpacity))
            .cornerRadius(Constants.cornerRadius)
            .padding(.horizontal, Constants.horizontalSpacing)
            .padding(.bottom, Constants.bottomSpacing)
            .task {
                viewStore.send(.fetchData)
            }
        }
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
                .regularText(size: Constants.textSize)
            
            Spacer()
            
            Text(value)
                .boldText(size: Constants.textSize, color: highlightColor)
        }
    }
    
    var loadingView: some View {
        ZStack {
            Color.white.opacity(Constants.backgroundOpacity)
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    DetailsView(for: .preview1)
}
