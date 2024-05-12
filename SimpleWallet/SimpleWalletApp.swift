//
//  SimpleWalletApp.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck

@main
struct SimpleWalletApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
        .modelContainer(for: [Transaction.self])
    }
}
