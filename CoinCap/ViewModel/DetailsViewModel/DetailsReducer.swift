////
////  DetailsReducer.swift
////  CoinCap
////
////  Created by Marina Lunts on 05.01.25.
////

import ComposableArchitecture
import Foundation

struct DetailsReducer: Reducer {
    struct State: Equatable {
        static func == (lhs: DetailsReducer.State, rhs: DetailsReducer.State) -> Bool {
            lhs.errorMessage == rhs.errorMessage &&
            lhs.response?.isEqual(to: rhs.response ?? .failure(NSError())) ?? (rhs.response == nil)
        }
        
        var asset: Asset
        
        var errorMessage: String?
        var response: Result<Asset, Error>?
    }
    
    enum Action {
        case fetchData
        case fetchResponse(Result<Asset, Error>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchData:
                state.errorMessage = nil
                state.response = nil
                return .run { [state = state] send in
                    let response = try await APIConfig.getAsset(by: state.asset.id)
                    await send(.fetchResponse(response))
                }
                
            case .fetchResponse(.success(let asset)):
                state.response = .success(asset)
                return .none
                
            case .fetchResponse(.failure(let error)):
                state.errorMessage = error.localizedDescription
                state.response = .failure(error)
                return .none
            }
        }
    }
}

