//
//  CoinCapApp.swift
//  CoinCap
//
//  Created by Marina Lunts on 04.01.25.
//

import SwiftUI
import ComposableArchitecture
@main
struct CoinCapApp: App {
    var body: some Scene {
        WindowGroup {
            OverviewListView(
                store: Store(
                    initialState: OverviewListReducer.State(),
                    reducer: OverviewListReducer.init
                )
            )
        }
    }
}
