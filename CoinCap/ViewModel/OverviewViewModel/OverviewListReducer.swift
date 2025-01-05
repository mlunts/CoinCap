//
//  OverviewListReducer.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import SwiftUI
import ComposableArchitecture
import Foundation

class OverviewListReducer: Reducer {
    struct State {
        var assets: [Asset] = []
        
    }
    enum Action {
        case fetchAssets
        case fetchAssetsResponse(Result<[Asset], Error>)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchAssets:
            state.assets = []
            return .run { send in
                let response = try await APIConfig.getAssets()
                await send(.fetchAssetsResponse(response))
            }
        case .fetchAssetsResponse(.success(let data)):
            state.assets = data
            return .none
            
        case .fetchAssetsResponse(.failure(let error)):
            return .none
        }
    }
}
