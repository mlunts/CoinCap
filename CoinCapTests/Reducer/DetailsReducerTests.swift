//
//  DetailsReducerTests.swift
//  CoinCap
//
//  Created by Marina Lunts on 06.01.25.
//
import Foundation
import XCTest
import ComposableArchitecture
@testable import CoinCap

class DetailsReducerTests: XCTestCase {
    var asset: Asset!
    
    override func setUp() {
        super.setUp()
        asset = .preview1
    }

    func testFetchData_success() async {
        // Arrange
        let mockAsset = Asset.preview1
        let mockResponseData = try! JSONEncoder().encode(AssetResponse(data: mockAsset))
        let mockResponse = HTTPURLResponse(url: URL(string: "https://api.coincap.io")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
        let mockURLSession = MockURLSession(dataResult: .success((mockResponseData, mockResponse)))
        
        APIConfig.urlSession = mockURLSession
        
        let store = await TestStore(
            initialState: .init(
                asset: asset
            ), reducer: {
                DetailsReducer()
            }
        )
        
        await store.send(.fetchData)
        
        await store.receive(.fetchResponse(.success(mockAsset))) {
            $0.response = .success(mockAsset)
        }
    }

    func testFetchData_failure() async {
        let mockError = NSError(domain: "test", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test error"])
        let mockURLSession = MockURLSession(dataResult: .failure(mockError))
        
        APIConfig.urlSession = mockURLSession
        
        let store = await TestStore(
            initialState: .init(
                asset: asset
            ), reducer: {
                DetailsReducer()
            }
        )
        
        await store.send(.fetchData)
        
        await store.receive(.fetchResponse(.failure(mockError))) {
            $0.errorMessage = mockError.localizedDescription
            $0.response = .failure(mockError)
        }
    }
}
