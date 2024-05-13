//
//  Wallet.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import SwiftUI
import SwiftData
import FirebaseFirestoreSwift

struct Wallet: Identifiable, Codable, Hashable {
    // Properties
    @DocumentID var _id: String? // Firestore document ID
    var id: String
    var userId: String
    var name: String
    var category: String
    var startingBalance: Double
    var iconName: String
    var color: String
    var dateAdded: Date
    var lastUpdated: Date

    var accountBalanceText: String {
        if rawCategory == .creditCard {
            return "Available Credits"
        } else {
            return "Account Balance"
        }
    }
    
    var rawCategory: WalletCategory? {
        return WalletCategory.allCases.first(where: { category == $0.rawValue })
    }
}

extension Wallet {
    static var MOCK_WALLET = Wallet(id: NSUUID().uuidString, userId: NSUUID().uuidString, name: "Wallet #1", category: WalletCategory.wallet.rawValue, startingBalance: 0.0, iconName: "gear", color: "", dateAdded: .now, lastUpdated: .now)
    static var MOCK_CREDIT_CARD = Wallet(id: NSUUID().uuidString, userId: NSUUID().uuidString, name: "Credit Card #1", category: WalletCategory.creditCard.rawValue, startingBalance: 30000.0, iconName: "gear", color: "", dateAdded: .now, lastUpdated: .now)
    
}

struct ColorMapping {
    static let colorToString: [Color: String] = [
        .red: "Red",
        .green: "Green",
        .blue: "Blue",
        .yellow: "Yellow",
        .orange: "Orange",
        .purple: "Purple",
        .pink: "Pink",
        .cyan: "Cyan",
        .teal: "Teal",
        .indigo: "Indigo",
        .gray: "Gray",
        .brown: "Brown",
        .black: "Black"
    ]
    
    static let stringToColor: [String: Color] = Dictionary(uniqueKeysWithValues: colorToString.map { ($1, $0) })
}
