//
//  Asset.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import Foundation

struct Asset: Identifiable {
    let id: String
    let iconURL: URL?
    let name: String
    let symbol: String
    let price: String
    let percentageChange: String
}
