//
//  ItemViewModel.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import Foundation
import SwiftUI
import SwiftData
import Firebase
import FirebaseFirestoreSwift

@MainActor
class ItemViewModel: ObservableObject {
    @EnvironmentObject var viewModel: AuthViewModel
    
    func createWallet(user: Account, wallet: Wallet) async throws {
        do {
            wallet.userId = viewModel.currentUser?.id ?? ""
            let encodedWallet = try Firestore.Encoder().encode(wallet)
            try await Firestore.firestore().collection("wallets").document(wallet.id).setData(encodedWallet)
        } catch {
            print("DEEBUG: Failed to create wallet with error \(error.localizedDescription)")
        }
        
    }
}
