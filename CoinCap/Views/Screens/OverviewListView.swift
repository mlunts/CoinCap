//
//  OverviewListView.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import SwiftUI
import ComposableArchitecture

struct OverviewListView: View {
    let store: Store<OverviewListReducer.State, OverviewListReducer.Action>
    
    enum Constants {
        static let spacing: CGFloat = 16
        static let foregroundTextColor: Color = .init(hex: 0x292E33)
        static let titleHeight: CGFloat = 55
        static let padding: CGFloat = 16
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack(alignment: .leading) {
                    titleView(with: viewStore.state.title)
                    
                    if viewStore.assets.isEmpty {
                        loadingView
                    } else {
                        listView(with: viewStore)
                    }
                }
                .padding(Constants.padding)
                .applyGradientBackground()
                .edgesIgnoringSafeArea(.bottom)
            }
            .onAppear {
                viewStore.send(.fetchAssets)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
    
    func titleView(with text: String) -> some View {
        Text(text)
            .boldText(size: 32)
            .foregroundStyle(Constants.foregroundTextColor)
            .textCase(.uppercase)
            .frame(height: Constants.titleHeight)
    }
    
    var loadingView: some View {
        ZStack {
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func listView(with viewStore: ViewStore<OverviewListReducer.State, OverviewListReducer.Action>) -> some View {
        ScrollView {
            VStack(spacing: Constants.spacing) {
                ForEach(viewStore.state.assets) { asset in
                    OverviewListItemView(item: asset)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    OverviewListView(
        store: Store(
            initialState: OverviewListReducer.State(),
            reducer: OverviewListReducer.init
        )
    )
}
