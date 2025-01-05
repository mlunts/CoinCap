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
    let supply: String
    let marketCapUsd: String
    let volumeUsd24Hr: String
    let priceUsd: String
    private let changePercent24Hr: String
    
    init(id: String, symbol: String, name: String, supply: String, marketCapUsd: String, volumeUsd24Hr: String, priceUsd: String, changePercent24Hr: String) {
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
        if let value = Double(changePercent24Hr) {
            return String(format: "%.2f%%", value)
        }
        return "0.00%"
    }
    
    var isPositivePercentageChange: Bool {
        !percentageChange.hasPrefix("-")
    }
    
    var iconURL: URL? {
        URL(string: "https://assets.coincap.io/assets/icons/\(symbol.lowercased())@2x.png")
    }
}

struct AssetResponse: Codable {
    let data: [Asset]
}

extension String {
    var compactSum: Self {
        if let value = Double(self) {
            return String(value.formatted(.number.notation(.compactName).locale(Locale(identifier: "en_US"))))
        }
        return "0.00"
    }
    
    var compactDollarSum: Self {
        return "$" + compactSum
    }
}
