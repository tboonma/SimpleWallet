//
//  AuthViewModel.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: Account?
    @Published var wallets: [Wallet] = []
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await FetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String, onSuccess: () -> () = {}, onFailed: (_ msg: String) -> () = {msg in }) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await FetchUser()
            onSuccess()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            onFailed(error.localizedDescription)
        }
    }
    
    func createUser(withEmail email: String, password: String, userName: String, onSuccess: () -> () = {}, onFailed: (_ msg: String) -> () = {msg in }) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = Account(id: result.user.uid, userName: userName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await FetchUser()
            onSuccess()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            onFailed(error.localizedDescription)
        }
    }
    
    func signOut(onSuccess: () -> ()) {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            onSuccess()
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }

    func FetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: Account.self)
        
        print("DEBUG: Current user is \(String(describing: self.currentUser))")
    }
    
    func createWallet(wallet: Wallet) async throws {
        do {
            let encodedWallet = try Firestore.Encoder().encode(wallet)
            try await Firestore.firestore().collection("wallets").document(wallet.id).setData(encodedWallet)
        } catch {
            print("DEEBUG: Failed to create wallet with error \(error.localizedDescription)")
        }
    }
    
    func getWallet() {
        Task {
            let userId: String = currentUser?.id ?? ""
            if userId == "" {
                return
            }
            let querySnapshot = try await Firestore.firestore().collection("wallets")
                .whereField("userId", isEqualTo: userId)
                .order(by: "lastUpdated", descending: true)
                .getDocuments()
            self.wallets = try querySnapshot.documents.compactMap { document -> Wallet? in
                return try document.data(as: Wallet.self)
            }
        }
    }
    
    func updateWallet(wallet: Wallet) async throws {
        do {
            let encodedWallet = try Firestore.Encoder().encode(wallet)
            try await Firestore.firestore().collection("wallets").document(wallet.id).setData(encodedWallet, merge: true)
        } catch {
            print("DEEBUG: Failed to create wallet with error \(error.localizedDescription)")
        }
    }
    
    func deleteWallet(walletId: String) async {
        do {
            let db = Firestore.firestore()
            let walletRef = db.collection("wallets").document(walletId)
            try await walletRef.delete()
        } catch {
            print("Error deleting wallet: \(error.localizedDescription)")
        }
    }
}
