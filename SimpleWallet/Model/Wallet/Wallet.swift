//
//  Wallet.swift
//  SimpleWallet
//
//  Created by Tawan Boonma on 12/5/2567 BE.
//

import SwiftUI
import SwiftData

//protocol Wallet: PersistentModel {
//    // Properties
//    var name: String { get set }
//    var category: WalletCategory { get set }
//    var transactions: [Transaction] { get set }
//    var accountBalanceText: String { get set }
//    var startingBalance: Double { get set }
//}
//
//extension Wallet {
//    var balance: Double {
//        return transactions.reduce(0) { $0 + $1.amount }
//    }
//    
//    var totalIncome: Double {
//        return transactions
//            .filter({ $0.rawCategory == .income })
//            .reduce(0) { $0 + $1.amount }
//    }
//    
//    var totalExpense: Double {
//        return transactions
//            .filter({ $0.rawCategory == .expense })
//            .reduce(0) { $0 + $1.amount }
//    }
//}

class Wallet {
    // Properties
    var hours: Int
    var name: String
    var category: WalletCategory
    var transactions: [Transaction]
    var accountBalanceText: String
    var startingBalance: Double
    
    init(name: String, category: WalletCategory, transactions: [Transaction], accountBalanceText: String, startingBalance: Double) {
        self.name = name
        self.category = category
        self.transactions = transactions
        self.accountBalanceText = accountBalanceText
        self.startingBalance = startingBalance
        self.hours = 0
    }
    
    var balance: Double {
        return transactions.reduce(0) { $0 + $1.amount }
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
}

class DebitWallet: Wallet {
    override init(name: String, category: WalletCategory, transactions: [Transaction], accountBalanceText: String, startingBalance: Double = 0) {
        super.init(name: name, category: category, transactions: transactions, accountBalanceText: "Account Balance", startingBalance: startingBalance)
    }
}

class CreditWallet: Wallet {
    override init(name: String, category: WalletCategory, transactions: [Transaction], accountBalanceText: String, startingBalance: Double) {
        super.init(name: name, category: category, transactions: transactions, accountBalanceText: "Available Credits", startingBalance: startingBalance)
    }
    
    override var balance: Double {
        let totalExpense = transactions.reduce(0) { $0 + $1.amount }
        return startingBalance - totalExpense
    }
}
