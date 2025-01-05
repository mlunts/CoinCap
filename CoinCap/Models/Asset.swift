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
    private let supply: String?
    private let marketCapUsd: String?
    private let volumeUsd24Hr: String?
    private let priceUsd: String?
    private let changePercent24Hr: String?
    
    init(id: String, symbol: String, name: String, supply: String?, marketCapUsd: String?, volumeUsd24Hr: String?, priceUsd: String?, changePercent24Hr: String?) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.supply = supply
        self.marketCapUsd = marketCapUsd
        self.volumeUsd24Hr = volumeUsd24Hr
        self.priceUsd = priceUsd
        self.changePercent24Hr = changePercent24Hr
    }
}

// MARK: Calculated values
extension Asset {
    var percentageChange: String {
        if let change = changePercent24Hr, let value = Double(change) {
            return String(format: "%.2f%%", value)
        }
        return "0.00%"
    }
    
    var isPositivePercentageChange: Bool {
        percentageChange.hasPrefix("+")
    }
    
    var price: String {
        if let price = priceUsd, let value = Double(price) {
            return "$" + String(value.formatted(.number.notation(.compactName).locale(Locale(identifier: "en_US"))))
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
