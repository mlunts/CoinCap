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
        supply: "21000000",
        marketCapUsd: "900000000000",
        volumeUsd24Hr: "35000000000",
        priceUsd: "43000",
        changePercent24Hr: "5.12345"
    )
    
    static let preview2 = Self(
        id: "ethereum",
        symbol: "ETH",
        name: "Ethereum",
        supply: "114000000",
        marketCapUsd: "400000000000",
        volumeUsd24Hr: "20000000000",
        priceUsd: "3500.4567",
        changePercent24Hr: "-1.24"
    )
}
