//
//  Asset.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import Foundation
struct Asset: Identifiable, Codable, Equatable {
    let id: String
    let symbol: String
    let name: String
    let supply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let priceUsd: String?
    let changePercent24Hr: String?
    
    var percentageChange: String {
           if let change = changePercent24Hr, let value = Double(change) {
               return String(format: "%.2f%%", value)
           }
           return "0.00%"
       }
       
       var price: String {
           if let price = priceUsd, let value = Double(price) {
               return "$" + String(format: "%.2f", value)
           }
           return "$0.00"
       }
    
    var iconURL: URL? {
        URL(string: "https://assets.coincap.io/assets/icons/\(symbol.lowercased())@2x.png")
    }
}

struct AssetResponse: Codable {
    let data: [Asset]
}
