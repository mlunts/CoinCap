//
//  APIConfig.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import Foundation

enum APIConfig {
    static let baseUrl = "https://api.coincap.io"
    
    static func getAssets(limit: Int = 10) async throws -> Result<[Asset], Error> {
        let assetsPath = "/v2/assets?limit=\(limit)"
        
        guard let assetsUrl = URL(string: baseUrl + assetsPath) else {
            return .failure(URLError(.badURL))
        }
        
        do {
            let assetRequest = URLRequest(url: assetsUrl)
            let (data, response) = try await URLSession.shared.data(for: assetRequest)
            
            if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode == 200 else {
                    return .failure(URLError(.badServerResponse))
                }
            }
            
            do {
                let response = try JSONDecoder().decode(AssetResponse.self, from: data)
                return .success(response.data)
            } catch {
                print("Unexpected decoding error: \(error.localizedDescription)")
                return .failure(error)
            }
        } catch {
            print("Network error: \(error.localizedDescription)")
            return .failure(URLError(.badServerResponse))
        }
    }
}
