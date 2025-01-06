//
//  OverviewListView.swift
//  CoinCap
//
//  Created by Marina Lunts on 05.01.25.
//

import SwiftUI
import ComposableArchitecture

struct OverviewListView: View {
    let store: StoreOf<OverviewListReducer>
    
    enum Constants {
        static let spacing: CGFloat = 16
       
        static let titleHeight: CGFloat = 55
        static let padding: CGFloat = 16
    }
    
    init(title: String) {
        store = Store(
            initialState: .init(
                title: title
            ), reducer: {
                OverviewListReducer()
            }
        )
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack(alignment: .leading) {
                    titleView(with: viewStore.state.title)
                    
                    switch viewStore.response {
                    case .success(let assets):
                        listView(with: assets)
                    case .failure(let error):
                        Text(error.localizedDescription)
                    case nil:
                        loadingView
                    }
                }
                .padding(Constants.padding)
                .applyGradientBackground()
                .edgesIgnoringSafeArea(.bottom)
            }
            .onAppear {
                viewStore.send(.fetchData)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
    
    func titleView(with text: String) -> some View {
        Text(text)
            .boldText(size: 32)
            .textCase(.uppercase)
            .frame(height: Constants.titleHeight)
    }
    
    var loadingView: some View {
        ZStack {
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func listView(with assets: [Asset]) -> some View {
        ScrollView {
            VStack(spacing: Constants.spacing) {
                ForEach(assets) { asset in
                    NavigationLink(destination: DetailsView(for: asset)) {
                        OverviewListItemView(item: asset)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    OverviewListView(
        title: "Coins"
    )
}
