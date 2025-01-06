//
//  APIConfig.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

enum APIConfig {
    static var urlSession: URLSessionProtocol = URLSession.shared
    static let baseUrl = "https://api.coincap.io"
    
    static func getAssets(limit: Int = 10) async -> Result<[Asset], Error> {
        let assetsPath = "/v2/assets?limit=\(limit)"
        return await fetch(urlPath: assetsPath, responseType: AssetsResponse.self).map { $0.data }
    }
    
    static func getAsset(by id: String) async -> Result<Asset, Error> {
        let assetPath = "/v2/assets/\(id)"
        return await fetch(urlPath: assetPath, responseType: AssetResponse.self).map { $0.data }
    }
}

private extension APIConfig {
    static func fetch<T: Decodable>(urlPath: String, responseType: T.Type) async -> Result<T, Error> {
        guard let url = URL(string: baseUrl + urlPath) else {
            return .failure(URLError(.badURL))
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return .failure(URLError(.badServerResponse))
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                return .success(decodedResponse)
            } catch {
                return .failure(URLError(.cannotDecodeRawData))
            }
        } catch {
            return .failure(error)
        }
    }
}
