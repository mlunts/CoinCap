//
//  Asset+Preview.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

extension Asset {
    static let preview1 = Self(
        id: "bitcoin",
        symbol: "BTC",
        name: "Bitcoin",
        supply: "19000000",
        marketCapUsd: "600000000000",
        volumeUsd24Hr: "20000000000",
        priceUsd: "30000",
        changePercent24Hr: "-0.54"
    )
    
    static let preview2 = Self(
        id: "ethereum",
        symbol: "ETH",
        name: "Ethereum",
        supply: "120000000",
        marketCapUsd: "200000000000",
        volumeUsd24Hr: "10000000000",
        priceUsd: "1800",
        changePercent24Hr: "0.44"
    )
}
