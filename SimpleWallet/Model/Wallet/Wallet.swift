//
//  Wallet.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import SwiftUI
import SwiftData

class Wallet: Identifiable, Codable {
    // Properties
    var id: String
    var userId: String
    var hours: Int
    var name: String
    var category: String
    var startingBalance: Double
    var dateAdded: Date
    var lastUpdated: Date

    var balance: Double {
        if category == .creditCard {
            let totalExpense = transactions.reduce(0) { $0 + $1.amount }
            return startingBalance - totalExpense
        } else {
            return transactions.reduce(0) { $0 + $1.amount }
        }
    }
    
    var totalIncome: Double {
        return transactions
            .filter({ $0.rawCategory == .income })
            .reduce(0) { $0 + $1.amount }
    }
    
    var totalExpense: Double {
        return transactions
            .filter({ $0.rawCategory == .expense })
            .reduce(0) { $0 + $1.amount }
    }
    
    var accountBalanceText: String {
        if category == .creditCard {
            return "Available Credits"
        } else {
            return "Account Balance"
        }
    }
    
    var rawCategory: WalletCategory? {
        return WalletCategory.allCases.first(where: { category == $0.rawValue })
    }
}
