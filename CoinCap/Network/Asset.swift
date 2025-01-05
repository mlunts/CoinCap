//
//  Asset.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import Foundation
struct Asset: Identifiable, Codable {
    let id: String
    let symbol: String
    let name: String
    let supply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let priceUsd: String?
    let changePercent24Hr: String?
}

struct AssetResponse: Codable {
    let data: [Asset]
}
