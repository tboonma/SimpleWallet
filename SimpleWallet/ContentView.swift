//
//  ContentView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import SwiftUI

struct ContentView: View {
    // Visibility Status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    // Active Tab
    @State private var activeTab: Tab = .home

    var body: some View {
        TabView(selection: $activeTab) {
            Home()
                .tabItem { Tab.home.tabContent }
                .tag(Tab.home)
            Transactions()
                .tabItem { Tab.transactions.tabContent }
                .tag(Tab.transactions)
            Budgets()
                .tabItem { Tab.budgets.tabContent }
                .tag(Tab.budgets)
            Settings()
                .tabItem { Tab.settings.tabContent }
                .tag(Tab.settings)
        }
        .tint(appTint)
        .sheet(isPresented: $isFirstTime, content: {
            IntroScreen().interactiveDismissDisabled()
        })
        
    }
}

#Preview {
    ContentView()
}
