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
    }
    
    
    var body: some View{
        VStack{
            headerView(text: title, icon: iconURL)
            
            Spacer()
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

#Preview {
    let asset = Asset.preview1
    DetailsView(title: asset.name, iconURL: asset.iconURL)
}
