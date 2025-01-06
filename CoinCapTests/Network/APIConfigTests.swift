//
//  APIConfigTests.swift
//  CoinCap
//
//  Created by Marina Lunts on 06.01.25.
//
import XCTest
@testable import CoinCap

final class APIConfigTests: XCTestCase {
    class MockURLSession: URLSessionProtocol {
        var mockData: Data?
        var mockResponse: URLResponse?
        var mockError: Error?
        
        func data(for request: URLRequest) async throws -> (Data, URLResponse) {
            if let error = mockError {
                throw error
            }
            return (mockData!, mockResponse!)
        }
    }
    
    func testGetAssets_success() async {
        let mockAsset1 = Asset.preview1
        let mockAsset2 = Asset.preview2
        let mockAssetsResponse = AssetsResponse(data: [mockAsset1, mockAsset2])
        let mockData = try! JSONEncoder().encode(mockAssetsResponse)
        let mockURLResponse = HTTPURLResponse(url: URL(string: "https://api.coincap.io")!,
                                              statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let mockSession = MockURLSession()
        mockSession.mockData = mockData
        mockSession.mockResponse = mockURLResponse
        APIConfig.urlSession = mockSession
        
        let result = await APIConfig.getAssets(limit: 2)
        
        switch result {
        case .success(let assets):
            XCTAssertEqual(assets.count, 2)
            XCTAssertEqual(assets.first?.name, "Bitcoin")
            XCTAssertEqual(assets.first?.priceUsd, "43000")
        case .failure:
            XCTFail("Expected success — got failure")
        }
    }
    
    func testGetAssets_failure() async {
        let mockSession = MockURLSession()
        mockSession.mockError = URLError(.timedOut)
        APIConfig.urlSession = mockSession
        
        let result = await APIConfig.getAssets(limit: 1)
        
        switch result {
        case .success:
            XCTFail("Got success — expected failure")
        case .failure(let error):
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .timedOut)
        }
    }
    
    func testGetAsset_success() async {
        let mockAsset = Asset.preview1
        let mockAssetResponse = AssetResponse(data: mockAsset)
        let mockData = try! JSONEncoder().encode(mockAssetResponse)
        let mockURLResponse = HTTPURLResponse(url: URL(string: "https://api.coincap.io")!,
                                               statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let mockSession = MockURLSession()
        mockSession.mockData = mockData
        mockSession.mockResponse = mockURLResponse
        APIConfig.urlSession = mockSession
        
        let result = await APIConfig.getAsset(by: "bitcoin")
        
        switch result {
        case .success(let asset):
            XCTAssertEqual(asset.id, "bitcoin")
            XCTAssertEqual(asset.name, "Bitcoin")
            XCTAssertEqual(asset.priceUsd, "43000")
        case .failure:
            XCTFail("Expected success — got failure")
        }
    }
    
    func testGetAsset_failure() async {
        let mockSession = MockURLSession()
        mockSession.mockError = URLError(.notConnectedToInternet)
        APIConfig.urlSession = mockSession
        
        let result = await APIConfig.getAsset(by: "")
        
        switch result {
        case .success:
            XCTFail("Expected failure — got success")
        case .failure(let error):
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
        }
    }
}
