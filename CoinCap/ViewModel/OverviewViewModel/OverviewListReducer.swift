//
//  OverviewListReducer.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import ComposableArchitecture
import Foundation

class OverviewListReducer: Reducer {
    struct State: Equatable {
        static func == (lhs: OverviewListReducer.State, rhs: OverviewListReducer.State) -> Bool {
            lhs.assets == rhs.assets
        }
        
        let title = "Coins"
        var assets: [Asset] = []
        var isLoading: Bool = false
        var errorMessage: String? = nil
    }
    
    enum Action {
        case fetchAssets
        case fetchAssetsResponse(Result<[Asset], Error>)
    }
    
    @Dependency(\.fetchAssets) var fetchAssets
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchAssets:
            state.isLoading = true
            state.assets = []
            state.errorMessage = nil
            
            return .run { send in
                let response = await APIConfig.getAssets()
                await send(.fetchAssetsResponse(response))
            }
        case .fetchAssetsResponse(.success(let data)):
            state.isLoading = true
            state.assets = data
            return .none
            
        case .fetchAssetsResponse(.failure(let error)):
            state.isLoading = false
            state.errorMessage = error.localizedDescription
            return .none
        }
    }
}

extension DependencyValues {
    var fetchAssets: @Sendable () async throws -> [Asset] {
        get { self[FetchAssetsKey.self] }
        set { self[FetchAssetsKey.self] = newValue }
    }
    
    private enum FetchAssetsKey: DependencyKey {
        static let liveValue: @Sendable () async throws -> [Asset] = {
            let result = await APIConfig.getAssets()
            switch result {
            case .success(let assets): return assets
            case .failure(let error): throw error
            }
        }
    }
}
