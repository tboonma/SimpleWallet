//
//  ContentView.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Visibility Status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    // Active Tab
    @State private var activeTab: Tab = .home
    @EnvironmentObject var viewModel: ViewModel
    @State private var isLoginViewPresented = false

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
        .sheet(isPresented: $isLoginViewPresented, content: {
            LoginView().interactiveDismissDisabled()
        })
        .onReceive(viewModel.$currentUser) { currentUser in
            if currentUser == nil && viewModel.userSession == nil {
                isLoginViewPresented = true
            } else {
                isLoginViewPresented = false
            }
        }
    }
}

//#Preview {
//    @StateObject var viewModel = AuthViewModel()
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: Transaction.self, configurations: config)
//    return ContentView().environmentObject(viewModel).modelContainer(container)
//}
