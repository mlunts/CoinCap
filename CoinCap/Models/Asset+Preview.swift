//
//  Asset+Preview.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import Foundation

extension Asset {
    static let preview1 = Self(
        id: "bitcoin",
        iconURL: URL(string: "https://assets.coincap.io/assets/icons/btc@2x.png"),
        name: "Bitcoin",
        symbol: "BTC",
        price: "$97388.7",
        percentageChange: "-0.54%"
    )
    
    static let preview2 = Self(
        id: "ethereum",
        iconURL: URL(string: "https://assets.coincap.io/assets/icons/eth@2x.png"),
        name: "Ethereum",
        symbol: "ETH",
        price: "$3603.31",
        percentageChange: "-1.03%"
    )
}
