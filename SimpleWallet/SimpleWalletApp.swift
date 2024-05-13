//
//  SimpleWalletApp.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 9/5/2567 BE.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck
import SwiftData

@main
struct SimpleWalletApp: App {
    @StateObject var viewModel = ViewModel()
    let modelContainer: ModelContainer
    
    init() {
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        FirebaseApp.configure()
        
        do {
            modelContainer = try ModelContainer(for: Transaction.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
        .modelContainer(modelContainer)
    }
}
