//
//  OverviewListReducerTests.swift
//  CoinCap
//
//  Created by Marina Lunts on 06.01.25.
//
import Foundation
import XCTest
import ComposableArchitecture
@testable import CoinCap

class OverviewListReducerTests: XCTestCase {
    var assets: [Asset]!
    
    override func setUp() {
        super.setUp()
        assets = [.preview1, .preview2]
    }
    
    func testFetchData_success() async {
        let mockResponseData = try! JSONEncoder().encode(AssetsResponse(data: assets))
        let mockResponse = HTTPURLResponse(url: URL(string: "https://api.coincap.io")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
        let mockURLSession = MockURLSession(dataResult: .success((mockResponseData, mockResponse)))
        
        APIConfig.urlSession = mockURLSession
        
        let store = await TestStore(
            initialState: .init(
                title: ""
            ), reducer: {
                OverviewListReducer()
            }
        )
        
        await store.send(.fetchData)
        
        // Assert
        await store.receive(.fetchResponse(.success(assets))) {
            $0.response = .success(self.assets)
        }
    }
    
    func testStateEquality() {
        let state1 = OverviewListReducer.State(title: "Coins", response: .success(assets))
        let state2 = OverviewListReducer.State(title: "Coins", response: .success(assets))
        
        XCTAssertEqual(state1, state2)
    }
}
