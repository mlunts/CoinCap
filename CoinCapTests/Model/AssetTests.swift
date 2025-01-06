//
//  AssetTests.swift
//  CoinCapTests
//
//  Created by Marina Lunts on 05.01.25.
//

import XCTest
@testable import CoinCap

final class AssetTests: XCTestCase {
    func testPercentageChangeFormatting() {
        let asset = Asset.preview1
        XCTAssertEqual(asset.percentageChange, "5.12%")
    }
    
    func testIsPositivePercentageChange() {
        let positiveChangeAsset = Asset.preview1
        
        let negativeChangeAsset = Asset.preview2
        
        XCTAssertTrue(positiveChangeAsset.isPositivePercentageChange)
        XCTAssertFalse(negativeChangeAsset.isPositivePercentageChange)
    }
    
    func testPriceFormatting() {
        let asset = Asset.preview1
        
        XCTAssertEqual(asset.priceUsd.compactDollarSum, "$43K")
    }

}
