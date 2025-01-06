//
//  OverviewListReducer.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import ComposableArchitecture
import Foundation

struct OverviewListReducer: Reducer {
    struct State: Equatable {
        static func == (lhs: OverviewListReducer.State, rhs: OverviewListReducer.State) -> Bool {
            lhs.response?.isEqual(to: rhs.response ?? .failure(NSError())) ?? (rhs.response == nil)
        }
        
        var title: String
        var response: Result<[Asset], Error>?
    }
    
    enum Action: Equatable {
        static func == (lhs: OverviewListReducer.Action, rhs: OverviewListReducer.Action) -> Bool {
            switch (lhs, rhs) {
            case (.fetchData, .fetchData):
                true
            case (.fetchResponse, .fetchResponse):
                true
            default:
                false
            }
        }
        
        case fetchData
        case fetchResponse(Result<[Asset], Error>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchData:
                state.response = nil
                return .run { send in
                    let response = await APIConfig.getAssets()
                    await send(.fetchResponse(response))
                }
                
            case .fetchResponse(.success(let asset)):
                state.response = .success(asset)
                return .none
                
            case .fetchResponse(.failure(let error)):
                state.response = .failure(error)
                return .none
            }
        }
    }
}
