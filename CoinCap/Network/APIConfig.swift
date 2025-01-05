//
//  APIConfig.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import Foundation

enum APIConfig {
    static func getAssets(limit: Int = 10) async throws -> Result<[Asset], Error> {
        let baseUrl = "https://api.coincap.io"
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
            } catch let DecodingError.dataCorrupted(context) {
                print("Data corrupted: \(context.debugDescription)")
                return .failure(DecodingError.dataCorrupted(context))
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found: \(context.debugDescription)")
                return .failure(DecodingError.keyNotFound(key, context))
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type '\(type)' mismatch: \(context.debugDescription)")
                return .failure(DecodingError.typeMismatch(type, context))
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found: \(context.debugDescription)")
                return .failure(DecodingError.valueNotFound(value, context))
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
